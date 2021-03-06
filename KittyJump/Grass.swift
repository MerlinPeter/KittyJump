//
//  Grass.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/10/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class Grass : SKSpriteNode {
    
    // MARK: -Init
    init() {
        
        let texture = SKTexture(imageNamed: "grass.png")
        // super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 750, height: 100))
        setup()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - custom function
    // Grass setup
    func setup(){
        
        name="Grass"
        anchorPoint.x = 0
        anchorPoint.y = 0
        zPosition = -1
    }
    
}
