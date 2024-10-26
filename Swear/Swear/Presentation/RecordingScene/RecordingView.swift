//
//  ContentView.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import SwiftUI
import AVFoundation

struct RecordingView: View {
    @Binding var spaceConservation: SpaceConversation
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State private var recordingTime = 0.0
    @State private var isRecording = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text(String(format: "%.2f", recordingTime))
                    .font(.title)
                    .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                        if isRecording {
                            recordingTime += 0.01
                        }
                    }
                
                Text(speechRecognizer.transcript)
                    .padding()
                
                Button(action: {
                    if isRecording {
                        speechRecognizer.stopTranscribing()
                        isRecording = false
                    } else {
                        speechRecognizer.startTranscribing()
                        isRecording = true
                    }
                }) {
                    Image(systemName: isRecording ? "stop.fill" : "record.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(isRecording ? .red : .gray)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        
                    }
                }
                    
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                    }
                }
            }
            
        }
    }
}

#Preview {
    RecordingView(spaceConservation: .constant(SpaceConversation.emptyData))
}
