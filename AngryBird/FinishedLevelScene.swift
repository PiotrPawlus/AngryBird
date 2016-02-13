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
        
        let menuButton = SKButtonNode(defaultButtonImage: "stop-1", activeButtonImage: "stop-1", disabledButtonImage: "stop-1", buttonAction: self.backToMenu)
        menuButton.enabled = true
        menuButton.setScale(0.2)
        menuButton.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        menuButton.zPosition = ObjectZPosition.hud
        print(menuButton.position)
        self.addChild(menuButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
