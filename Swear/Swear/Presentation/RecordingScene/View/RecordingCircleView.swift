//
//  RecordingCircleView.swift
//  Swear
//
//  Created by 민 on 11/21/24.
//

import SwiftUI

struct RecordingCircleView: View {
    let level: Int
    let transcript: String
    let foregroundColor: Color
    let animationName: String
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    LottieView(
                        isPlaying: .constant(true),
                        animationName: animationName,
                        loopMode: .loop
                    )
                    .frame(width: 100, height: 100, alignment: .center)
                    
                    Text(transcript.isEmpty ? "문장을 인식하는 중입니다..." : transcript)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundStyle(foregroundColor)
                        .lineLimit(3)
                        .padding()
                }
                .padding(15)
            }
            .overlay {
                RecordingCircleArc(level: level)
                    .rotation(Angle(degrees: -90))
                    .stroke(.red, lineWidth: 8)
                    .animation(.default, value: level)
            }
    }
}
