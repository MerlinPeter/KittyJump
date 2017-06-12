//
//  RightTrain.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class Wagon : SKSpriteNode{
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "wagon.png")

        super.init(texture : texture , color: UIColor.black, size: CGSize(width: 100, height: 45))
      
        setup()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - custom function
     func setup(){
         anchorPoint.x = 0.5
        alpha = 1
        anchorPoint.y = 0.5
        zPosition = 1
        name = "wagon"
        physicsBody=SKPhysicsBody(rectangleOf :self.size )
         
         physicsBody!.allowsRotation = false
         physicsBody!.linearDamping = 0
         physicsBody!.restitution = 0
         physicsBody!.affectedByGravity = false

         physicsBody!.categoryBitMask = category_wagon
         physicsBody!.contactTestBitMask =  category_kitty
         physicsBody!.collisionBitMask = category_kitty | category_track 
         
         physicsBody!.usesPreciseCollisionDetection = false
         physicsBody!.isDynamic = true
        
        
    }
    
}
