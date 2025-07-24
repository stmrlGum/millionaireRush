//
//  SoundManager.swift
//  millionaireRush
//
//  Created by Danil on 25.07.2025.
//

import AVFoundation

class SoundManager {
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "clock", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.prepareToPlay()
            self.player?.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
