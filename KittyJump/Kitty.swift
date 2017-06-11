//
//  Kitty.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class Kitty : CommonSpriteNode{
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "kitty.png")
        // super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: texture.size().width/3, height: texture.size().height/3))
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
        zPosition=1
        
        physicsBody=SKPhysicsBody(rectangleOf: self.size)

        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0.5
        physicsBody!.categoryBitMask = category_kitty
        physicsBody!.contactTestBitMask = category_train
        physicsBody!.collisionBitMask = category_train 
        physicsBody!.usesPreciseCollisionDetection = true
 
        physicsBody!.isDynamic = true

    }
    
}

