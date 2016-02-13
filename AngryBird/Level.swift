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
    
    static func getLevel() -> Int{
        return self.gameLevel
    }
    
    static func unlockLevel(gameLevel: Int) {
        self.gameLevel += 1
    }
}
