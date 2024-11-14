//
//  ListViewModel.swift
//  Swear
//
//  Created by 민 on 11/11/24.
//

import SwiftUI
import Combine

final class ListViewModel: ObservableObject {
    
    private let service = BaseService.shared
    
    @Published var spaceConservation: [SpaceConversation] = []
        
    @MainActor
    func getSpeechListWithAPI() async {
        do {
            let response = try await service.getSpeechList()
            let speech = response.map {
                SpaceConversation(id: $0.id, title: "Speech \($0.id)")
            }
            spaceConservation = speech
        } catch {
            print("Speech List Error :", error)
        }
    }
    
    func deleteSpeechWithAPI(speechId: Int) async {
        do {
            let _ = try await service.deleteSpeech(id: speechId)
        } catch {
            print("Delete Speech Error :", error)
        }
    }
}
