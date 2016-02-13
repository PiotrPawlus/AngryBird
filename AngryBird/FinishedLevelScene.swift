//
//  FinishedLevel.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 13/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class FinishedLevelScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        let finishLabel = SKLabelNode(fontNamed: "Chalkduster")
        finishLabel.fontColor = UIColor.redColor()
        finishLabel.fontSize = 25
        finishLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height - 50.0)
        finishLabel.text = "Congratulations of finish \(Level.getLevel()) level!"
        self.addChild(finishLabel)
        
        let pointsLabel = SKLabelNode(fontNamed: "Chalkduster")
        pointsLabel.fontColor = UIColor.redColor()
        pointsLabel.fontSize = 25
        pointsLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height - 100.0)
        pointsLabel.text = "Score: \(PointsCounter.points)"
        self.addChild(pointsLabel)
        
        let menuButton = SKButtonNode(defaultButtonImage: "menu", activeButtonImage: "menu", disabledButtonImage: "menu", buttonAction: self.backToMenu)
        menuButton.enabled = true
        menuButton.position = CGPoint(x: self.frame.size.width / 2 - 30.0, y: self.frame.size.height / 2 - 50.0)
        menuButton.zPosition = ObjectZPosition.hud
        self.addChild(menuButton)
        
        let nextLevel = SKButtonNode(defaultButtonImage: "start", activeButtonImage: "start", disabledButtonImage: "start", buttonAction: self.nextLevel)
        nextLevel.enabled = true
        nextLevel.position = CGPoint(x: self.frame.size.width / 2 + 30.0, y: self.frame.size.height / 2 - 50.0)
        nextLevel.zPosition = ObjectZPosition.hud
        self.addChild(nextLevel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
