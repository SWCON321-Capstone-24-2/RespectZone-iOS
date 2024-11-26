//
//  PredictScore.swift
//  Swear
//
//  Created by 민 on 11/17/24.
//

import SwiftUI

enum RecordingLevel: Int, CaseIterable {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    
    var backgroundColor: LinearGradient {
        switch self {
        case .zero:
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.1), .swearRed.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .one:
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.2), .swearRed.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .two:
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.35), .swearRed.opacity(0.35)]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .three:
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.6), .swearRed.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .four:
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.8), .swearRed.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .five:
            LinearGradient(
                gradient: Gradient(colors: [.red, .swearRed]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .zero, .one, .two: .black
        case .three, .four, .five: .white
        }
    }
    
    var animationName: String {
        switch self {
        case .zero: "level0"
        case .one: "level1"
        case .two: "level2"
        case .three: "level3"
        case .four: "level4"
        case .five: "level5"
        }
    }
    
    var sound: String {
        switch self {
        case .zero, .one: "bad1"
        case .two: "bad2"
        case .three: "bad3"
        case .four: "bad4"
        case .five: "bad5"
        }
    }
}
