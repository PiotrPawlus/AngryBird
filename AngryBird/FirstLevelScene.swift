//
//  FirstLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class FirstLevelScene: SKScene {
    
    var menuButton: SKButtonNode!
    var pointLabel: SKLabelNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        print("PIERWSZY POZIOM")
        
        // Set background
        let background = BackgroundSpriteNode(imageNamed: "background", size: self.frame.size)
        background.zPosition = -2
        self.addChild(background)
        
        // Set ground
        let ground = SKSpriteNode(imageNamed: "ground")
        ground.position = CGPoint(x: 0, y: 0)
        background.zPosition = 1
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.affectedByGravity = false
        self.addChild(ground)
        
        // Set bird
        let bird = SKSpriteNode(imageNamed: "ptak")
        bird.position = CGPoint(x: 100.0, y: ground.size.height + 30.0)
        bird.setScale(0.2)
        bird.zPosition = 1
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width * 0.5)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = true
        bird.physicsBody?.affectedByGravity = false
        self.addChild(bird)
        
        // Set menu back button
        menuButton = SKButtonNode(defaultButtonImage: "stop", activeButtonImage: "stop", disabledButtonImage: "stop", buttonAction: <#T##() -> Void#>)
        
        // Set point label
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
