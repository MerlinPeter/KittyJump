//
//  LeftTrain.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class LeftTrain : CommonSpriteNode{
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "trainleftfacing.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 600, height: 90))
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
        anchorPoint.y = 0.5
        zPosition = 1
        
        let texture = SKTexture(imageNamed: "trainleftfacing.png")
        physicsBody=SKPhysicsBody(texture : texture , size: CGSize(width: 600, height: 90))
        
        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0.5
        physicsBody!.categoryBitMask = category_train
        physicsBody!.contactTestBitMask = category_kitty
        physicsBody!.usesPreciseCollisionDetection = true
        physicsBody!.isDynamic = false

    }
    
}
