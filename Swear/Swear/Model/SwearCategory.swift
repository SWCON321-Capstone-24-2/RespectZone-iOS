//
//  SwearCategory.swift
//  Swear
//
//  Created by 민 on 11/3/24.
//

import SwiftUI

enum SwearCategory: String, CaseIterable, Identifiable, Codable {
    case GENDER_HATE
    case AGE_HATE
    case OTHER_HATE
    case SWEAR_EXPRESSION
    case GOOD_SENTENCE
    
    var color: Color {
        switch self {
        case .GENDER_HATE: return .bubblegum
        case .AGE_HATE: return .buttercup
        case .OTHER_HATE: return .seafoam
        case .SWEAR_EXPRESSION: return .lavender
        case .GOOD_SENTENCE: return .white
        }
    }
    
    var name: String {
        switch self {
        case .GENDER_HATE: return "성별차별"
        case .AGE_HATE: return "연령비하"
        case .OTHER_HATE: return "기타혐오"
        case .SWEAR_EXPRESSION: return "욕설표현"
        case .GOOD_SENTENCE: return "CLEAN"
        }
    }
    
    var id: String { name }
}
