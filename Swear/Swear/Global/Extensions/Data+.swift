//
//  Data+.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation

extension Data {
    func decode<T: Decodable>(to type: T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
