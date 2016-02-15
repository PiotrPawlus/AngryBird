//
//  PointsCounter.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit

struct PointsCounter {
    static var points: Int = 0
    static var highScoreFirstLvl: Int = 0
    static var highScoreSecondLvl: Int = 0
    static var highScoreThirdLvl: Int = 0
    static var enableCounting = false
    static var pigTouched = false

    
    static func downloadScores() {
        let defaults = NSUserDefaults.standardUserDefaults()
        PointsCounter.highScoreFirstLvl = defaults.integerForKey("highScoreFirstLvl")
        PointsCounter.highScoreSecondLvl = defaults.integerForKey("highScoreSecondLvl")
        PointsCounter.highScoreThirdLvl = defaults.integerForKey("highScoreThirdLvl")
    }
    
    static func addPoint() -> Bool {
        if enableCounting {
            points += 1
        }
        if pigTouched {
            points += 5
        }
        return enableCounting
    }
    
    static func resetPoints() {
        PointsCounter.enableCounting = false
        PointsCounter.points = 0
    }
    
    static func saveHighScore(forLevel level: Int) {
        var high = 0
        var key = "highScoreFirstLvl"
        switch level {
        case 1:
            PointsCounter.highScoreFirstLvl = max(PointsCounter.points, PointsCounter.highScoreFirstLvl)
            high = PointsCounter.highScoreFirstLvl
            key = "highScoreFirstLvl"
        case 2:
            PointsCounter.highScoreSecondLvl = max(PointsCounter.points, PointsCounter.highScoreSecondLvl)
            high = PointsCounter.highScoreSecondLvl
            key = "highScoreSecondLvl"
        case 3:
            PointsCounter.highScoreThirdLvl = max(PointsCounter.points, PointsCounter.highScoreThirdLvl)
            high = PointsCounter.highScoreThirdLvl
            key = "highScoreThirdLvl"
        default:
            PointsCounter.highScoreFirstLvl = max(PointsCounter.points, PointsCounter.highScoreFirstLvl)
            high = PointsCounter.highScoreFirstLvl
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(high, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func getHighScore(forLevel level: Int) -> Int{
        var tempLevel = PointsCounter.highScoreFirstLvl
        switch level {
        case 1:
            tempLevel = PointsCounter.highScoreFirstLvl
        case 2:
            tempLevel = PointsCounter.highScoreSecondLvl
        case 3:
            tempLevel = PointsCounter.highScoreThirdLvl
        default:
            tempLevel = 666
        }
        return tempLevel
    }
}
