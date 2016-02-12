//
//  BirdSpriteNode.swift
//  AngryBird
//
//  Created by Piotr Pawluś on 12/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class BirdSpriteNode: SKSpriteNode {

    var startupPosition:CGPoint?
    var startupTouchPosition:CGPoint?
    
    let animateWings = SKAction.repeatActionForever(SKAction.animateWithNormalTextures(
        [
            SKTexture(imageNamed: "ptak"),
            SKTexture(imageNamed: "ptak1"),
            SKTexture(imageNamed: "ptak2"),
            SKTexture(imageNamed: "ptak3"),
            SKTexture(imageNamed: "ptak4")
        ]
        , timePerFrame: 0.2)
    )
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    init(imageNamed: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageNamed)
        let birdSize = texture.size()
        super.init(texture: texture, color: UIColor.clearColor(), size: birdSize)
        self.position = CGPoint(x: 100.0, y: size.height / 2 - 30.0)
        self.setScale(0.2)
        self.zPosition = ObjectZPosition.middleground
        self.physicsBody = SKPhysicsBody(circleOfRadius: birdSize.width * 0.2 / 2)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.affectedByGravity = false
        
        // !!!
        self.userInteractionEnabled = true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print ("touhc");
        
        startupPosition = self.position
        startupTouchPosition = touches.first?.locationInNode(self.parent!)
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let actualtouchposition = touches.first?.locationInNode(self.parent!)
        let movevector = CGVector(dx: actualtouchposition!.x
            - self.startupTouchPosition!.x, dy: actualtouchposition!.y
                - self.startupTouchPosition!.y)
        self.position = CGPoint(x: self.startupTouchPosition!.x + movevector.dx, y: self.startupTouchPosition!.y + movevector.dy)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let actualTouchPosition = touches.first?.locationInNode(self.parent!)
        let moveVector = CGVector(dx:
            10.0 * (self.startupTouchPosition!.x - actualTouchPosition!.x), dy: 10.0 * ( self.startupTouchPosition!.y - actualTouchPosition!.y) )
        
        self.physicsBody?.dynamic=true
        self.physicsBody?.applyImpulse(moveVector)
        
        self.runAction(SKAction.group([SKAction.playSoundFileNamed("door.aif", waitForCompletion: false),animateWings]))
    }

}
