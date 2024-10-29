//
//  History.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/22/24.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    let attendees: [SpaceConversation.Attendee]
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [SpaceConversation.Attendee], transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name} )
    }
}
