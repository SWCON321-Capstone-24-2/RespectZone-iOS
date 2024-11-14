//
//  SwearCategory.swift
//  Swear
//
//  Created by 민 on 11/3/24.
//

import SwiftUI

enum SwearCategory: String, CaseIterable, Identifiable, Codable {
    case GOOD_SENTENCE
    case GENDER_HATE
    case AGE_HATE
    case OTHER_HATE
    case SWEAR_EXPRESSION
    
    var color: Color {
        switch self {
        case .GOOD_SENTENCE: return .white
        case .GENDER_HATE: return .bubblegum
        case .AGE_HATE: return .buttercup
        case .OTHER_HATE: return .seafoam
        case .SWEAR_EXPRESSION: return .lavender
        }
    }
    
    var name: String {
        switch self {
        case .GOOD_SENTENCE: return "CLEAN"
        case .GENDER_HATE: return "GENDER"
        case .AGE_HATE: return "AGE"
        case .OTHER_HATE: return "OTHER"
        case .SWEAR_EXPRESSION: return "SWEAR"
        }
    }
    
    var id: String { name }
}
