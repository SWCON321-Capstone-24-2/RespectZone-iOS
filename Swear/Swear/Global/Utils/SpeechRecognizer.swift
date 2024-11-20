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
            case .notAuthorizedToRecognize: return "문장을 인식하는 중입니다..."
            case .notPermittedToRecord: return "오디오 녹음이 허용되지 않았습니다."
            case .recognizerIsUnavailable: return "음성 인식기를 현재 사용할 수 없습니다."
            }
        }
    }
        
    private var lastProcessedLength: Int = 0
    @MainActor @Published var transcript: String = ""
    @MainActor @Published var scores: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
    @MainActor @Published var level: Int = 0
    
    private let viewModel = RecordingViewModel()
    @MainActor private let formatter = ISO8601DateFormatter()
    
    private var audioEngine: AVAudioEngine?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private let audioPlayer = AudioPlayer()
    
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
            .filter { !$0.isEmpty }
            .sink { [weak self] transcript in
                guard let self else { return }
                Task { @MainActor in
                    let newTranscript = await self.extractNewTranscript(from: transcript)
                    guard !newTranscript.isEmpty else { return }
                    await self.checkForKeyword(in: newTranscript)
                }
            }.store(in: &cancellables)
    }
    
    @MainActor func startTranscribing() {
        Task {
            await transcibe()
        }
    }
    
    private func extractNewTranscript(from fullTranscript: String) -> String {
        let newTranscript = String(fullTranscript.dropFirst(lastProcessedLength))
        lastProcessedLength = fullTranscript.count
        return newTranscript
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
        
        try audioSession.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth, .allowBluetoothA2DP, .allowAirPlay])
        try audioSession.setMode(.voiceChat)
        try audioSession.setPreferredSampleRate(44100)
        try audioSession.setPreferredIOBufferDuration(0.005)
        try audioSession.setInputGain(1.0)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    // MARK: - transcribe function
    
    nonisolated private func transcribe(_ message: String) {
        Task { @MainActor in
            self.transcript = message
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
            transcript = "\(errorMessage)"
        }
    }
}

extension SpeechRecognizer {
    @MainActor
    private func checkForKeyword(in transcript: String) async {
        
        let timestampString = await formatter.string(from: Date())

        scores = await self.viewModel.postSentenceWithAPI(
            id: self.viewModel.newConservation.id,
            requestBody: PostSentenceRequestDTO(sentence: transcript, timestamp: timestampString)
        )
        
//        Task { @MainActor in
//            self.transcript = ""
//        }
        
        
//        if transcript.contains("바보") {
//            await self.audioPlayer.playSound(named: "swearSound") { 
//                self.audioPlayer.playSound(named: "bad1")
//            }
//            
//            await self.audioPlayer.playSound(named: "refreshSound") {
//                self.audioPlayer.playSound(named: "bad5")
//            }
//        }
    }
    
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechSynthesizer.speak(utterance)
    }
}
