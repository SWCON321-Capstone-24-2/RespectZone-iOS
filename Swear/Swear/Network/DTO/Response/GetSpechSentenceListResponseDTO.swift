//
//  GetSpechSentenceListResponseDTO.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation

struct GetSpechSentenceListResponseDTO: Codable {
    let sentences: [Sentence]
}

struct Sentence: Codable {
    let id: Int
    let text: String
    let type: String
    let timestamp: String
}
