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
    let trainDiffpostion:CGFloat = 185.0
    var gamePaused = false


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
    
   
    var scoreLabel: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    var scoreLabelHelper: SKLabelNode!

    
    let kitty = Kitty()
 
    var joint1 : SKPhysicsJointPin!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    var highScore: Int = 0 {
        didSet {
            highScoreLabel.text = "High Score : \(SharingManager.sharedInstance.highScore)"
        }
    }
    
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
        scoreSetup()
        
        kitty.position.x  = rightTrain1.frame.minX + kitty.size.width / 2
        kitty.position.y  = rightTrain1.frame.maxY

        self.addChild(kitty)
        joint1 = SKPhysicsJointPin.joint(withBodyA: rightTrain1.physicsBody! , bodyB: kitty.physicsBody!, anchor: CGPoint(x: self.rightTrain1.frame.minX, y: self.rightTrain1.frame.midY))
        
       
       self.physicsWorld.add(joint1)
        
    }
    // MARK:    functions to make actors move
    //track position setup
    func jumpKitty( xPostion:Int)   {
        
       // let jump = SKAction.applyImpulse(CGVector(dx: xPostion, dy: 300), duration: 0.3)
       // kitty.run(jump)

    }
    
    /* Called when a touch begins */
    
    func switchJoint(iWagon :RightTrain )  {
        self.physicsWorld.remove(joint1)
        if let wagonPhysicBody = iWagon.physicsBody , let kittyPhysicBody = kitty.physicsBody {
            
            kitty.position.x  = iWagon.frame.minX + kitty.size.width / 2
            kitty.position.y  = iWagon.frame.maxY

            joint1 = SKPhysicsJointPin.joint(withBodyA: wagonPhysicBody , bodyB: kittyPhysicBody, anchor: CGPoint(x: iWagon.frame.minX, y: iWagon.frame.midY))
            self.physicsWorld.add(joint1)
            score = score + 1
        }

        
    }
    
    func switchJointL(iWagon :LeftTrain )  {
        self.physicsWorld.remove(joint1)
        if let wagonPhysicBody = iWagon.physicsBody , let kittyPhysicBody = kitty.physicsBody {
            
            kitty.position.x  = iWagon.frame.maxX - kitty.size.width / 2
            kitty.position.y  = iWagon.frame.maxY
            
            joint1 = SKPhysicsJointPin.joint(withBodyA: wagonPhysicBody , bodyB: kittyPhysicBody, anchor: CGPoint(x: iWagon.frame.midX, y: iWagon.frame.midY))
            self.physicsWorld.add(joint1)
            score = score + 1
        }
        
        
    }


    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            if let wagonName = node.name {
            switch wagonName {
            case "rightTrain1":
                switchJoint(iWagon:rightTrain1)
            case "leftTrain1":
                switchJointL(iWagon:leftTrain1)
             case "rightTrain2":
                switchJoint(iWagon:rightTrain2)
             case "leftTrain2":
                switchJointL(iWagon:leftTrain2)
             case "rightTrain3":
                switchJoint(iWagon:rightTrain3)
            default:
                break
                
            }
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
    func scoreSetup()  {
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.zPosition = 1
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x:0,y:self.frame.maxY - 200)
        scoreLabel.fontSize=250
        scoreLabel.fontColor=UIColor.white
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        self.addChild(scoreLabel)
        scoreLabelHelper = SKLabelNode(fontNamed: "Arial")
        scoreLabelHelper.zPosition = 1
        scoreLabelHelper.text = "Current Score"
        scoreLabelHelper.position = CGPoint(x:0,y:self.frame.maxY - 300)
        scoreLabelHelper.fontSize=30
        scoreLabelHelper.fontColor=UIColor.white
        scoreLabelHelper.horizontalAlignmentMode = .center
        scoreLabelHelper.verticalAlignmentMode = .center
        self.addChild(scoreLabelHelper)
        
        highScoreLabel = SKLabelNode(fontNamed: "Arial")
        highScoreLabel.zPosition = 1

        highScoreLabel.text = "High Score : \(SharingManager.sharedInstance.highScore)"

        highScoreLabel.position = CGPoint(x:self.frame.maxX - 125, y:self.frame.maxY - 50)
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = UIColor.white

        self.addChild(highScoreLabel)
    }
    //track position setup
    func trackSetup()  {
    
        trainTrack1.position = CGPoint(x: trainXpostion, y:trainYpostion)
        self.addChild(trainTrack1)
        
        trainTrack2.position = CGPoint(x: trainXpostion, y:trainYpostion + trainDiffpostion)
        self.addChild(trainTrack2)
        
        trainTrack3.position = CGPoint(x: trainXpostion, y:trainYpostion + (trainDiffpostion * 2))
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
        
        leftTrain1.position = CGPoint(x: self.frame.maxX + leftTrain1.size.width , y:trainTrack2.position.y  + trainTrack2.size.height)
        leftTrain1.name = "leftTrain1"
        
        self.addChild(leftTrain1)
        
        
        // fourth train from down
        leftTrain2.position = CGPoint(x: self.frame.maxX + leftTrain2.size.width , y:trainTrack4.position.y  + trainTrack3.size.height )
        leftTrain2.name = "leftTrain2"
        
        self.addChild(leftTrain2)
        
        
    }
    
    func rightTrainSetup()  {
        
        let  htrainHeight = rightTrain1.size.height / 2
        let  htrainWidth = rightTrain1.size.width
        let  trackHeight = trainTrack1.size.height
        
        //last train
        
        rightTrain1.position = CGPoint(x: self.frame.minX + htrainWidth , y:trainTrack1.position.y  + trackHeight )
        rightTrain1.name = "rightTrain1"
        self.addChild(rightTrain1)
        
        
        //third train
        
        rightTrain2.position = CGPoint(x: self.frame.minX - rightTrain2.size.width , y:trainTrack3.position.y  + trackHeight )
        rightTrain2.name = "rightTrain2"
        self.addChild(rightTrain2)
        
        
        //5th from down
        
        rightTrain3.position = CGPoint(x:self.frame.minX - rightTrain3.size.width , y:trainTrack5.position.y  + trainTrack3.size.height )
        rightTrain3.name = "rightTrain3"
        self.addChild(rightTrain3)
        
    }
    
    func moveRightWagon(irWagon:RightTrain, itrack:TrainTrack)  {
        
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + irWagon.size.height/2
        let path = CGMutablePath()
        
        if  irWagon.name == "rightTrain1"{
            path.move(to: CGPoint(x: self.frame.minX + irWagon.size.width, y: yPostionC))
            
        }else{
            path.move(to: CGPoint(x: self.frame.minX - irWagon.size.width , y: yPostionC))
            
        }
        path.addLine(to: CGPoint(x: self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 10.0)
        
        //irWagon.run(followLine)
        irWagon.run(
            SKAction.repeatForever(
                SKAction.sequence([
                    followLine
                    
                    ])
            )
            
        )
        
    }
    
    func moveLeftTrain(ilTrain:LeftTrain, itrack:TrainTrack)  {
        // TODO: merlin fix this function similar to right train move
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + ilTrain.size.height/2
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.frame.maxX  + ilTrain.size.width , y: yPostionC))
        path.addLine(to: CGPoint(x: -self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 15.0)
        // let reversedLine = followLine.reversed()
      //  ilTrain.run(followLine)
        ilTrain.run(
            SKAction.repeatForever(
                SKAction.sequence([
                                   followLine

                    ])
            )
            
        )
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
            showLost()
            
        }
        
        if firstBody.categoryBitMask == category_kitty && secondBody.categoryBitMask == category_train {
            // kitty.physicsBody?.pinned = true
            print("Kitty hit train. First contact has been made.")
            //kitty.removeFromParent()
            //showLost()
            
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
    
    //MARK: - SKScene functions
    
    override func didMove(to view: SKView) {
        

        
        //code to move the train
        moveRightWagon(irWagon: rightTrain1, itrack:trainTrack1 )
        moveLeftTrain(ilTrain: leftTrain1, itrack: trainTrack2)
        moveRightWagon(irWagon: rightTrain2, itrack:trainTrack3)
        moveLeftTrain(ilTrain: leftTrain2, itrack: trainTrack4)
        moveRightWagon(irWagon: rightTrain3, itrack:trainTrack5 )
 
         self.physicsWorld.contactDelegate = self
        
    }
    
    
    func trainyPostionCal(delta : Int) -> CGFloat {
        
        // TODO: merlin fix this function and call this in setup functions
        
        
        let calcYpostion = trainYpostion  + trainDiffpostion  + trainTrack1.size.height
        
        return calcYpostion
    }
    
    func showLost() {
        
        if score >  SharingManager.sharedInstance.highScore {
            SharingManager.sharedInstance.highScore = score
        }
        self.gamePaused = true
        let alert = UIAlertController(title: "Game Over", message: "Do you want to restart the game ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)  { _ in
            let transition = SKTransition.doorsCloseHorizontal(withDuration: 1) 
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.view?.presentScene(scene,transition: transition)
            }
            
            
        })

        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }

    


}


