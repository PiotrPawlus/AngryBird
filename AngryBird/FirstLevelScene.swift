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
    
    var firstPig: PigSpriteNode!
    var shared: SharedNode!
    weak var deg: MenuScene?
    
    override init(size: CGSize) {
        super.init(size: size)
    
        self.physicsWorld.contactDelegate = self
        
        shared = SharedNode(size: size, scene: self)
        self.addChild(shared)
        
        // Set ground

        self.addChild(shared.pointLabel)
        let firstStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 50.0, posY: shared.ground.size.height - 1.0, rotateOnDegree: 0.0)
        self.addChild(firstStone)
        
        let secondStone = StoneSpirteNode(imageNamed: "stone_v_2", size: size, posX: self.frame.size.width - 125.0, posY: shared.ground.size.height - 1.0, rotateOnDegree: 0.0)
        self.addChild(secondStone)
        
        let thirdStone = StoneSpirteNode(imageNamed: "stone_v_1", size: size, posX: self.frame.size.width - 87.0, posY: firstStone.size.height + 55.0, rotateOnDegree: 90.0)
        self.addChild(thirdStone)
        
        firstPig = PigSpriteNode(imageNamed: "wrog", size: size, posX: self.frame.size.width - 85.0 , posY: shared.ground.size.height - 1.0)
        self.addChild(firstPig)
        
        Level.gameLevel = 1
        
        let snowPath = NSBundle.mainBundle().pathForResource("snow", ofType: "sks")
        let emitter = NSKeyedUnarchiver.unarchiveObjectWithFile(snowPath!)  as! SKNode
        emitter.position = CGPoint(x: self.size.width / 2, y: self.size.height)
        self.addChild(emitter)
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
                // udostępnij poziom
                PointsCounter.saveHighScore(forLevel: Level.gameLevel)
                self.view?.presentScene(FinishedLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(1.0))
                Level.unlockLevel(Level.gameLevel)
            }
        }
        if (contact.bodyB.categoryBitMask == CollisionCategoryBitmask.Pig) {
            if (contact.bodyB.node as! PigSpriteNode).destroyPig() {
                // udostępnij poziom
                PointsCounter.saveHighScore(forLevel: Level.gameLevel)
                self.view?.presentScene(FinishedLevelScene(size: self.size), transition: SKTransition.fadeWithDuration(1.0))
                Level.unlockLevel(Level.gameLevel)
            }
        }
    }
}
