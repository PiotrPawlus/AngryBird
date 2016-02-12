//
//  SharedNode.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class SharedNode: SKNode {

    var size: CGSize!
    weak var delegate: SKScene?
    
    init(size: CGSize, scene: SKScene) {
        super.init()

        self.delegate = scene
        self.size = size
        // Set background
        let background = BackgroundSpriteNode(imageNamed: "background", size: size)
        background.zPosition = ObjectZPosition.background
        self.addChild(background)
        
        // Set ground
        let ground = SKSpriteNode(imageNamed: "ground")
        ground.position = CGPoint(x: 0, y: 0)
        background.zPosition = ObjectZPosition.middleground
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.affectedByGravity = false
        self.addChild(ground)
        
        // Set bird
        let bird = BirdSpriteNode(imageNamed: "ptak", size: size)
        self.addChild(bird)
        
        // Set menu back button
        let menuButton = SKButtonNode(defaultButtonImage: "stop-1", activeButtonImage: "stop-1", disabledButtonImage: "stop-1", buttonAction: stopMenu)
        menuButton.enabled = true
        menuButton.setScale(0.2)
        menuButton.position = CGPoint(x: 40.0, y: size.height - 40.0)
        menuButton.zPosition = ObjectZPosition.hud
        print(menuButton.position)
        self.addChild(menuButton)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func stopMenu() {
        delegate?.backToMenu()
    }
}

extension SKScene {
    func backToMenu() {
        print("Tu się pojawi menu gry")
        self.view?.presentScene(MenuScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
    }
}
