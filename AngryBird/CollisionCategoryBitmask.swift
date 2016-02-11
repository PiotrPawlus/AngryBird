//
//  File.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit

struct CollisionCategoryBitmask {
    static let Bird: UInt32 = 0x00
    static let Ground: UInt32 = 0x01
    static let Stone: UInt32 = 0x02
    static let Pig: UInt32 = 0x03
}