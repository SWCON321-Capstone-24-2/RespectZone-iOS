//
//  GenericResponse.swift
//  Swear
//
//  Created by 민 on 11/5/24.
//

import Foundation

struct GenericResponse<T> {
    
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: T?
    
    enum CodingKeys: CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
}

extension GenericResponse: Decodable where T: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try values.decode(Bool.self, forKey: .isSuccess)
        code = try values.decode(Int.self, forKey: .code)
        message = try values.decode(String.self, forKey: .message)
        result = try values.decode(T.self, forKey: .result)
    }
}
