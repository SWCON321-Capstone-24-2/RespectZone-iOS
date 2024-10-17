//
//  Swear_Word_DitectionApp.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/17/24.
//

import SwiftUI

@main
struct Swear_Word_DitectionApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
