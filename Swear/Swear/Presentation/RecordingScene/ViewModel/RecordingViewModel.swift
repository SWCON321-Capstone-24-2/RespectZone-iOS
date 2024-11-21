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
    @Published var newConservation: SpaceConversation = SpaceConversation.emptyData
    
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
    func postSentenceWithAPI(id: Int, requestBody: PostSentenceRequestDTO) async -> PostSentenceModel {
        do {
            let response = try await service.postSentence(id: id, requestBody: requestBody)
            let levels = [response.scores.gender,
                          response.scores.age,
                          response.scores.other,
                          response.scores.swear,
                          response.scores.clean]
            
            let result = PostSentenceModel(
                levels: levels, score: response.predScore, type: response.sentenceType
            )
            
            return result
        } catch {
            print("Post Sentence Error :", error)
            return PostSentenceModel()
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
