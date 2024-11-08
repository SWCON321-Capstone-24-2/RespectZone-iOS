//
//  GetSpeechListResponseDTO.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation

struct GetSpeechListResponseDTO: Codable {
    let id: Int
    let deviceId: Int
    let createdAt: TimeZone
    let recordingTime: TimeZone
    let burningCount: Int
    let sentences: String
}
