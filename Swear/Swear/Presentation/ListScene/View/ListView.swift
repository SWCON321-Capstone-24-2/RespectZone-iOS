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
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingRecordingView = false
    
    let saveAction: () -> Void
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.spaceConservation) { $spaceConservation in
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
                .onDelete(perform: deleteAction)
            }
            .navigationTitle("Conversation")
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
                RecordingView(spaceConservation: $spaceConservation,
                              isPresentingRecordingView: $isPresentingRecordingView)
                    .presentationDetents([.height(500)])
            }
            .onChange(of: scenePhase) {
                if scenePhase == .inactive { saveAction() }
            }
            .onAppear {
                Task {
                    await viewModel.getSpeechListWithAPI()
                }
            }
        }
    }
    
    private func deleteAction(at offsets: IndexSet) {
        spaceConservation.remove(atOffsets: offsets)
    }
}
