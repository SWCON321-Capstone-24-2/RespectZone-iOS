//
//  DetailView.swift
//  Swear
//
//  Created by 민 on 10/25/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var spaceConservation: SpaceConversation

    var body: some View {
        List {
            Section {
                Label("Start Meeting", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            Section(header: Text("Info")) {
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(spaceConservation.swearCount) minutes")
                }
            }
        }
        .navigationTitle(spaceConservation.title)
    }
}

#Preview {
    DetailView(spaceConservation: .constant(SpaceConversation.sampleData[0]))
}
