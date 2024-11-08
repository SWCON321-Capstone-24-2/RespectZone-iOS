//
//  MoyaProvider.swift
//  Swear
//
//  Created by 민 on 11/8/24.
//

import Foundation
import Moya

extension MoyaProvider {
    func request(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):    // 성공
                    continuation.resume(returning: response)
                case .failure(let error):       // 실패
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
