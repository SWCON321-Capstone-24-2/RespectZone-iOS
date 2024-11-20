//
//  RecordingViewModel.swift
//  Swear
//
//  Created by 민 on 11/13/24.
//

import SwiftUI
import Combine

final class RecordingViewModel: ObservableObject {
    
    private let service = BaseService.shared
    
    static let scoreCategories = ["성별차별", "연령비하", "기타혐오", "욕설표현", "CLEAN"]
    
    @Published var newConservation: SpaceConversation = SpaceConversation.emptyData
    @MainActor @Published var level: Int = 0
    
    @MainActor
    func postCreateSpeechWithAPI(requestBody: PostCreateEndSpeechRequestDTO) async {
        do {
            let response = try await service.postCreateSpeech(requestBody: requestBody)
            newConservation.id = response.id
        } catch {
            print("Post Create Speech Error :", error)
        }
    }
    
    @MainActor
    func postSentenceWithAPI(id: Int, requestBody: PostSentenceRequestDTO) async -> [Double] {
        do {
            let response = try await service.postSentence(id: id, requestBody: requestBody)
            
            if response.sentenceType != "GOOD_SENTENCE" && response.predScore > 0.75 {
                level += 1
            }
            
            return [response.scores.gender,
                    response.scores.age,
                    response.scores.other,
                    response.scores.swear,
                    response.scores.clean]
        } catch {
            print("Post Sentence Error :", error)
            return []
        }
    }
    
    @MainActor
    func postEndSpeechWithAPI(id: Int, requestBody: PostCreateEndSpeechRequestDTO) async {
        do {
            let _ = try await service.postEndSpeech(id: id, requestBody: requestBody)
        } catch {
            print("Post EndSpeech Error :", error)
        }
    }
}
