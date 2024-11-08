//
//  BaseService.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation
import Moya

protocol BaseServiceProtocol {
    func getSpeechList() async throws -> GetSpeechListResponseDTO
    func getSpechSentenceList(id: Int) async throws -> GetSpechSentenceListResponseDTO
    func deleteSpeech(id: Int) async throws -> DeleteSpeechResponseDTO
    func postCreateSpeech(requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostCreateSpeechResponseDTO
    func postSentence(id: Int, requestBody: PostSentenceRequestDTO) async throws -> PostSentenceResponseDTO
    func postEndSpeech(id: Int, requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostEndSpeechResponseDTO
}

final class BaseService: BaseServiceProtocol {
    
    static let shared = BaseService()
    private let provider = MoyaProvider<BaseAPI>(plugins: [MoyaLoggerPlugin()])

    private init() {}

    func getSpeechList() async throws -> GetSpeechListResponseDTO {
        let result = try await provider.request(.getSpeechList)
        return try result.data.decode(to: GetSpeechListResponseDTO.self)
    }
    
    func getSpechSentenceList(id: Int) async throws -> GetSpechSentenceListResponseDTO {
        let result = try await provider.request(.getSpechSentenceList(id: id))
        return try result.data.decode(to: GetSpechSentenceListResponseDTO.self)
    }
    
    func deleteSpeech(id: Int) async throws -> DeleteSpeechResponseDTO {
        let result = try await provider.request(.getSpeechList)
        return try result.data.decode(to: DeleteSpeechResponseDTO.self)
    }
    
    func postCreateSpeech(requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostCreateSpeechResponseDTO {
        let result = try await provider.request(.postCreateSpeech(requestBody: requestBody))
        return try result.data.decode(to: PostCreateSpeechResponseDTO.self)
    }
    
    func postSentence(id: Int, requestBody: PostSentenceRequestDTO) async throws -> PostSentenceResponseDTO {
        let result = try await provider.request(.postSentence(id: id, requestBody: requestBody))
        return try result.data.decode(to: PostSentenceResponseDTO.self)
    }
    
    func postEndSpeech(id: Int, requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostEndSpeechResponseDTO {
        let result = try await provider.request(.postEndSpeech(id: id, requestBody: requestBody))
        return try result.data.decode(to: PostEndSpeechResponseDTO.self)
    }
}
