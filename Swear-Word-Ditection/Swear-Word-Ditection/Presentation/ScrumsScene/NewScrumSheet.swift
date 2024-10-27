//
//  NewScrumSheet.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/22/24.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = SpaceConversation.emptyScrum
    @Binding var scrums: [SpaceConversation]
    @Binding var isPresentingNewScrumView: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(SpaceConversation.sampleData),
                  isPresentingNewScrumView: .constant(true))
}