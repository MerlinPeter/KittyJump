//
//  RightTrain.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class WagonDelete : SKSpriteNode{
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "trainrightfacing.png")

       // super.init(texture : texture , color: UIColor.black, size: CGSize(width: 100, height: 45))
         super.init(texture : texture , color: UIColor.black, size: CGSize(width: 600, height: 90))

        setup()
        
    }
   // SKPhysicsBody *leftCircle = [SKPhysicsBody bodyWithCircleOfRadius:leftCircleRadius center:leftCircleCenter];
   // SKPhysicsBody *rightCircle = [SKPhysicsBody bodyWithCircleOfRadius:rightCircleRadius center:rightCircleCenter];
    
    //node.physicsBody = [SKPhysicsBody bodyWithBodies:@[leftCircle, rightCircle]];
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - custom function
     func setup(){
         alpha = 1
         zPosition = 1
        name = "wagon"
        
        anchorPoint.x = 0.5
        
        anchorPoint.y = 0.5

        let sCenterPoint = CGPoint(x: self.frame.minX + (100 / 2), y:-1)
        let bCenterPoint = CGPoint(x: self.frame.maxX - (490 / 2) , y:0)
        
        let leftSmallBox = SKPhysicsBody(rectangleOf :CGSize(width: 100, height: 45) , center:sCenterPoint )
        leftSmallBox.categoryBitMask = category_wagon
        leftSmallBox.collisionBitMask = category_kitty | category_track | category_train
        leftSmallBox.contactTestBitMask = category_kitty | category_track | category_train
        
        
        let rightBigBox = SKPhysicsBody(rectangleOf :CGSize(width: 490, height: 90) , center:bCenterPoint )
        
        rightBigBox.contactTestBitMask = category_kitty | category_track | category_train
        rightBigBox.categoryBitMask = category_train
        rightBigBox.collisionBitMask = category_kitty | category_track | category_train
        
        physicsBody=SKPhysicsBody(bodies: [leftSmallBox,rightBigBox])
        
    
         physicsBody!.allowsRotation = false
         physicsBody!.linearDamping = 0
         physicsBody!.restitution = 0
         physicsBody!.affectedByGravity = true
       // physicsBody!.mass = 10
      //  physicsBody!.density = 10

        // physicsBody!.categoryBitMask = category_wagon
         //physicsBody!.contactTestBitMask =  category_kitty
        physicsBody!.collisionBitMask = category_track
         
         physicsBody!.usesPreciseCollisionDetection = false
         physicsBody!.isDynamic = true
        
        
    }
    
}
