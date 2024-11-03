//
//  SpaceConversation.swift
//  Swear
//
//  Created by 민 on 10/25/24.
//

import Foundation

struct SpaceConversation: Identifiable, Codable {
    let id: UUID
    var title: String
    var swearCount: Int
    var burningCount: Int
    var startTime: Date
    var totalRecordingDuration: TimeInterval
    var swears: [Swears]
    
    init(id: UUID = UUID(), title: String, swearCount: Int, burningCount: Int, startTime: Date = Date(), totalRecordingDuration: TimeInterval = 0, swears: [Swears] = []) {
        self.id = id
        self.title = title
        self.swearCount = swearCount
        self.burningCount = burningCount
        self.startTime = startTime
        self.totalRecordingDuration = totalRecordingDuration
        self.swears = swears
    }
}

extension SpaceConversation {
    struct Swears: Codable {
        var text: String
        var category: SwearCategory
        
        init(text: String, category: SwearCategory) {
            self.text = text
            self.category = category
        }
    }
}

extension SpaceConversation {
    static var emptyData: SpaceConversation {
        SpaceConversation(title: "", swearCount: 0, burningCount: 0)
    }
}

extension SpaceConversation {
    static let sampleData: [SpaceConversation] =
    [
        SpaceConversation(
            title: "Example 1",
            swearCount: 0,
            burningCount: 0,
            startTime: Date(),
            totalRecordingDuration: 2.0004,
            swears: [
                Swears(text: "시발 존나 졸리네", category: .swear),
                Swears(text: "여자는 집에서 애나 봐라", category: .gender),
                Swears(text: "나이 먹으면 뒤져야해", category: .age),
                Swears(text: "어쩌구 저쩌구 깜둥이 인종 차별 어쩌구 저쩌구 너희 나라로 돌아가라", category: .other),
            ]
        ),
        SpaceConversation(
            title: "Example 2",
            swearCount: 10,
            burningCount: 10,
            startTime: Date(),
            totalRecordingDuration: 124.920
        )
    ]
}
