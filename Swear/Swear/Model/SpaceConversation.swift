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
    
    init(id: UUID = UUID(), title: String, swearCount: Int, burningCount: Int, startTime: Date = Date(), totalRecordingDuration: TimeInterval = 0) {
        self.id = id
        self.title = title
        self.swearCount = swearCount
        self.burningCount = burningCount
        self.startTime = startTime
        self.totalRecordingDuration = totalRecordingDuration
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
            totalRecordingDuration: 2.0004
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
