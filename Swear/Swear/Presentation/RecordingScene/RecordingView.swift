//
//  ContentView.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import SwiftUI
import AVFoundation

struct RecordingView: View {
    @Binding var spaceConservation: [SpaceConversation]
    
    @State var newConservation: SpaceConversation = SpaceConversation.emptyData
    @Binding var isPresentingRecordingView: Bool
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State private var recordingTime = 0.0
    @State private var isRecording = false
    @State private var audioLevel: Float = 0.0
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(durationFormatter(recordingTime, isSecondsDevide: true))
                    .font(.title)
                    .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                        if isRecording {
                            recordingTime += 0.01
                        }
                    }
                
                Text(speechRecognizer.transcript == "" ? "문장을 인식하는 중입니다..." : speechRecognizer.transcript)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    if isRecording {
                        speechRecognizer.stopTranscribing()
                        isRecording = false
                    } else {
                        //speechRecognizer.startTranscribing()
                        isRecording = true
                    }
                }) {
                    Image(systemName: isRecording ? "stop.circle.fill" : "record.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(isRecording ? .red : .gray)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresentingRecordingView = false
                    }
                }
                    
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        newConservation.totalRecordingDuration = recordingTime
                        spaceConservation.append(newConservation)
                        isPresentingRecordingView = false
                    }
                }
            }

        }
    }
}

#Preview {
    RecordingView(
        spaceConservation: .constant(SpaceConversation.sampleData),
        isPresentingRecordingView: .constant(true)
    )
}
