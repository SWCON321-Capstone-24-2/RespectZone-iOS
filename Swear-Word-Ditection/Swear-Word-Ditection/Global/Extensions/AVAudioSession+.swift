//
//  AVAudioSession+.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/22/24.
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
