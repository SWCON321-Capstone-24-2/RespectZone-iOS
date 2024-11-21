//
//  Config.swift
//  Swear
//
//  Created by 민 on 11/5/24.
//

import Foundation

enum Config {
    enum Network {
        static let baseURL = "BASE_URL"
        static let deviceId = "DEVICE_ID"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    static let baseURL: String = "http://localhost:8080"
    static let tempId: String = "1"
}
