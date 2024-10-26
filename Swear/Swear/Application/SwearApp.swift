//
//  SwearApp.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import SwiftUI

@main
struct SwearApp: App {
    var body: some Scene {
        WindowGroup {
            ListView(spaceConservation: .constant(SpaceConversation.sampleData), newConservation: .constant(SpaceConversation.emptyData))
        }
    }
}
