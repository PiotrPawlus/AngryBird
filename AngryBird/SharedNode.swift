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

    var winningNode: SKSpriteNode!
    var bigMenu: SKButtonNode!
    var bigNextLevel: SKButtonNode!
    var bigRestart: SKButtonNode!
    var highScoreLabel: SKLabelNode!
    
    init(size: CGSize, scene: SKScene) {
        super.init()

        self.delegate = scene
        self.size = size
        
        MusicPlayer.myPlayer()?.silent()

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
        startButton.position = CGPoint(x: 110.0, y: size.height - (size.height * 1/10))
        startButton.zPosition = ObjectZPosition.hud
        self.addChild(startButton)
        
        
        stopButton = SKButtonNode(defaultButtonImage: "pauza", activeButtonImage: "pauza", disabledButtonImage: "pauza", buttonAction: { () -> Void in
            self.stopButton.enabled = false
            self.startButton.enabled = true
            self.delegate?.stopGame(self.startButton)
        })
        stopButton.enabled = true
        stopButton.setScale(buttonsScale)
        stopButton.position = CGPoint(x: 70.0, y: size.height - (size.height * 1/10))
        stopButton.zPosition = ObjectZPosition.hud
        self.addChild(stopButton)
    
        menuButton = SKButtonNode(defaultButtonImage: "menu", activeButtonImage: "menu", disabledButtonImage: "menu", buttonAction: (self.delegate?.backToMenu)!)
        menuButton.enabled = true
        menuButton.setScale(buttonsScale)
        menuButton.position = CGPoint(x: 30.0 , y: size.height - (size.height * 1/10))
        menuButton.zPosition = ObjectZPosition.hud
        self.addChild(menuButton)
        
        resetButton = SKButtonNode(defaultButtonImage: "restart", activeButtonImage: "restart", disabledButtonImage: "restart", buttonAction:  { () -> Void in
            self.delegate?.restartGame(Level.gameLevel)
        })

        resetButton.enabled = true
        resetButton.setScale(buttonsScale)
        resetButton.position = CGPoint(x: 150.0 , y: size.height - (size.height * 1/10))
        resetButton.zPosition = ObjectZPosition.hud
        self.addChild(resetButton)
        
        pointLabel = SKLabelNode(fontNamed: "Chalkduster")
        pointLabel.fontColor = UIColor.redColor()
        pointLabel.fontSize = 25
        pointLabel.position = CGPoint(x: size.width / 2, y: size.height - (size.height * 1/10))
        
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
        
        winningNode  = self.setWinningNode()
        self.addChild(winningNode)
        highScoreLabel = self.highScoreForLevel()
        self.addChild(highScoreLabel)
        bigMenu = self.setBigMenu()
        self.addChild(bigMenu)
        bigNextLevel = self.setBigNextLevel()
        self.addChild(bigNextLevel)
        bigRestart = self.setBigRestart()
        self.addChild(bigRestart)
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
    
    
    func runWiningNode(level: Int) {
        menuButton.hidden = true
        stopButton.hidden = true
        startButton.hidden = true
        resetButton.hidden = true
        winningNode.hidden = false
        bigMenu.hidden = false
        bigNextLevel.hidden = false
        highScoreLabel.hidden = false
        bigRestart.hidden = false
    }
    
    func setWinningNode() -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: "zwyciestwo")
        node.position = CGPointMake(self.size.width / 2, self.size.height - (self.size.height * 2/5))
        node.zPosition = ObjectZPosition.hud
        node.hidden = true
        return node
    }
    
    func setBigMenu() -> SKButtonNode {
        let button = SKButtonNode(defaultButtonImage: "menu", activeButtonImage: "menu", disabledButtonImage: "menu", buttonAction: (self.delegate?.backToMenu)!)
        button.enabled = true
        button.position = CGPoint(x: self.size.width / 2 - 80.0, y: self.size.height - (self.size.height * 7/10))
        button.zPosition = 5.0
        button.hidden = true
        return button
    }
    
    func setBigNextLevel() -> SKButtonNode {
        let button = SKButtonNode(defaultButtonImage: "start", activeButtonImage: "start", disabledButtonImage: "start", buttonAction: (self.delegate?.nextLevel)!)
        button.enabled = true
        button.position = CGPoint(x: self.size.width / 2 + 80.0, y: self.size.height - (self.size.height * 7/10))
        button.zPosition = ObjectZPosition.hud
        button.hidden = true
        return button
    }
    
    func setBigRestart() -> SKButtonNode {
        let button = SKButtonNode(defaultButtonImage: "restart", activeButtonImage: "restart", disabledButtonImage: "restart", buttonAction: {
            self.delegate?.restartGame(Level.gameLevel)
        })
        button.enabled = true
        button.position = CGPoint(x: self.size.width / 2, y: self.size.height - (self.size.height * 7/10))
        button.zPosition = ObjectZPosition.hud
        button.hidden = true
        return button
    }
    
    func highScoreForLevel() -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.fontColor = UIColor.redColor()
        label.fontSize = 25
        label.position = CGPoint(x: self.size.width / 2, y: self.size.height - (self.size.height * 1/5))
        label.zPosition = ObjectZPosition.hud
        label.text = "HighScore: \(PointsCounter.getHighScore(forLevel: Level.gameLevel))"
        label.hidden = true
        return label
    }
    
    
    func contactBegin(bodyA: SKPhysicsBody, _ bodyB: SKPhysicsBody) {
        if bodyA.categoryBitMask == CollisionCategoryBitmask.Stone || bodyB.categoryBitMask == CollisionCategoryBitmask.Stone {
            let body = (bodyA.categoryBitMask == CollisionCategoryBitmask.Stone) ? (bodyA.node as! StoneSpirteNode) : (bodyB.node as! StoneSpirteNode)
            body.takeHP()
        }
        
        if bodyA.categoryBitMask == CollisionCategoryBitmask.Pig || bodyB.categoryBitMask == CollisionCategoryBitmask.Pig {
            let body = (bodyA.categoryBitMask == CollisionCategoryBitmask.Pig) ? (bodyA.node as! PigSpriteNode) : (bodyB.node as! PigSpriteNode)
            if body.destroyPig() {
                self.runWiningNode(Level.gameLevel)
                PointsCounter.saveHighScore(forLevel: Level.gameLevel)
                Level.unlockLevel(Level.gameLevel)
            }
        }
    }
}

extension SKScene {
    func backToMenu() {
        defer {
            PointsCounter.resetPoints()
        }
        self.view?.presentScene(MenuScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
    }
    
    func nextLevel() {
        defer {
            PointsCounter.resetPoints()
        }
        let levelToUnlock = Level.gameLevel
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
        defer {
            PointsCounter.resetPoints()
        }
        switch numberOfLevel {
        case 1: self.view!.presentScene(FirstLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        case 2: self.view!.presentScene(SecondLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        case 3: self.view!.presentScene(ThirdLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        default: self.view!.presentScene(FirstLevelScene(size: size), transition: SKTransition.fadeWithDuration(0.5))
        }
    }
    
}
