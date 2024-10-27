//
//  ListView.swift
//  Swear
//
//  Created by 민 on 10/25/24.
//

import SwiftUI

struct ListView: View {
    
    // MARK: - Properties
    
    @Binding var spaceConservation: [SpaceConversation]
    @Binding var newConservation: SpaceConversation
    
    @State private var isPresentingRecordingView = false
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            List($spaceConservation) { $spaceConservation in
                NavigationLink(destination: DetailView(spaceConservation: $spaceConservation)) {
                    VStack(alignment: .leading) {
                        Text(spaceConservation.title)
                            .font(.title3)
                        Spacer()
                        Label("\(dateFormatter(spaceConservation.startTime))", systemImage: "calendar")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                        Label("\(durationFormatter(spaceConservation.totalRecordingDuration))", systemImage: "clock")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .navigationTitle("Conversation")
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        isPresentingRecordingView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                        Text("New Conservation")
                    }
                    .buttonStyle(.plain)
                }
            }
            .sheet(isPresented: $isPresentingRecordingView) {
                RecordingView(spaceConservation: $newConservation,
                              isPresentingRecordingView: $isPresentingRecordingView)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    ListView(spaceConservation: .constant(SpaceConversation.sampleData),
             newConservation: .constant(SpaceConversation.emptyData))
}
