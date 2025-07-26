//
//  SoundManager.swift
//  millionaireRush
//
//  Created by Danil on 25.07.2025.
//

import AVFoundation

enum Sound: String {
    case clock = "clock"
    case correctAnswer = "correctAnswer"
    case onWaitAnswer = "onWaitAnswer"
    case openMusic = "openMusic"
    case wrongAnswer = "wrongAnswer"
    
}

class SoundManager {
    
    var player: AVAudioPlayer?

    func playSound(sound: Sound) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }

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


//MARK: HOW TO USE

/*
 import AVFoundation
 let sounds = SoundManager()
 func buttonAction() {
     sounds.playSound(sound: .openMusic)
     }
 */
