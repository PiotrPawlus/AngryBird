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
    var ground: SKSpriteNode!
    weak var delegate: SKScene?
    var menuButton: SKButtonNode!
    var stopButton: SKButtonNode!
    var startButton: SKButtonNode!
    
    init(size: CGSize, scene: SKScene) {
        super.init()

        self.delegate = scene
        self.size = size
        // Set background
        let background = BackgroundSpriteNode(imageNamed: "background", size: size)
        background.zPosition = ObjectZPosition.background
        self.addChild(background)
        
        ground = SKSpriteNode(imageNamed: "ground")
        ground.position = CGPoint(x: 0, y: 0)
        ground.zPosition = ObjectZPosition.middleground
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Ground
        ground.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Ground
        self.addChild(ground)
        
        // Set bird
        let bird = BirdSpriteNode(imageNamed: "ptak", size: size)
        self.addChild(bird)
        
        startButton = SKButtonNode(defaultButtonImage: "start", activeButtonImage: "start", disabledButtonImage: "start", buttonAction: { () -> Void in
            self.startButton.enabled = false
            self.delegate?.startGame(self.stopButton)
        })
        startButton.enabled = false
        startButton.position = CGPoint(x: 110.0, y: size.height - 40.0)
        startButton.zPosition = ObjectZPosition.hud
        self.addChild(startButton)
        
        
        stopButton = SKButtonNode(defaultButtonImage: "pauza", activeButtonImage: "pauza", disabledButtonImage: "pauza", buttonAction: { () -> Void in
            self.stopButton.enabled = false
            self.startButton.enabled = true
            self.delegate?.stopGame(self.startButton)
        })
        stopButton.enabled = true
        stopButton.position = CGPoint(x: 70.0, y: size.height - 40.0)
        stopButton.zPosition = ObjectZPosition.hud
        self.addChild(stopButton)
    
        menuButton = SKButtonNode(defaultButtonImage: "menu", activeButtonImage: "menu", disabledButtonImage: "menu", buttonAction: (self.delegate?.backToMenu)!)
        menuButton.enabled = true
        menuButton.position = CGPoint(x: 30.0 , y: size.height - 40.0)
        menuButton.zPosition = ObjectZPosition.hud
        self.addChild(menuButton)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension SKScene {
    func backToMenu() {
        print("Tu się pojawi menu gry")
        self.view?.presentScene(MenuScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        PointsCounter.enableCounting = false
        PointsCounter.points = 0
    }
    
    func nextLevel() {
        print("następny poziom")
        let levelToUnlock = Level.getLevel()
        switch levelToUnlock {
        case 2:
            self.view?.presentScene(SecondLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        case 3:
            self.view?.presentScene(ThirdLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        default:
            self.view?.presentScene(FirstLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func stopGame(startButton: SKButtonNode)  {
        print("Game stoped")
        self.view?.paused = true
        startButton.paused = false
        
    }
    
    func startGame(stopButon: SKButtonNode) {
        print("Start game")
        self.view?.paused = false
        stopButon.enabled = true
    }
}
