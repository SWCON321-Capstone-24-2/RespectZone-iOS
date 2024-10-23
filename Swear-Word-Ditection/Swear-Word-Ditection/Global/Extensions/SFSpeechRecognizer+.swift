//
//  SFSpeechRecognizer+.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/22/24.
//

import Foundation
import Speech

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}
