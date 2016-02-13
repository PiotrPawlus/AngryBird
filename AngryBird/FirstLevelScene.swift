//
//  FirstLevelScene.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

/*
1. zakonczenie rundy, dlaczego, widok
3. menu przejsciowe
4. dzwieki
5. snieg?


Lista do Appstore:
 - 1024x1024
 -
*/

import SpriteKit

class FirstLevelScene: SKScene, SKPhysicsContactDelegate {
    
    var pointLabel: SKLabelNode!
    var ground: SKSpriteNode!
    var firstPig: PigSpriteNode!
    private var gameLevel = 1
    weak var deg: MenuScene?
    
    override init(size: CGSize) {
        super.init(size: size)
        print("PIERWSZY POZIOM")
    
        self.physicsWorld.contactDelegate = self
        
        let shared = SharedNode(size: size, scene: self)
        self.addChild(shared)
        
        // Set ground
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
        
        pointLabel = SKLabelNode(fontNamed: "Chalkduster")
        pointLabel.fontColor = UIColor.redColor()
        pointLabel.fontSize = 25
        pointLabel.position = CGPoint(x: 200.0, y: self.frame.height - 50.0)
        self.addChild(pointLabel)
        
        let firstStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 50.0, posY: ground.size.height - 1.0, rotateOnDegree: 0.0)
        self.addChild(firstStone)
        
        let secondStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: self.frame.size.width - 125.0, posY: ground.size.height - 1.0, rotateOnDegree: 0.0)
        self.addChild(secondStone)
        
        let thirdStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 87.0, posY: firstStone.size.height + 55.0, rotateOnDegree: 90.0)
        self.addChild(thirdStone)
        
        firstPig = PigSpriteNode(imageNamed: "wrog", size: size, posX: self.frame.size.width - 85.0 , posY: ground.size.height - 1.0)
        self.addChild(firstPig)
        
        Level.gameLevel = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(currentTime: NSTimeInterval) {
        pointLabel.text = "Points: \(PointsCounter.points)"
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
                // udostępnij poziom
                self.view?.presentScene(FinishedLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
                Level.unlockLevel(gameLevel)
            }
        }
        if (contact.bodyB.categoryBitMask == CollisionCategoryBitmask.Pig) {
            if (contact.bodyB.node as! PigSpriteNode).destroyPig() {
                // udostępnij poziom
                
                self.view?.presentScene(FinishedLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(0.5))
                Level.unlockLevel(gameLevel)
            }
        }
    }
}
