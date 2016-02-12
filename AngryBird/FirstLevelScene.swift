//
//  FirstLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class FirstLevelScene: SKScene {
    
    var pointLabel: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        print("PIERWSZY POZIOM")
    
        let shared = SharedNode(size: size, scene: self)
        self.addChild(shared)
        
        let firstStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 50.0, posY: 90.0, rotate: 90.0)
        self.addChild(firstStone)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
