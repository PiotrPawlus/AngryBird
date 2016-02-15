//
//  SecondLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class SecondLevelScene: SKScene, SKPhysicsContactDelegate {
    var pointLabel: SKLabelNode!
    var shared: SharedNode!
    var firstPig: PigSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)
    
        self.physicsWorld.contactDelegate = self
        
        shared = SharedNode(size: size, scene: self)
        self.addChild(shared)
        

        self.addChild(shared.pointLabel)
        
        let firstStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 50.0, posY: shared.ground.size.height - 5.0, rotateOnDegree: 0.0)
        self.addChild(firstStone)
        
        let secondStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: self.frame.size.width - 125.0, posY: shared.ground.size.height - 5.0, rotateOnDegree: 0.0)
        self.addChild(secondStone)
        
        let thirdStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 87.0, posY: shared.ground.size.height + 49.0, rotateOnDegree: 90.0)
        self.addChild(thirdStone)
        
        let fourthStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 50.0, posY: shared.ground.size.height + firstStone.size.height + thirdStone.size.width - 5.0, rotateOnDegree: 0.0)
        self.addChild(fourthStone)
        
        let fifthStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: self.frame.size.width - 125.0, posY: shared.ground.size.height + secondStone.size.height + thirdStone.size.width - 5.0, rotateOnDegree: 0.0)
        self.addChild(fifthStone)
        
        let sixthStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 87.0, posY: shared.ground.size.height + firstStone.size.height + thirdStone.size.width + 50.0, rotateOnDegree: 90.0)
        self.addChild(sixthStone)
        
        firstPig = PigSpriteNode(imageNamed: "wrog", size: size, posX: self.frame.size.width - 85.0 , posY: sixthStone.position.y - 60.0)
        self.addChild(firstPig)
        
        
        Level.gameLevel = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(currentTime: NSTimeInterval) {
        shared.pointLabel.text = "Points: \(PointsCounter.points)"
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == CollisionCategoryBitmask.Stone) {
            (contact.bodyA.node as! StoneSpirteNode).takeHP()
        }
        if (contact.bodyB.categoryBitMask == CollisionCategoryBitmask.Stone) {
            (contact.bodyB.node as! StoneSpirteNode).takeHP()
            
        }
        if (contact.bodyA.categoryBitMask == CollisionCategoryBitmask.Pig) {
            if (contact.bodyA.node as! PigSpriteNode).destroyPig() {
                PointsCounter.saveHighScore(forLevel: Level.gameLevel)
                self.view?.presentScene(FinishedLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(1.0)
                Level.unlockLevel(Level.gameLevel)
            }
        }
        if (contact.bodyB.categoryBitMask == CollisionCategoryBitmask.Pig) {
            if (contact.bodyB.node as! PigSpriteNode).destroyPig() {
                PointsCounter.saveHighScore(forLevel: Level.gameLevel)
                self.view?.presentScene(FinishedLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(1.0))
                Level.unlockLevel(Level.gameLevel)
            }
        }
    }

}
