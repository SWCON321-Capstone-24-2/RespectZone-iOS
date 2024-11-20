//
//  AVAudioSession+.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import Foundation
import AVFoundation

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
