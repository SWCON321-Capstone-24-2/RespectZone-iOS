//
//  BaseAPI.swift
//  Swear
//
//  Created by 민 on 11/5/24.
//

import Foundation
import Moya

enum BaseAPI {
    case getSpeechList
    case getSpechSentenceList(id: Int)
    case deleteSpeech(id: Int)
    case postCreateSpeech(requestBody: PostCreateEndSpeechRequestDTO)
    case postSentence(id: Int, requestBody: PostSentenceRequestDTO)
    case postEndSpeech(id: Int, requestBody: PostCreateEndSpeechRequestDTO)
}

extension BaseAPI: TargetType {
    var baseURL: URL {
        guard let baseURL = URL(string: Config.baseURL) else {
            fatalError("[Error] - Base URL이 없습니다!")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getSpeechList:
            return "api/speech"
        case .getSpechSentenceList(let id):
            return "api/speech/\(id)/sentences"
        case .deleteSpeech(let id):
            return "api/speech/\(id)"
        case .postCreateSpeech:
            return "api/sppech"
        case .postSentence(let id, _):
            return "api/speech/\(id)/sentence"
        case .postEndSpeech(let id, _):
            return "api/speech/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSpeechList, .getSpechSentenceList:
            return .get
        case .deleteSpeech:
            return .delete
        case .postCreateSpeech, .postSentence, .postEndSpeech:
            return .post
        }
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        let header = [
            "Content-Type": "application/json",
            "deviceId": Config.tempId
        ]
        return header
    }
}
