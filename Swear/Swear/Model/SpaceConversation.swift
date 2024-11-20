//
//  SpaceConversation.swift
//  Swear
//
//  Created by 민 on 10/25/24.
//

import Foundation

struct SpaceConversation: Identifiable, Codable {
    var id: Int
    var title: String
    var swearCount: Int
    var burningCount: Int
    var startTime: Date
    var totalRecordingDuration: String
    var cleanScore: Int
    var swears: [Swears]
    
    init(id: Int = 1,
         title: String,
         swearCount: Int = 0,
         burningCount: Int = 0,
         startTime: Date = Date(),
         totalRecordingDuration: String = "00:00",
         cleanScore: Int = 100,
         swears: [Swears] = []
    ) {
        self.id = id
        self.title = title
        self.swearCount = swearCount
        self.burningCount = burningCount
        self.startTime = startTime
        self.totalRecordingDuration = totalRecordingDuration
        self.cleanScore = cleanScore
        self.swears = swears
    }
}

extension SpaceConversation {
    struct Swears: Codable {
        var id: Int
        var text: String
        var category: String
        var categoryEnum: SwearCategory {
            SwearCategory(rawValue: category) ?? .GOOD_SENTENCE
        }
        
        init(id: Int,
             text: String,
             category: String
        ) {
            self.id = id
            self.text = text
            self.category = category
        }
    }
}

extension SpaceConversation {
    static var emptyData: SpaceConversation {
        SpaceConversation(title: "")
    }
}
