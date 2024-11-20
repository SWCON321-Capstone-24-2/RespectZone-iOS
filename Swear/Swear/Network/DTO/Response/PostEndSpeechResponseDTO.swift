//
//  PostEndSpeechResponseDTO.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation

struct PostEndSpeechResponseDTO: Codable {
    let id: Int
    let recordingTime: String
    let burningCount: Int
    let sentenceCount: Int
}
