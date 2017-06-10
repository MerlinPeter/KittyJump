//
//  TrainTrack.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/9/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit

class TrainTrack : CommonSpriteNode{

         // MARK: -Init
         init() {
            
            let texture = SKTexture(imageNamed: "railroad.png")
            super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 750, height: 20))
            setup()
            
    }
    
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
        // MARK: - custom function
        // train setup
        func setup(){
            
            name="TrainTrack"
            anchorPoint.x = 0
            anchorPoint.y = 0
        }
    
    }
    

