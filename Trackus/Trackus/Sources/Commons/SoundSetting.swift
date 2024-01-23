//
//  SoundSetting.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/21.
//

import SwiftUI
import AVKit

class SoundSetting: ObservableObject {
    
    enum SoundOption: String {
        case recordStart
        case recordStop
    }
    
    static let instance = SoundSetting()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".m4a") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("ERROR: Sound setting error")
        }
    }
}
