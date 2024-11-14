//
//  BaseService.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation
import Moya

protocol BaseServiceProtocol {
    func getSpeechList() async throws -> [GetSpeechListResponseDTO]
    func getSpechSentenceList(id: Int) async throws -> GetSpechSentenceListResponseDTO
    func deleteSpeech(id: Int) async throws -> DeleteSpeechResponseDTO
    func postCreateSpeech(requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostCreateSpeechResponseDTO
    func postSentence(id: Int, requestBody: PostSentenceRequestDTO) async throws -> PostSentenceResponseDTO
    func postEndSpeech(id: Int, requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostEndSpeechResponseDTO
}

final class BaseService: BaseServiceProtocol {
    
    static let shared = BaseService()
    private let decoder = JSONDecoder()
    private let provider = MoyaProvider<BaseAPI>(plugins: [MoyaLoggerPlugin()])

    private init() {}

    func getSpeechList() async throws -> [GetSpeechListResponseDTO] {
        let result = try await provider.request(.getSpeechList)
        let decodeResult = try result.data.decode(to: GenericResponse<[GetSpeechListResponseDTO]>.self)
        return decodeResult.result ?? []
    }
    
    func getSpechSentenceList(id: Int) async throws -> GetSpechSentenceListResponseDTO {
        let result = try await provider.request(.getSpechSentenceList(id: id))
        let decodeResult = try result.data.decode(to: GenericResponse<GetSpechSentenceListResponseDTO>.self)
        return decodeResult.result ?? GetSpechSentenceListResponseDTO(sentences: [])
    }
    
    func deleteSpeech(id: Int) async throws -> DeleteSpeechResponseDTO {
        let result = try await provider.request(.deleteSpeech(id: id))
        let decodeResult = try result.data.decode(to: GenericResponse<DeleteSpeechResponseDTO>.self)
        return decodeResult.result ?? DeleteSpeechResponseDTO(id: 0)
    }
    
    func postCreateSpeech(requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostCreateSpeechResponseDTO {
        let result = try await provider.request(.postCreateSpeech(requestBody: requestBody))
        let decodeResult = try result.data.decode(to: GenericResponse<PostCreateSpeechResponseDTO>.self)
        return decodeResult.result ?? PostCreateSpeechResponseDTO(id: 0)
    }
    
    func postSentence(id: Int, requestBody: PostSentenceRequestDTO) async throws -> PostSentenceResponseDTO {
        let result = try await provider.request(.postSentence(id: id, requestBody: requestBody))
        let decodeResult = try result.data.decode(to: GenericResponse<PostSentenceResponseDTO>.self)
        return decodeResult.result ?? PostSentenceResponseDTO(sentence: "", type: "")
    }
    
    func postEndSpeech(id: Int, requestBody: PostCreateEndSpeechRequestDTO) async throws -> PostEndSpeechResponseDTO {
        let result = try await provider.request(.postEndSpeech(id: id, requestBody: requestBody))
        let decodeResult = try result.data.decode(to: GenericResponse<PostEndSpeechResponseDTO>.self)
        return decodeResult.result ?? PostEndSpeechResponseDTO(id: 0, recordingTime: "", burningCount: 0, sentenceCount: 0)
    }
}
