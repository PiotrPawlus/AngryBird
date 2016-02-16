//
//  MusicPlayer.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 16/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayer: NSObject {
    
    static var musicStoped: Bool = false
    static var p: MusicPlayer?
    var backgroundPlayer: AVAudioPlayer?
    
    override init() {
        let pathToFile = NSBundle.mainBundle().pathForResource("dzwiek", ofType: "aif")
        if pathToFile != nil {
            self.backgroundPlayer = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: pathToFile! ))
        }
    }
    
    class func myPlayer() -> MusicPlayer? {
        if p == nil {
            p = MusicPlayer()
        }
        
        return p
    }
    
    func play() {
        MusicPlayer.musicStoped = false
        self.backgroundPlayer?.prepareToPlay()
        self.backgroundPlayer?.play()
    }
    
    func stop() {
        MusicPlayer.musicStoped = true
        self.backgroundPlayer?.stop()
        self.backgroundPlayer?.currentTime = 0
    }
    
    func pause() {
        self.backgroundPlayer?.stop()
    }
    
    func silent() {
        self.backgroundPlayer?.volume = 0.5
    }
    
    func loud() {
        self.backgroundPlayer?.volume = 1.0
    }
    
}
