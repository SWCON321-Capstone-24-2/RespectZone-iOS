//
//  SwearCategory.swift
//  Swear
//
//  Created by 민 on 11/3/24.
//

import SwiftUI

enum SwearCategory: String, CaseIterable, Identifiable, Codable {
    case clean
    case gender
    case age
    case other
    case swear
    
    var color: Color {
        switch self {
        case .clean: return .white
        case .gender: return .bubblegum
        case .age: return .buttercup
        case .other: return .seafoam
        case .swear: return .lavender
        }
    }
    var name: String { rawValue.capitalized }
    var id: String { name }
}
