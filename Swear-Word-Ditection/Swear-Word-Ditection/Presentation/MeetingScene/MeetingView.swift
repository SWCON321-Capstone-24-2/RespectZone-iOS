//
//  ContentView.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/17/24.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: SpaceConversation
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                
                MeetingTimerView(
                    speakers: scrumTimer.speakers,
                    isRecording: isRecording,
                    theme: scrum.theme
                )
                
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
            .padding()
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .onAppear { startScrum() }
        .onDisappear { endScrum() }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes,
                         attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(
            attendees: scrum.attendees,
            transcript: speechRecognizer.transcript
        )
        scrum.history.insert(newHistory, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(SpaceConversation.sampleData[0]))
}
