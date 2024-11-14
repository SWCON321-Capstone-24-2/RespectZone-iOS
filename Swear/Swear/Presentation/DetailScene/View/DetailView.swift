//
//  DetailView.swift
//  Swear
//
//  Created by 민 on 10/25/24.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Label("Recording Time", systemImage: "clock")
                    Spacer()
                    Text("\(durationFormatter(viewModel.spaceConservation.totalRecordingDuration))")
                }
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
            }
            
            Section(header: Text("Conservation Info")) {
                HStack {
                    Label("Dirty Text", systemImage: "waveform.badge.mic")
                    Spacer()
                    Text("\(viewModel.spaceConservation.swearCount)")
                }
                .foregroundStyle(.white)
                HStack {
                    Label("Burning Count", systemImage: "burst.fill")
                    Spacer()
                    Text("\(viewModel.spaceConservation.burningCount)")
                }
                .foregroundStyle(.red)
            }
            
            Section(header: Text("Detected Text")) {
                ForEach(viewModel.spaceConservation.swears, id: \.id) { swear in
                    HStack {
                        Text(swear.text)
                        Spacer()
                        Text(swear.categoryEnum.name)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                            .foregroundStyle(.black)
                            .background(swear.categoryEnum.color)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .navigationTitle(viewModel.spaceConservation.title)
        .onAppear {
            Task {
                await viewModel.postCreateSpeechWithAPI(id: viewModel.spaceConservation.id)
            }
        }
    }
}

//#Preview {
//    DetailView(spaceConservation: .constant(SpaceConversation.sampleData[0]))
//}
