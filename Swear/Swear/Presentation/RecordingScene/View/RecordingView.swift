//
//  ContentView.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import SwiftUI
import AVFoundation
import TipKit

struct RecordingView: View {
    
    @Binding var isPresentingRecordingView: Bool
    
    @StateObject private var viewModel = RecordingViewModel()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    @State private var recordingTime: TimeInterval = 0.0
    @State private var isRecording: Bool = false
    @State private var isShowAlert: Bool = false
    
    private let formatter = ISO8601DateFormatter()
    private var truncatedText: String {
        let maxLength = 50
        let text = speechRecognizer.transcript
        return text.count > maxLength ? "..\(text.suffix(maxLength))" : text
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                RecordingLevel(rawValue: speechRecognizer.level)?.backgroundColor
                    .ignoresSafeArea()
                VStack {
                    Text(durationFormatter(recordingTime, isSecondsDevide: true))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(RecordingLevel(rawValue: speechRecognizer.level)?.foregroundColor ?? .black)
                        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                            if isRecording {
                                recordingTime += 0.01
                            }
                        }
                    
                    RecordingCircleView(
                        level: speechRecognizer.level,
                        transcript: speechRecognizer.transcript,
                        foregroundColor: RecordingLevel(rawValue: speechRecognizer.level)?.foregroundColor ?? .black,
                        animationName: RecordingLevel(rawValue: speechRecognizer.level)?.animationName ?? "level0"
                    )
                    .padding()
                    
                    HStack(spacing: 25) {
                        ForEach(SwearCategory.allCases) { category in
                            BarView(value: speechRecognizer.scores[category.index],
                                    category: category.name,
                                    isLast: category == SwearCategory.allCases.last)
                        }
                    }
                    .padding([.leading, .trailing])
                    .animation(.default, value: speechRecognizer.scores)
                    
                    Button(action: recordAction) {
                        Image(systemName: isRecording ? "stop.circle.fill" : "record.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(isRecording ? .red : .gray)
                    }
                    .alert(
                        Text("Save"),
                        isPresented: $isShowAlert
                    ) {
                        Button("Cancel", role: .cancel) {
                            isPresentingRecordingView = false
                            isShowAlert = false
                        }
                        Button("OK") {
                            isPresentingRecordingView = false
                            isShowAlert = false
                            Task {
                                await viewModel.postEndSpeechWithAPI(
                                    id: viewModel.newConservation.id,
                                    requestBody: PostCreateEndSpeechRequestDTO(timestamp: formatter.string(from: Date()))
                                )
                            }
                        }
                    } message: {
                        Text("지금까지 녹음된 대화 내역을 저장하시겠습니까? \n Cancel을 누르면, 대화 내역은 삭제됩니다.")
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 10)
            }
        }
    }
}

private extension RecordingView {
    func recordAction() {
        if isRecording {
            speechRecognizer.stopTranscribing()
            isRecording = false
            isShowAlert = true
        }
        else {
            speechRecognizer.startTranscribing()
            isRecording = true
            Task {
                await viewModel.postCreateSpeechWithAPI(
                    requestBody: PostCreateEndSpeechRequestDTO(timestamp: formatter.string(from: Date()))
                )
            }
        }
    }
}

#Preview {
    RecordingView(isPresentingRecordingView: .constant(true))
}
