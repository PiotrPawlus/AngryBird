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
    
    var firstLevelButton: SKButtonNode!
    var secondLevelButton: SKButtonNode!
    var thirdLevelButton: SKButtonNode!
    
    var background: SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)

//        Tło musi być wielkości odpowiedniej
//        background = SKSpriteNode(imageNamed: "footer-background-min")
//        background.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
//        self.addChild(background)
        let yPositonOfButtons = self.frame.size.height / 2 - 50.0
        
        self.addChild(self.setTilteLabel())
        firstLevelButton = SKButtonNode(defaultButtonImage: "redColor", activeButtonImage: "yellowColor", disabledButtonImage: "blackColor", buttonAction: goToFirstLevel)
        firstLevelButton.enabled = true
        firstLevelButton.position = CGPointMake(self.frame.width / 2 - 80.0, yPositonOfButtons)
        self.addChild(firstLevelButton)
        
        secondLevelButton = SKButtonNode(defaultButtonImage: "blueColor", activeButtonImage: "yellowColor", disabledButtonImage: "blackColor", buttonAction: goToFirstLevel)
        secondLevelButton.enabled = false
        secondLevelButton.position = CGPointMake(self.frame.width / 2, yPositonOfButtons)
        self.addChild(secondLevelButton)
        
        thirdLevelButton = SKButtonNode(defaultButtonImage: "greenColor", activeButtonImage: "yellowColor", disabledButtonImage: "blackColor", buttonAction: goToFirstLevel)
        thirdLevelButton.enabled = false
        thirdLevelButton.position = CGPointMake(self.frame.width / 2 + 80.0, yPositonOfButtons)
        self.addChild(thirdLevelButton)
        
        
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
        /* Called before each frame is rendered */
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

