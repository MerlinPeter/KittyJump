//
//  RightTrain.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class RightTrain : SKSpriteNode{
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "trainright.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 500, height: 90))
        //physicsBody=SKPhysicsBody(texture : texture , size: CGSize(width: self.size.width, height: self.size.height))

        setup()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - custom function
    // Grass setup
    func setup(){
              //name="Grass"
        anchorPoint.x = 0.5
        alpha = 1
        anchorPoint.y = 0.75
        zPosition = 1
          let centerPoint = CGPoint(x: self.size.width / 2 - (self.size.width * self.anchorPoint.x),y: self.size.height / 2 - (self.size.height * self.anchorPoint.y))
        physicsBody=SKPhysicsBody(rectangleOf :CGSize(width: 500, height: 90), center :centerPoint)

        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0
        physicsBody!.restitution = 0
        physicsBody!.categoryBitMask = category_train
        physicsBody!.pinned = false
        physicsBody!.contactTestBitMask = category_kitty
        
        physicsBody!.collisionBitMask = category_kitty | category_track

        physicsBody!.usesPreciseCollisionDetection = true
        physicsBody!.isDynamic = true
        physicsBody!.affectedByGravity = true
        


    }
    
}
