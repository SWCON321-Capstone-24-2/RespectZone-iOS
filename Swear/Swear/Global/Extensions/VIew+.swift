//
//  VIew+.swift
//  Swear
//
//  Created by 민 on 10/26/24.
//

import SwiftUI

extension View {
    
    /// Date -> "Oct 25, 2024, 10:30 AM" String 타입으로 출력
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    /// Duration -> "HH:MM:DD" String 타입으로 출력
    func durationFormatter(_ duration: TimeInterval, isSecondsDevide: Bool = false) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = isSecondsDevide ? duration.truncatingRemainder(dividingBy: 60) : Double(Int(duration) % 60)

        if isSecondsDevide {
            if hours > 0 {
                return String(format: "%02d:%02d:%05.2f", hours, minutes, seconds)
            } else {
                return String(format: "%02d:%05.2f", minutes, seconds)
            }
        } else {
            if hours > 0 {
                return String(format: "%02d:%02d:%02d", hours, minutes, Int(seconds))
            } else {
                return String(format: "%02d:%02d", minutes, Int(seconds))
            }
        }
    }
    
}
