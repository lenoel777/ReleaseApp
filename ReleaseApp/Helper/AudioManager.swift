//
//  AudioManager.swift
//  Release
//
//  Created by Glenn Leonali on 20/05/24.
//

import AVFoundation

class AudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    var fadeTimer: Timer?
    
    func playMusic(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("Music file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Failed to initialize audio player: \(error.localizedDescription)")
        }
    }
    
    func playSound(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = 0
            audioPlayer?.play()
        } catch {
            print("Failed to initialize audio player: \(error.localizedDescription)")
        }
    }
    
    func fadeOutMusic() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [self] timer in
            audioPlayer?.volume -= 0.025
            if audioPlayer!.volume <= 0 {
                audioPlayer?.stop()
                timer.invalidate()
            }
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
    
    func setVolume(_ volume: Float) {
        audioPlayer?.volume = volume
    }

}
