//
//  SpeechRecognizer.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import Foundation
import AVFoundation
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
    
    private var audioEngine: AVAudioEngine?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    init() {
        Task {
            do {
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                transcribe(error)
            }
        }
    }
    
    @MainActor func startTranscribing() {
        Task {
            await transcibe()
        }
    }
    
    @MainActor func resetTranscript() {
        Task {
            await reset()
        }
    }
    
    @MainActor func stopTranscribing() {
        Task {
            await reset()
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
                    self?.transcribe(result.bestTranscription.formattedString)
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
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    // MARK: - transcribe function
    
    nonisolated private func transcribe(_ message: String) {
        Task { @MainActor in
            transcript = message
            print("message: \(message)")
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
