//
//  MenuScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    private var firstLevelButton: SKButtonNode!
    private var secondLevelButton: SKButtonNode!
    private var thirdLevelButton: SKButtonNode!
    private var statsButton: SKButtonNode!
    private var background: SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)

        Level.downloadMaxLevel()
        
        let background = BackgroundSpriteNode(imageNamed: "background", size: size)
        background.zPosition = ObjectZPosition.background
        self.addChild(background)
        
        
        let ground = SKSpriteNode(imageNamed: "ground")
        ground.position = CGPoint(x: 0, y: 0)
        ground.zPosition = ObjectZPosition.middleground
        self.addChild(ground)
        
        let yPositonOfButtons = self.frame.size.height - (self.frame.height * 4/10)
        
        self.addChild(self.setTilteLabel())
        firstLevelButton = SKButtonNode(defaultButtonImage: "1oj", activeButtonImage: "1oc", disabledButtonImage: "1z", buttonAction: goToFirstLevel)
        firstLevelButton.enabled = true
        firstLevelButton.position = CGPointMake(self.frame.width / 2 - 100.0, yPositonOfButtons)
        firstLevelButton.zPosition = ObjectZPosition.hud
        self.addChild(firstLevelButton)
        
        secondLevelButton = SKButtonNode(defaultButtonImage: "2oj", activeButtonImage: "2oc", disabledButtonImage: "2z", buttonAction: goToSecondLevel)
        secondLevelButton.position = CGPointMake(self.frame.width / 2, yPositonOfButtons)
        secondLevelButton.zPosition = ObjectZPosition.hud
        self.addChild(secondLevelButton)
        
        thirdLevelButton = SKButtonNode(defaultButtonImage: "3oj", activeButtonImage: "3oc", disabledButtonImage: "3z", buttonAction: goToThirdLevel)
        thirdLevelButton.position = CGPointMake(self.frame.width / 2 + 100.0, yPositonOfButtons)
        thirdLevelButton.zPosition = ObjectZPosition.hud
        self.addChild(thirdLevelButton)
        
        statsButton = SKButtonNode(defaultButtonImage: "wynik", activeButtonImage: "wynik_ciemny", disabledButtonImage: "wynik_ciemny", buttonAction: goToStats)
        statsButton.position = CGPoint(x: self.frame.width / 2 - 50.0, y: self.frame.height - (self.frame.height * 7/10))
        statsButton.zPosition = ObjectZPosition.hud
        self.addChild(statsButton)
        
        self.unlockLevel(Level.gameLevel)
        
        
        
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

    // MARK: - Handling Touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    // MARK: - Update
    override func update(currentTime: CFTimeInterval) {
    }
    
    // MRAK: - Functions
    func setTilteLabel() -> SKLabelNode {
        let titleLabel = SKLabelNode(fontNamed:"Chalkduster")
        titleLabel.text = "Angry Bird"
        titleLabel.fontSize = 26
        titleLabel.fontColor = UIColor.whiteColor()
        titleLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - (self.frame.height * 1/5))
        titleLabel.zPosition = ObjectZPosition.hud
        return titleLabel
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
    
    func unlockLevel(levelToUnlock: Int) {
        switch levelToUnlock {
        case 0:
            firstLevelButton.enabled = false
            secondLevelButton.enabled = false
            thirdLevelButton.enabled = false
        case 1:
            secondLevelButton.enabled = false
            thirdLevelButton.enabled = false
        case 2:
            secondLevelButton.enabled = true
            thirdLevelButton.enabled = false
        case 3:
            secondLevelButton.enabled = true
            thirdLevelButton.enabled = true
        default:
            firstLevelButton.enabled = true
            secondLevelButton.enabled = true
            thirdLevelButton.enabled = true
        }
    }
    
    func goToStats() {
        let reval = SKTransition.fadeWithDuration(0.5)
        let stats = StatsScene(size: self.size)
        self.view!.presentScene(stats, transition: reval)
    }
    
    func goToFirstLevel() {
        let reval = SKTransition.fadeWithDuration(0.5)
        let firstLevel = FirstLevelScene(size: self.size)
        self.view!.presentScene(firstLevel, transition: reval)
    }
    
    func goToSecondLevel() {
        let reval = SKTransition.fadeWithDuration(0.5)
        let secondLevel = SecondLevelScene(size: self.size)
        self.view!.presentScene(secondLevel, transition: reval)
    }
    
    func goToThirdLevel() {
        let reval = SKTransition.fadeWithDuration(0.5)
        let thirdLevel = ThirdLevelScene(size: self.size)
        self.view!.presentScene(thirdLevel, transition: reval)
    }
}

