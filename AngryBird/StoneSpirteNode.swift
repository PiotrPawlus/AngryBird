//
//  StoneSpirteNode.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class StoneSpirteNode: SKSpriteNode {
    
    private let π: CGFloat = CGFloat(M_PI)
    private let scale: CGFloat = 0.6
    private var stoneSize: CGSize!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(imageNamed: String, size: CGSize, posX x: CGFloat, posY y: CGFloat, rotateOnDegree angle: CGFloat) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.stoneSize = CGSize(width: texture.size().width * self.scale, height: texture.size().height * self.scale)
        super.init(texture: texture, color: UIColor.clearColor(), size: self.stoneSize)

        self.zPosition = ObjectZPosition.middleground
        self.position = CGPoint(x: x, y: y)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.stoneSize)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.mass = 0.6
        
        self.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Stone
        self.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Stone
        
        let radius = angle * π / 180
        let rotateBy = SKAction.rotateByAngle(radius, duration: 0.0)
        self.runAction(rotateBy)
        // !!!
        self.userInteractionEnabled = false
    }
    
    func takeHP() {
        
    }
    
}
