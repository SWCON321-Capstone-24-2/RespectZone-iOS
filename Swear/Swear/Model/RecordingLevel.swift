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
    
    var backgroundColor: Color {
        switch self {
        case .zero: Color.red.opacity(0.1)
        case .one: Color.red.opacity(0.2)
        case .two: Color.red.opacity(0.35)
        case .three: Color.red.opacity(0.55)
        case .four: Color.red.opacity(0.7)
        case .five: Color.red.opacity(0.9)
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
}
