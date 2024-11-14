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
                HStack {
                    Label("Recording Time", systemImage: "clock")
                    Spacer()
                    Text("\(durationFormatter(spaceConservation.totalRecordingDuration))")
                }
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            }
            
            Section(header: Text("Conservation Info")) {
                HStack {
                    Label("Dirty Text", systemImage: "waveform.badge.mic")
                    Spacer()
                    Text("\(spaceConservation.swearCount)")
                }
                .foregroundStyle(.white)
                HStack {
                    Label("Burning Count", systemImage: "burst.fill")
                    Spacer()
                    Text("\(spaceConservation.burningCount)")
                }
                .foregroundStyle(.red)
            }
            
            Section(header: Text("Detected Text")) {
                ForEach(spaceConservation.swears, id: \.text) { swear in
                    HStack {
                        Text(swear.text)
                        Spacer()
                        Text(swear.category.name)
                            .padding(5)
                            .foregroundStyle(.black)
                            .background(swear.category.color)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .navigationTitle(spaceConservation.title)
    }
}

//#Preview {
//    DetailView(spaceConservation: .constant(SpaceConversation.sampleData[0]))
//}
