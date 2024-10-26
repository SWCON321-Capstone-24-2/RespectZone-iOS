//
//  ScrumsView.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/17/24.
//

import SwiftUI

@available(iOS 16.0, *)
struct ScrumsView: View {
    @Binding var scrums: [SpaceConversation]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums,
                          isPresentingNewScrumView: $isPresentingNewScrumView)
            .presentationDetents([.medium])
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(SpaceConversation.sampleData),
               saveAction: {})
}
