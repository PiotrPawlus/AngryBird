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
    private var background: SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)

        let yPositonOfButtons = self.frame.size.height / 2 - 50.0
        
        self.addChild(self.setTilteLabel())
        firstLevelButton = SKButtonNode(defaultButtonImage: "redColor", activeButtonImage: "yellowColor", disabledButtonImage: "blackColor", buttonAction: goToFirstLevel)
        firstLevelButton.enabled = true
        firstLevelButton.position = CGPointMake(self.frame.width / 2 - 80.0, yPositonOfButtons)
        self.addChild(firstLevelButton)
        
        secondLevelButton = SKButtonNode(defaultButtonImage: "blueColor", activeButtonImage: "yellowColor", disabledButtonImage: "blackColor", buttonAction: goToFirstLevel)
        secondLevelButton.position = CGPointMake(self.frame.width / 2, yPositonOfButtons)
        self.addChild(secondLevelButton)
        
        thirdLevelButton = SKButtonNode(defaultButtonImage: "greenColor", activeButtonImage: "yellowColor", disabledButtonImage: "blackColor", buttonAction: goToFirstLevel)
        thirdLevelButton.position = CGPointMake(self.frame.width / 2 + 80.0, yPositonOfButtons)
        self.addChild(thirdLevelButton)
        
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
        print("Odblokowuje poziom \(levelToUnlock)")
        switch levelToUnlock {
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
    
    func goToFirstLevel() {
        print("Poziom 1")
        let reval = SKTransition.fadeWithDuration(0.5)
        let firstLevel = FirstLevelScene(size: self.size)
        self.view!.presentScene(firstLevel, transition: reval)
    }
    
    func goToSecondLevel() {
        print("Poziom 2")
        let reval = SKTransition.fadeWithDuration(0.5)
        let firstLevel = SecondLevelScene(size: self.size)
        self.view!.presentScene(firstLevel, transition: reval)
    }
    
    func goToThirdLevel() {
        print("Poziom 3")
        let reval = SKTransition.fadeWithDuration(0.5)
        let firstLevel = ThirdLevelScene(size: self.size)
        self.view!.presentScene(firstLevel, transition: reval)
    }
}

