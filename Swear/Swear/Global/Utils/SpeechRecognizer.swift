//
//  SpeechRecognizer.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import AVFoundation
import Combine
import Speech
import SwiftUI

actor SpeechRecognizer: ObservableObject {
    enum RecognizerError: Error {
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .notAuthorizedToRecognize: return "음성 인식 권한이 없습니다."
            case .notPermittedToRecord: return "오디오 녹음이 허용되지 않았습니다."
            case .recognizerIsUnavailable: return "음성 인식기를 현재 사용할 수 없습니다."
            }
        }
    }
    
    @MainActor @Published var transcript: String = ""
    @MainActor @Published var audioLevel: Float = 0.0
    
    private var audioEngine: AVAudioEngine?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    private var cancellables = Set<AnyCancellable>()
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    init() {
        Task {
            do {
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
                try await prepareBluetoothAudioSession()
                await subscribeTranscript()
            } catch {
                transcribe(error)
            }
        }
    }
    
    private func subscribeTranscript() {
        $transcript
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] transcript in
                Task {
                    await self?.checkForKeyword(in: transcript)
                }
                print("메서지 서버 전송 : \(transcript)")
            }.store(in: &cancellables)
    }
    
    @MainActor func startTranscribing() {
        Task {
            await transcibe()
        }
    }
    
    private func transcibe() {
        guard let speechRecognizer, speechRecognizer.isAvailable else {
            transcribe("음성 인식기를 현재 사용할 수 없습니다.")
            return
        }
        
        do {
            let (audioEngine, request) = try prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.recognitionTask = speechRecognizer.recognitionTask(with: request, resultHandler: { [weak self] result, error in
                if let result {
                    let message = result.bestTranscription.formattedString
                    self?.transcribe(message)
                }
                
                if (result?.isFinal ?? false || error != nil) {
                    Task {
                        await self?.audioEngine?.stop()
                        audioEngine.inputNode.removeTap(onBus: 0)
                    }
                }
            })
        } catch {
            self.reset()
        }
    }
    
    @MainActor func stopTranscribing() {
        Task {
            await reset()
        }
    }
    
    private func reset() {
        audioEngine?.stop()
        recognitionTask?.cancel()
        recognitionTask = nil
        request?.endAudio()
        request = nil
    }
    
    private func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.addsPunctuation = true
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    private func prepareBluetoothAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        
        try audioSession.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP])
        try audioSession.setMode(.default)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    // MARK: - transcribe function
    
    nonisolated private func transcribe(_ message: String) {
        Task { @MainActor in
            transcript = message
        }
    }
    
    nonisolated private func transcribe(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        Task { @MainActor [errorMessage] in
            transcript = "<< \(errorMessage) >>"
        }
    }
}

extension SpeechRecognizer {
    private func checkForKeyword(in transcript: String) {
        if transcript.contains("바보") {
            speak(text: "그런 나쁜말 사용하지 마세요")
        }
    }
    
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechSynthesizer.speak(utterance)
    }
}
