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
        let texture = SKTexture(imageNamed: "trainrightfacing.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 750, height: 95))
        setup()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - custom function
    // Grass setup
    func setup(){
        
        //name="Grass"
        anchorPoint.x = 0
        anchorPoint.y = 0
    }
    
}
