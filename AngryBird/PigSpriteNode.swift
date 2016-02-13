//
//  PigSpriteNode.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class PigSpriteNode: SKSpriteNode {

    private let scale: CGFloat = 0.2
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(imageNamed: String, size: CGSize, posX x: CGFloat, posY y: CGFloat) {
        let texture = SKTexture(imageNamed: imageNamed)
        let pigSize = CGSize(width: texture.size().width * self.scale, height: texture.size().height * self.scale)
        super.init(texture: texture, color: UIColor.clearColor(), size: pigSize)
        
        self.zPosition = ObjectZPosition.middleground
        self.position = CGPoint(x: x, y: y)
        self.physicsBody = SKPhysicsBody(circleOfRadius: pigSize.width / 2)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.mass = 0.2
        
        self.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Pig
        self.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Pig

        // !!!
        self.userInteractionEnabled = false
    }
    
    func destroyPig() -> Bool {
        var isDestroied = false
        if(PointsCounter.addPoint()) {
            self.runAction(SKAction.sequence([SKAction.fadeAlphaBy(-0.1, duration: 0.0)]))
        }
        if(self.alpha < 0.7) {
            self.runAction(SKAction.sequence([SKAction.removeFromParent()]))
            isDestroied = true
        }
        return isDestroied
    }
}
