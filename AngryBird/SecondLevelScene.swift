//
//  SecondLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class SecondLevelScene: SKScene, SKPhysicsContactDelegate {
    var menuButton: SKButtonNode!
    var pointLabel: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        print("DRUGI POZIOM")
    
        self.physicsWorld.contactDelegate = self
        
        let shared = SharedNode(size: size, scene: self)
        self.addChild(shared)
        
        Level.gameLevel = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
