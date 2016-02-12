//
//  PointsCounter.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit

class PointsCounter {
    static var points: Int = 0
    static var enableCounting = false
    
    class func addPoint() -> Bool {
        if(enableCounting) {
            points += 1
        }
        return enableCounting
    }
}
