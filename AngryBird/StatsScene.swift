//
//  StatsScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 15/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class StatsScene: SKScene {
    

    override init(size: CGSize) {
        super.init(size: size)
        
        
        let background = BackgroundSpriteNode(imageNamed: "background", size: size)
        background.zPosition = ObjectZPosition.background
        self.addChild(background)
        

        let menuButton = SKButtonNode(defaultButtonImage: "menu", activeButtonImage: "menu", disabledButtonImage: "menu", buttonAction: self.backToMenu)
        menuButton.enabled = true
        menuButton.position = CGPointMake(self.frame.midX , self.frame.maxY * 3/10)
        self.addChild(menuButton)
        
        let first = displayHighScoreForLevel(1, y: self.frame.maxY * 3/9)
        self.addChild(first)
        
        let second = displayHighScoreForLevel(2, y: self.frame.maxY * 4/9)
        self.addChild(second)
        
        let third = displayHighScoreForLevel(3, y: self.frame.maxY * 5/9)
        self.addChild(third)
        
        let level = dipslayMaxLevel()
        self.addChild(level)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func displayHighScoreForLevel(level: Int, y: CGFloat) -> SKLabelNode {
        let highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        highScoreLabel.fontColor = UIColor.redColor()
        highScoreLabel.fontSize = 25
        highScoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height - y)
        highScoreLabel.text = "High Score for lvl \(level): \(PointsCounter.getHighScore(forLevel: level))"
        return highScoreLabel
    }
    
    func dipslayMaxLevel() -> SKLabelNode {
        let highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        highScoreLabel.fontColor = UIColor.redColor()
        highScoreLabel.fontSize = 20
        highScoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 8/9)
        highScoreLabel.text = "Levels unlocked: \(Level.gameLevel)"
        return highScoreLabel
    }
}
