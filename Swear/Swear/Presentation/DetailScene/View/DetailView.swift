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
                Section(header: Text("Speech Info")) {
                    HStack {
                        Text("🧐 이 공간의 클린 스코어는?")
                        Spacer()
                        Text("\(viewModel.spaceConservation.cleanScore) 점")
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.cleanblue)
                    
                    HStack {
                        Text("🤬 감지된 나쁜 문장 횟수")
                        Spacer()
                        Text("\(viewModel.spaceConservation.swearCount) 회")
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(.swearRed)
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
            .scrollContentBackground(.hidden)
            .onAppear {
                Task {
                    await viewModel.getSpechSentenceListWithAPI(id: viewModel.spaceConservation.id)
                }
            }
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(spaceConservation: .emptyData))
}
