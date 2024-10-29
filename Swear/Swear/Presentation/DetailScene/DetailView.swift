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
            Section(header: Text("Info")) {
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(spaceConservation.swearCount) minutes")
                }
                HStack {
                    Label("Burning Count", systemImage: "burst.fill")
                    Spacer()
                    Text("\(spaceConservation.burningCount)")
                }
                .foregroundStyle(.red)
            }
            
            Section(header: Text("Graph")) {
                
            }
        }
        .navigationTitle(spaceConservation.title)
    }
}

#Preview {
    DetailView(spaceConservation: .constant(SpaceConversation.sampleData[0]))
}
