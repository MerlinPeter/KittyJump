//
//  GameScene.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/9/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
    
    let leftTrain1 =  LeftTrain()
    let leftTrain2 =  LeftTrain()
    let rightTrain1 = RightTrain()
    let rightTrain2 = RightTrain()
    let rightTrain3 = RightTrain()
    
    let wagon1  = Wagon()
    let wagon2  = Wagon()
    let wagon3  = Wagon()
    let wagon4  = Wagon()
    let wagon5  = Wagon()
    
    
    
    let kitty = Kitty()
 
    var joint1 : SKPhysicsJointPin!
    
    override init(size: CGSize ) {
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        self.physicsBody?.categoryBitMask = category_border
        
        trackSetup()
        grassSetup()

        leftTrainSetup()
        rightTrainSetup()
        
      //  kitty.position = CGPoint(x: wagon1.position.x - wagon1.size.width/2 + (kitty.size.width/1.5) , y: wagon1.position.y + wagon1.size.height   )
        
        kitty.position = wagon1.position
       // wagon1.addChild(kitty)
        self.addChild(kitty)
        joint1 = SKPhysicsJointPin.joint(withBodyA: wagon1.physicsBody! , bodyB: kitty.physicsBody!, anchor: CGPoint(x: self.wagon1.frame.midX, y: self.wagon1.frame.midY))
        
       
       self.physicsWorld.add(joint1)
        
    }
    // MARK:    functions to make actors move
    //track position setup
    func jumpKitty( xPostion:Int)   {
        
      // self.physicsWorld.remove(joint1)

       // let jump = SKAction.applyImpulse(CGVector(dx: xPostion, dy: 300), duration: 0.3)
       // kitty.run(jump)

    }
    /* Called when a touch begins */
    
    func switchJoint(iWagon :Wagon )  {
        self.physicsWorld.remove(joint1)
        kitty.position = iWagon.position
        joint1 = SKPhysicsJointPin.joint(withBodyA: iWagon.physicsBody! , bodyB: kitty.physicsBody!, anchor: CGPoint(x: iWagon.frame.midX, y: iWagon.frame.midY))
        self.physicsWorld.add(joint1)
    }

    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            let  wagonName = node.name!
            switch wagonName {
            case "wagon1":
                switchJoint(iWagon:wagon1)
            case "wagon2":
                switchJoint(iWagon:wagon2)
                moveRightTrain(irTrain: wagon3, itrack:trainTrack3 )
            case "wagon3":
                switchJoint(iWagon:wagon3)
                 moveLeftTrain(ilTrain: wagon4,itrack:trainTrack4)
            case "wagon4":
                switchJoint(iWagon:wagon4)
                moveRightTrain(irTrain: wagon5, itrack:trainTrack5 )
            case "wagon5":
                switchJoint(iWagon:wagon5)
            default:
                break
                print("wrong call")
                
            }
            if (node.name == "move") {
                  
                let moveAction: SKAction = SKAction.moveBy(x: 10, y: 0, duration: 1)
                wagon1.run(moveAction)
            }
            
            /*else{
                if touch.location(in: kitty.parent!).x < kitty.position.x {
                    jumpKitty(xPostion: -25)
                }else{
                    jumpKitty(xPostion: 25)
                }*/
            }
            
  
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
        leftTrain1.position = CGPoint(x: 375 + (leftTrain1.size.width/2), y:trainTrack2.position.y  + trainTrack2.size.height + leftTrain1.size.height/2)
        //self.addChild(leftTrain1)
        
        wagon2.position = CGPoint(x: 375 - wagon2.size.width , y:trainTrack2.position.y  + trainTrack2.size.height)
        wagon2.name = "wagon2"

        self.addChild(wagon2)
        
        leftTrain2.position = CGPoint(x: 375 + (leftTrain2.size.width/2), y:trainTrack4.position.y  + trainTrack4.size.height + leftTrain2.size.height/2)
        // fourth train from down
        self.addChild(leftTrain2)
        
        wagon4.position = CGPoint(x: 375 - wagon4.size.width , y:trainTrack4.position.y  + trainTrack3.size.height )
        wagon4.name = "wagon4"

        self.addChild(wagon4)
        
        
    }
    
    func rightTrainSetup()  {
        
        //last train
        rightTrain1.position = CGPoint(x: -375 - (rightTrain1.size.width/2), y:trainTrack1.position.y  + trainTrack1.size.height + rightTrain1.size.height/2)
        self.addChild(rightTrain1)
        
        wagon1.position = CGPoint(x: self.frame.minX + wagon1.size.width , y:trainTrack1.position.y  + trainTrack1.size.height )
        wagon1.name = "wagon1"
        self.addChild(wagon1)

        //third train
        rightTrain2.position = CGPoint(x: -375 - (rightTrain2.size.width/2), y:trainTrack3.position.y  + trainTrack3.size.height + rightTrain2.size.height/2)
        self.addChild(rightTrain2)
        
        wagon3.position = CGPoint(x: self.frame.minX + wagon1.size.width , y:trainTrack3.position.y  + trainTrack3.size.height )
        wagon3.name = "wagon3"

       self.addChild(wagon3)
        
        
        //5th from down
        rightTrain3.position = CGPoint(x: -375 - (rightTrain3.size.width/2) , y:trainTrack5.position.y  + trainTrack5.size.height + rightTrain3.size.height/2)
        self.addChild(rightTrain3)
        wagon5.position = CGPoint(x:self.frame.minX + wagon1.size.width , y:trainTrack5.position.y  + trainTrack3.size.height )
        wagon5.name = "wagon5"

        self.addChild(wagon5)
        
    }

    
    //MARK: - SKScene functions

    override func didMove(to view: SKView) {
        
        //code to move the train
        moveRightTrain(irTrain: wagon1, itrack:trainTrack1 )
        moveLeftTrain(ilTrain: wagon2, itrack: trainTrack2)
       /* moveRightTrain(irTrain: wagon3, itrack:trainTrack3 )
        moveLeftTrain(ilTrain: wagon4, itrack: trainTrack4)
        moveRightTrain(irTrain: wagon5, itrack:trainTrack5 )*/

      //  moveRightTrain(irTrain: wagon3, itrack:trainTrack3 )
       //moveRightTrain(irTrain: rightTrain1, itrack:trainTrack1 )
       /*moveLeftTrain(ilTrain: leftTrain1,itrack:trainTrack2)
        moveRightTrain(irTrain: rightTrain2 , itrack:trainTrack3)
        moveLeftTrain(ilTrain: leftTrain2,itrack:trainTrack4)
        moveRightTrain(irTrain: rightTrain3, itrack:trainTrack5)*/
        
        self.physicsWorld.contactDelegate = self

    }
    func didBegin(_ contact: SKPhysicsContact) {
        
         var firstBody: SKPhysicsBody
         var secondBody: SKPhysicsBody
    
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        

        if firstBody.categoryBitMask == category_kitty && secondBody.categoryBitMask == category_wagon {
           // kitty.physicsBody?.pinned = true
            print("Kitty hit wagon. First contact has been made.")
   
        }
        if firstBody.categoryBitMask == category_kitty && secondBody.categoryBitMask == category_border {
            // kitty.physicsBody?.pinned = true
            print("Kitty hit border. First contact has been made.")
            kitty.removeFromParent()
            
        }
        
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if firstBody.categoryBitMask == category_kitty && secondBody.categoryBitMask == category_wagon {
            print("Kitty jumped from  wagon.")
        }
        

    }


    
    
    func trainyPostionCal(delta : Int) -> CGFloat {
        
        // TODO: merlin fix this function and call this in setup functions
        
        
        let calcYpostion = trainYpostion  + trainDiffpostion  + trainTrack1.size.height
        
        return calcYpostion
    }
    
    func moveRightTrain(irTrain:Wagon, itrack:TrainTrack)  {
        
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + irTrain.size.height/2
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: self.frame.minX + irTrain.size.width , y: yPostionC))
        path.addLine(to: CGPoint(x: self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 10.0)
        irTrain.run(followLine )
        
        irTrain.run(
            SKAction.repeatForever(
                SKAction.sequence([
                                   followLine
                                  // SKAction.wait(forDuration: drand48()),
                                  // followLine,
                                  // SKAction.wait(forDuration: drand48())
                    ])
            )
            
        )
        
    }
    
    func moveLeftTrain(ilTrain:Wagon, itrack:TrainTrack)  {
        // TODO: merlin fix this function similar to right train move
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + ilTrain.size.height/2
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 375 + ilTrain.size.width/2 , y: yPostionC))
        path.addLine(to: CGPoint(x: -self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 10.0)
        // let reversedLine = followLine.reversed()
        ilTrain.run(followLine )
        
        ilTrain.run(
            SKAction.repeatForever(
                SKAction.sequence([
                                   followLine
                                  // SKAction.wait(forDuration: drand48()),
                                  // followLine,
                                  // SKAction.wait(forDuration: drand48())
                    ])
            )
            
        )
    }
    
    
    

}


