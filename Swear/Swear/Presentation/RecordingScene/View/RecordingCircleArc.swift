//
//  RecordingCircleArc.swift
//  Swear
//
//  Created by 민 on 11/18/24.
//

import SwiftUI

struct RecordingCircleArc: Shape {
    var level: Int
    
    // 애니메이션 지원
    var animatableData: Double {
        get { Double(level) }
        set { level = Int(newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.width, rect.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let degreesPerLevel = 360.0 / 5.0
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: degreesPerLevel * Double(level))
        
        return Path { path in
            path.addArc(center: center,
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: false)
        }
    }
}
