//
//  AudioPlayer.swift
//  Swear
//
//  Created by 민 on 11/5/24.
//

import AVFoundation
import Foundation

class AudioPlayer: NSObject {
    private var player: AVAudioPlayer?
    private var completion: (() -> Void)?
    
    func playSound(named fileName: String, completion: (() -> Void)? = nil) {
        self.completion = completion
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("File not found: \(fileName)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
        } catch {
            print("Audio player error: \(error.localizedDescription)")
        }
    }
    
    func stop() {
        player?.stop()
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        completion?()
    }
}
