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
        ZStack {
            Color(.buttercup)
                .ignoresSafeArea()
            
            List {
                Section {
                    HStack {
                        Text("🧐 이 공간의 클린 스코어는?")
                        Spacer()
                        Text("\(viewModel.spaceConservation.cleanScore) 점")
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                }
                
                Section(header: Text("Conservation Info")) {
                    HStack {
                        Label("감지된 나쁜 문장 횟수", systemImage: "waveform.badge.mic")
                        Spacer()
                        Text("\(viewModel.spaceConservation.swearCount) 회")
                    }
                    .foregroundStyle(.black)
                    HStack {
                        Label("현재 공간에서의 리프레시 횟수", systemImage: "burst.fill")
                        Spacer()
                        Text("\(viewModel.spaceConservation.burningCount) 회")
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
            .scrollContentBackground(.hidden)
            .navigationTitle(viewModel.spaceConservation.title)
            .onAppear {
                Task {
                    await viewModel.postCreateSpeechWithAPI(id: viewModel.spaceConservation.id)
                }
            }
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(spaceConservation: .emptyData))
}
