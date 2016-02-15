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

        
        let yPositonOfButtons = self.frame.size.height / 2 - 25.0
        
        self.addChild(self.setTilteLabel())
        firstLevelButton = SKButtonNode(defaultButtonImage: "1o", activeButtonImage: "1oc", disabledButtonImage: "1z", buttonAction: goToFirstLevel)
        firstLevelButton.enabled = true
        firstLevelButton.position = CGPointMake(self.frame.width / 2 - 80.0, yPositonOfButtons)
        self.addChild(firstLevelButton)
        
        secondLevelButton = SKButtonNode(defaultButtonImage: "2o", activeButtonImage: "2oc", disabledButtonImage: "2z", buttonAction: goToSecondLevel)
        secondLevelButton.position = CGPointMake(self.frame.width / 2, yPositonOfButtons)
        self.addChild(secondLevelButton)
        
        thirdLevelButton = SKButtonNode(defaultButtonImage: "3o", activeButtonImage: "3oc", disabledButtonImage: "3z", buttonAction: goToThirdLevel)
        thirdLevelButton.position = CGPointMake(self.frame.width / 2 + 80.0, yPositonOfButtons)
        self.addChild(thirdLevelButton)
        
        statsButton = SKButtonNode(defaultButtonImage: "stone_b_2", activeButtonImage: "stone_b_2", disabledButtonImage: "stone_b_2", buttonAction: goToStats)
        statsButton.position = CGPoint(x: self.frame.width / 2 - 40.0, y: 60.0)
        self.addChild(statsButton)
        
        self.unlockLevel(Level.gameLevel)
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
        titleLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 100.0)
        return titleLabel
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

