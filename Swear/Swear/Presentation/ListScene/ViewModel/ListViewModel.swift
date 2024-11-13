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
        
    func getSpeechListWithAPI() async {
        do {
            let response = try await service.getSpeechList()
            print(response)
//            let spaceConversation = try response.recordingTime.debugDescription.map(SpaceConversation.init)
//            spaceConservation = response.
        } catch {
            print("Speech List Error :", error)
        }
    }
    
    func deleteSpeechWithAPI(speechId: Int) async {
        do {
            let response = try await service.deleteSpeech(id: speechId)
        } catch {
            print("Delete Speech Error :", error)
        }
    }
}
