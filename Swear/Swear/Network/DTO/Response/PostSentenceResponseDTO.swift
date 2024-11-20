//
//  PostSentenceResponseDTO.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation

struct PostSentenceResponseDTO: Codable {
    let speechId: Int
    let sentence, sentenceType, message: String
    let predScore: Double
    let scores: Scores
}

// MARK: - Scores
struct Scores: Codable {
    let gender, age, other, swear, clean: Double
}
