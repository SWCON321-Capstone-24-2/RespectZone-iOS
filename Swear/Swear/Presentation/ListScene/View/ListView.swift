//
//  ListView.swift
//  Swear
//
//  Created by 민 on 10/25/24.
//

import SwiftUI

struct ListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = ListViewModel()

    @Binding var spaceConservation: [SpaceConversation]
    
    @State private var isPresentingRecordingView = false
    
    let saveAction: () -> Void
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.buttercup)
                    .ignoresSafeArea()
                
                List {
                    ForEach($viewModel.spaceConservation) { $spaceConservation in
                        NavigationLink(destination: DetailView(
                            viewModel: DetailViewModel(spaceConservation: spaceConservation)
                        )) {
                            VStack(alignment: .leading) {
                                Text(spaceConservation.title)
                                    .font(.title3)
                                Spacer()
                                Label("\(dateFormatter(spaceConservation.startTime))", systemImage: "calendar")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Label("\(spaceConservation.totalRecordingDuration)", systemImage: "clock")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteAction)
                }
                .navigationTitle("Speech")
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            isPresentingRecordingView = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                            Text("New Speech")
                        }
                        .buttonStyle(.plain)
                    }
                }
                .sheet(isPresented: $isPresentingRecordingView) {
                    RecordingView(isPresentingRecordingView: $isPresentingRecordingView)
                        .presentationDetents([.fraction(1.0)])
                }
                .onChange(of: isPresentingRecordingView) {
                    Task {
                        await viewModel.getSpeechListWithAPI()
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.getSpeechListWithAPI()
                    }
                }
            }
        }
    }
    
    private func deleteAction(at offsets: IndexSet) {
        for index in offsets {
            let deleteSpeechId = viewModel.spaceConservation[index].id
            Task {
                await viewModel.deleteSpeechWithAPI(speechId: deleteSpeechId)
            }
        }
    }
}

#Preview {
    ListView(
        spaceConservation: .constant([SpaceConversation.emptyData]), saveAction: {}
    )
}
