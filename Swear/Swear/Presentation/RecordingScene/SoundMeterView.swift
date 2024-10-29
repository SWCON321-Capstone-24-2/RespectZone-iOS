//
//  SoundMeterView.swift
//  Swear
//
//  Created by 민 on 10/27/24.
//

import SwiftUI

struct SoundMeterView: View {
    var level: Float
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 4) {
                ForEach(0..<8) { index in
                    let barHeight = max(0, CGFloat((level + 60) / 8) - CGFloat(index))
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white)
                        .frame(width: geometry.size.width / 8, height: barHeight * geometry.size.height)
                }
            }
        }
        .background(Color.black.opacity(0.5))
        .cornerRadius(5)
    }
}

#Preview {
    SoundMeterView(level: 0)
}
