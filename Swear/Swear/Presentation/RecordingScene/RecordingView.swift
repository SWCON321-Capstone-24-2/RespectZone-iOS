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
    @Binding var spaceConservation: [SpaceConversation]
    
    @State var newConservation: SpaceConversation = SpaceConversation.emptyData
    @Binding var isPresentingRecordingView: Bool
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State private var recordingTime: TimeInterval = 0.0
    @State private var isRecording: Bool = false
    @State private var conservationTitle: String = ""
    @State private var swearWeights: [CGFloat] = []
    @State private var isshowTip: Bool = false
    @State private var isShowAlert: Bool = false
    
    let swearCategories: [String] = [
        "좋은 문장", "성별 혐오", "연령 혐오", "기타 혐오", "욕설 표현"
    ]
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(durationFormatter(recordingTime, isSecondsDevide: true))
                    .font(.title)
                    .fontWeight(.bold)
                    .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                        if isRecording {
                            recordingTime += 0.01
                        }
                    }
                
                Text(speechRecognizer.transcript.isEmpty ? "문장을 인식하는 중입니다..." : speechRecognizer.transcript)
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .padding()
                
                HStack(spacing: 15) {
                    ForEach(swearCategories, id: \.self) { category in
                        BarView(category: category)
                    }
                }
                .padding([.leading, .trailing])
                .animation(.default, value: 10)
                
                Spacer()
                
                Button(action: {
                    if isRecording {
                        speechRecognizer.stopTranscribing()
                        isRecording = false
                        isShowAlert = true
                    } else {
                        speechRecognizer.startTranscribing()
                        isRecording = true
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
                    TextField("Write a Conservation Title", text: $conservationTitle)
                    Button("Cancel", role: .cancel) {
                        isPresentingRecordingView = false
                        isShowAlert = false
                    }
                    Button("OK") {
                        newConservation.totalRecordingDuration = recordingTime
                        newConservation.title = conservationTitle
                        spaceConservation.append(newConservation)
                        isPresentingRecordingView = false
                        isShowAlert = false
                    }
                } message: {
                    Text("Please enter you Conservation Title.")
                }
            }
            .padding(.top, 30)
        }
    }
}

#Preview {
    RecordingView(
        spaceConservation: .constant(SpaceConversation.sampleData),
        isPresentingRecordingView: .constant(true)
    )
}
