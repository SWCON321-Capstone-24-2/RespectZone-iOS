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
    
    @StateObject private var viewModel = RecordingViewModel()
    @StateObject private var speechRecognizer = SpeechRecognizer()

    @Binding var isPresentingRecordingView: Bool
    
    @State private var level: Int = 0
    @State private var recordingTime: TimeInterval = 0.0
    @State private var isRecording: Bool = false
    @State private var isshowTip: Bool = false
    @State private var isShowAlert: Bool = false
    
    private let formatter = ISO8601DateFormatter()
    
    var body: some View {
        NavigationStack {
            ZStack {
                RecordingLevel(rawValue: level)?.backgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    Text(durationFormatter(recordingTime, isSecondsDevide: true))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(RecordingLevel(rawValue: level)?.foregroundColor ?? .black)
                        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                            if isRecording {
                                recordingTime += 0.01
                            }
                        }
                                        
                    Circle()
                        .strokeBorder(lineWidth: 24)
                        .foregroundStyle(RecordingLevel(rawValue: level)?.foregroundColor ?? .black)
                        .padding(.horizontal)
                        .overlay {
                            VStack {
                                LottieView(
                                    isPlaying: .constant(true),
                                    animationName: RecordingLevel(rawValue: level)?.animationName ?? "level0",
                                    loopMode: .loop
                                )
                                    .frame(width: 100, height: 100, alignment: .center)
                                
                                Text(speechRecognizer.transcript.isEmpty ? "문장을 인식하는 중입니다..." : speechRecognizer.transcript)
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(RecordingLevel(rawValue: level)?.foregroundColor ?? .black)
                                    .lineLimit(3)
                                    .padding()
                            }
                        }
                        .overlay {
                            // Circle이 채워지는 부분
                        }
                                                        
                    HStack(spacing: 25) {
                        ForEach(RecordingViewModel.scoreCategories.indices) { index in
                            BarView(value: speechRecognizer.scores[index],
                                    category: RecordingViewModel.scoreCategories[index],
                                    isLast: index == RecordingViewModel.scoreCategories.count - 1)
                        }
                    }
                    .padding([.leading, .trailing])
                    .animation(.default, value: speechRecognizer.scores)
                                        
                    Button(action: {
                        if isRecording {
                            speechRecognizer.stopTranscribing()
                            isRecording = false
                            isShowAlert = true
                        } else {
                            speechRecognizer.startTranscribing()
                            isRecording = true
                            
                            // MARK: - 녹음 시작
                            let timestampString = formatter.string(from: Date())
                            let body = PostCreateEndSpeechRequestDTO(timestamp: timestampString)
                            Task {
                                await viewModel.postCreateSpeechWithAPI(requestBody: body)
                            }
                        }
                    }) {
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
                                          
                            let timestampString = formatter.string(from: Date())

                            /// 녹음 저장 액션 시
                            Task {
                                await viewModel.postEndSpeechWithAPI(
                                    id: viewModel.newConservation.id,
                                    requestBody: PostCreateEndSpeechRequestDTO(timestamp: timestampString)
                                )
                            }
                        }
                    } message: {
                        Text("지금까지 녹음된 대화 내역을 저장하시겠습니까? \n Cancel을 누르면, 대화 내역은 삭제됩니다.")
                    }
                }
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    RecordingView(isPresentingRecordingView: .constant(true))
}
