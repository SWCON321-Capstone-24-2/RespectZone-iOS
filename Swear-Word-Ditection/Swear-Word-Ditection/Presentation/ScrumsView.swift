//
//  ScrumsView.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/17/24.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List(scrums) { scrum in
            CardView(scrum: scrum)
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}
