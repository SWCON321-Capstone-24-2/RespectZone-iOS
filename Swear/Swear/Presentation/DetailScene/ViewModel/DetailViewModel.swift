//
//  DetailViewModel.swift
//  Swear
//
//  Created by 민 on 11/13/24.
//

import SwiftUI
import Combine

final class DetailViewModel: ObservableObject {
    
    private let service = BaseService.shared
    @Published var spaceConservation: SpaceConversation
    
    init(spaceConservation: SpaceConversation) {
        self.spaceConservation = spaceConservation
    }

    @MainActor
    func getSpechSentenceListWithAPI(id: Int) async {
        do {
            let response = try await service.getSpechSentenceList(id: id)
            let sentences = response.sentences.map {
                SpaceConversation.Swears(id: $0.id, text: $0.text, category: $0.type)
            }
            spaceConservation.swears = sentences
        } catch {
            print("Post Create Speech Error :", error)
        }
    }
}
