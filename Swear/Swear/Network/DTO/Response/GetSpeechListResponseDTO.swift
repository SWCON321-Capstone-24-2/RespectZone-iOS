//
//  GetSpeechListResponseDTO.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation

struct GetSpeechListResponseDTO: Codable {
    let id: Int
    let deviceId: String
    let createdAt: String
    let recordingTime: String?
    let burningCount: Int
    let sentences: String?
    let sentenceCount: Int
    let swearCount: Int
}
