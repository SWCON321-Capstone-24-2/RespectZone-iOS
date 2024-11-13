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

    func postCreateSpeechWithAPI() async {
        do {
//            let response = try await service.postCreateSpeech(requestBody: <#T##PostCreateEndSpeechRequestDTO#>)
        } catch {
            print("Delete Speech Error :", error)
        }
    }
    
    func postSentenceWithAPI() async {
        do {
//            let response = try await service.postSentence(id: <#T##Int#>, requestBody: <#T##PostSentenceRequestDTO#>)
        } catch {
            print("Delete Speech Error :", error)
        }
    }
    
    func postEndSpeechWithAPI() async {
        do {
//            let response = try await service.postEndSpeech(id: <#T##Int#>, requestBody: <#T##<<error type>>#>)
        } catch {
            print("Delete Speech Error :", error)
        }
    }
}
