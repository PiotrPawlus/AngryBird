//
//  ThirdLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class ThirdLevelScene: SKScene, SKPhysicsContactDelegate {
    var firstPig: PigSpriteNode!
    var secondPig: PigSpriteNode!

    var shared: SharedNode!
    weak var deg: MenuScene?
    var countOfPigs = 2
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.physicsWorld.contactDelegate = self
        
        shared = SharedNode(size: size, scene: self)
        self.addChild(shared)
        
        
        self.addChild(shared.pointLabel)
        
        let groundSize = shared.ground.size.height
        
        let firstStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: self.frame.size.width / 2 + 50.0, posY: groundSize, rotateOnDegree: 0.0)
        self.addChild(firstStone)
        
        let posYAboveFirst = groundSize + firstStone.size.height - 10.0
        
        let secondStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: firstStone.position.x - firstStone.size.height + 30.0, posY: groundSize - 30.0
            , rotateOnDegree: 90.0)
        self.addChild(secondStone)
        
        let nextToFirstPosX = firstStone.position.x + firstStone.size.width
      

        let thirdStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: nextToFirstPosX + firstStone.size.width, posY: posYAboveFirst - 20.0, rotateOnDegree: 90.0)
        self.addChild(thirdStone)
        
        let fourthStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: nextToFirstPosX + thirdStone.size.height - 10.0, posY: groundSize, rotateOnDegree: 0.0)
        self.addChild(fourthStone)
        
        let fifthStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: nextToFirstPosX, posY: thirdStone.position.y + firstStone.size.width + 30.0, rotateOnDegree: 0.0)
        self.addChild(fifthStone)
        
        let sixthStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: nextToFirstPosX + fifthStone.size.width + 20.0, posY: thirdStone.position.y + firstStone.size.width + 30.0, rotateOnDegree: 0.0)
        self.addChild(sixthStone)
        
        let seventhStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: fourthStone.position.x + fourthStone.size.width + 30.0, posY: groundSize - 20.0, rotateOnDegree: 270.0)
        self.addChild(seventhStone)
        

        firstPig = PigSpriteNode(imageNamed: "wrog", size: size, posX: firstStone.position.x + firstStone.size.height / 2 , posY: groundSize)
        self.addChild(firstPig)
        
        Level.gameLevel = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(currentTime: NSTimeInterval) {
        shared.pointLabel.text = "Points: \(PointsCounter.points)"
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA: SKPhysicsBody
        var bodyB: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyA = contact.bodyA
            bodyB = contact.bodyB
        } else {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
        }
        
        shared.contactBegin(bodyA, bodyB)
    }
    
}
