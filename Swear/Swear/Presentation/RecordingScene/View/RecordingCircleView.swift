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
                    .shadow(color: foregroundColor.opacity(0.4), radius: 5, x: 0, y: 5)
                                        
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
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .orange]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                    )
            }
    }
}

#Preview {
    RecordingCircleView(level: 0, transcript: "", foregroundColor: .black, animationName: "clean")
}
