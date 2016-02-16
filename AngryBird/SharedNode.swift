//
//  SharedNode.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

enum EmiterError: ErrorType {
    case WrongPath
}

class SharedNode: SKNode {

    var size: CGSize!
    var ground: SKSpriteNode!
    weak var delegate: SKScene?
    var menuButton: SKButtonNode!
    var stopButton: SKButtonNode!
    var startButton: SKButtonNode!
    var resetButton: SKButtonNode!
    var pointLabel: SKLabelNode!
    var buttonsScale: CGFloat = 0.6


    
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
        startButton.setScale(buttonsScale)
        startButton.position = CGPoint(x: 110.0, y: size.height - 40.0)
        startButton.zPosition = ObjectZPosition.hud
        self.addChild(startButton)
        
        
        stopButton = SKButtonNode(defaultButtonImage: "pauza", activeButtonImage: "pauza", disabledButtonImage: "pauza", buttonAction: { () -> Void in
            self.stopButton.enabled = false
            self.startButton.enabled = true
            self.delegate?.stopGame(self.startButton)
        })
        stopButton.enabled = true
        stopButton.setScale(buttonsScale)
        stopButton.position = CGPoint(x: 70.0, y: size.height - 40.0)
        stopButton.zPosition = ObjectZPosition.hud
        self.addChild(stopButton)
    
        menuButton = SKButtonNode(defaultButtonImage: "menu", activeButtonImage: "menu", disabledButtonImage: "menu", buttonAction: (self.delegate?.backToMenu)!)
        menuButton.enabled = true
        menuButton.setScale(buttonsScale)
        menuButton.position = CGPoint(x: 30.0 , y: size.height - 40.0)
        menuButton.zPosition = ObjectZPosition.hud
        self.addChild(menuButton)
        
        resetButton = SKButtonNode(defaultButtonImage: "restart", activeButtonImage: "restart", disabledButtonImage: "restart", buttonAction:  { () -> Void in
            self.delegate?.restartGame(Level.gameLevel)
        })

        resetButton.enabled = true
        resetButton.setScale(buttonsScale)
        resetButton.position = CGPoint(x: 150.0 , y: size.height - 40.0)
        resetButton.zPosition = ObjectZPosition.hud
        self.addChild(resetButton)
        
        pointLabel = SKLabelNode(fontNamed: "Chalkduster")
        pointLabel.fontColor = UIColor.redColor()
        pointLabel.fontSize = 25
        pointLabel.position = CGPoint(x: size.width / 2, y: size.height - 50.0)
        
        do {
            try addSnowEmiter()
        } catch {
            if let error = error as? EmiterError {
                switch error {
                case .WrongPath:
                    print("Wrong path to the emitter file")
                    print("Error massage: \(error)")
                }
            }
        }

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addSnowEmiter() throws {
        let snowPath = NSBundle.mainBundle().pathForResource("snow", ofType: "sks")
        if snowPath == nil {
            throw EmiterError.WrongPath
        }
        let emitter = NSKeyedUnarchiver.unarchiveObjectWithFile(snowPath!) as! SKNode
        emitter.position = CGPoint(x: self.size.width / 2, y: self.size.height)
        self.addChild(emitter)
    }
}

extension SKScene {
    func backToMenu() {
        self.view?.presentScene(MenuScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        PointsCounter.resetPoints()
    }
    
    func nextLevel() {
        let levelToUnlock = Level.gameLevel
        PointsCounter.resetPoints()
        switch levelToUnlock {
        case 2:
            self.view?.presentScene(SecondLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        case 3:
            self.view?.presentScene(ThirdLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        default:
            self.view?.presentScene(MenuScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
    func stopGame(startButton: SKButtonNode)  {
        self.view?.paused = true
        startButton.paused = false
        
    }
    
    func startGame(stopButon: SKButtonNode) {
        self.view?.paused = false
        stopButon.enabled = true
    }
    
    func restartGame(numberOfLevel: Int) {
        PointsCounter.resetPoints()
        switch numberOfLevel {
        case 1: self.view!.presentScene(FirstLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        case 2: self.view!.presentScene(SecondLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        case 3: self.view!.presentScene(ThirdLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        default: self.view!.presentScene(FirstLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        }
    }
}
