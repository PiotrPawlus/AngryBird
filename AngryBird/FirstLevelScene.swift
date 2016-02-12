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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    func backToMenu() {
//        let reval = SKTransition.fadeWithDuration(0.5)
//        let firstLevel = MenuScene(size: self.size)
//        self.view!.presentScene(firstLevel, transition: reval)
//    }

}
