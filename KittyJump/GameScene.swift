//
//  GameScene.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/9/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: postion variable
    let trainXpostion:CGFloat    = -375.0
    let trainYpostion:CGFloat    = -600.0
    let trainDiffpostion:CGFloat = 150.0

    // MARK: screen sprite variable
    let trainTrack1 = TrainTrack()
    let trainTrack2 = TrainTrack()
    let trainTrack3 = TrainTrack()
    let trainTrack4 = TrainTrack()
    let trainTrack5 = TrainTrack()
    
    
    let grass1 = Grass()
    let grass2 = Grass()
    let grass3 = Grass()
    let grass4 = Grass()
    let grass5 = Grass()
    
    let leftTrain1 = LeftTrain()
    let leftTrain2 = LeftTrain()
    let rightTrain1 = RightTrain()
    let rightTrain2 = RightTrain()
    
    
    let kitty = Kitty()
 
    
    override init(size: CGSize ) {
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        trackSetup()
        grassSetup()

        leftTrainSetup()
        rightTrainSetup()
        
        kitty.position = CGPoint(x: -rightTrain1.size.width + (kitty.size.width/1.25) , y: rightTrain1.position.y + (rightTrain1.size.height / 2) )
        self.addChild(kitty)
        
        let myJoint = SKPhysicsJointPin.joint(withBodyA: rightTrain1.physicsBody! , bodyB: kitty.physicsBody!, anchor: CGPoint(x: self.rightTrain1.frame.minX, y: self.rightTrain1.frame.minY))
        
        self.physicsWorld.add(myJoint)
        
    }
    // MARK: Init  functions to build screen
    //track position setup
    func trackSetup()  {
    
        trainTrack1.position = CGPoint(x: trainXpostion, y:trainYpostion)
        self.addChild(trainTrack1)
        
        trainTrack2.position = CGPoint(x: trainXpostion, y:trainYpostion + trainDiffpostion)
        self.addChild(trainTrack2)
        
        trainTrack3.position = CGPoint(x: trainXpostion, y:trainYpostion + (trainDiffpostion*2))
        self.addChild(trainTrack3)
        
        trainTrack4.position = CGPoint(x: trainXpostion, y:trainYpostion + (trainDiffpostion*3))
        self.addChild(trainTrack4)
        
        trainTrack5.position = CGPoint(x: trainXpostion, y:trainYpostion + (trainDiffpostion*4))
        self.addChild(trainTrack5)
        
 
    }
    
    
    func grassSetup()  {
        
        grass1.position = CGPoint(x: trainXpostion, y: trainYpostion + trainTrack1.size.height)
        self.addChild(grass1)
        
        grass2.position = CGPoint(x: trainXpostion, y: trainYpostion  + trainDiffpostion + trainTrack1.size.height)

        self.addChild(grass2)
        
        grass3.position = CGPoint(x: trainXpostion, y: trainYpostion + (trainDiffpostion * 2) + trainTrack1.size.height)

        self.addChild(grass3)
        
        grass4.position = CGPoint(x: trainXpostion, y: trainYpostion + (trainDiffpostion * 3) + trainTrack1.size.height)

        self.addChild(grass4)
        
        grass5.position = CGPoint(x: trainXpostion, y: trainYpostion + (trainDiffpostion * 4) + trainTrack1.size.height)

        self.addChild(grass5)
        
        
    }
    
    
    func leftTrainSetup()  {
        //second train from  down
       leftTrain1.position = CGPoint(x: 375 - (leftTrain1.size.width/2), y:trainTrack2.position.y  + trainTrack2.size.height + leftTrain1.size.height/2)
       self.addChild(leftTrain1)
        // TODO: merlin fix add one more train in second row  from the top

        
    }
    
    func rightTrainSetup()  {
        //last train
        rightTrain1.position = CGPoint(x: -275 , y:trainTrack1.position.y  + trainTrack1.size.height + rightTrain1.size.height/2)
        self.addChild(rightTrain1)
        // TODO: merlin fix add two more trains first row and third row

        
    }

    func trainyPostionCal(delta : Int) -> CGFloat {
        
        // TODO: merlin fix this function and call this in setup functions

        
        let calcYpostion = trainYpostion  + trainDiffpostion  + trainTrack1.size.height
        
        return calcYpostion
    }
    

    override func didMove(to view: SKView) {
        
       //code to move the train
        
      moveRightTrain(irTrain: rightTrain1)
       moveLeftTrain(ilTrain: leftTrain1)
        // TODO: merlin make remaining trains to move
        

        
         
    }

    func moveRightTrain(irTrain:RightTrain)  {
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -275  , y: 0))
         path.addLine(to: CGPoint(x: self.frame.size.width + irTrain.size.width, y: 0))
        let followLine = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 15.0)
        let reversedLine = followLine.reversed()
        irTrain.run(SKAction.sequence([followLine,reversedLine]))
    }
    
    func moveLeftTrain(ilTrain:LeftTrain)  {
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 375  , y: 0))
        path.addLine(to: CGPoint(x: -self.frame.size.width - ilTrain.size.width , y: 0))
        let followLine = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 15.0)
        let reversedLine = followLine.reversed()
        ilTrain.run(SKAction.sequence([followLine,reversedLine]))
    }

}
