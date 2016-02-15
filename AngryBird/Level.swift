//
//  Level.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 13/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit

struct Level {
    static var gameLevel: Int = 1
    static var countOfLevels: Int = 3
    
    static func unlockLevel(level: Int) {
        let levelToUnlock = level + 1
        if (levelToUnlock > Level.gameLevel && levelToUnlock <= Level.countOfLevels) {
            // podejmij działanie
            Level.gameLevel = levelToUnlock
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(Level.gameLevel, forKey: "maxLevel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    static func downloadMaxLevel() {
        let defaults = NSUserDefaults.standardUserDefaults()
        Level.gameLevel = defaults.integerForKey("maxLevel")
    }
}
