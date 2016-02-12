//
//  SecondLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class SecondLevelScene: SKScene {
    var menuButton: SKButtonNode!
    var pointLabel: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        print("PIERWSZY POZIOM")
        
        let background = BackgroundSpriteNode(imageNamed: "background", size: self.frame.size)
        background.zPosition = -2
        //self.addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
