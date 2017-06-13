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
    
    let wagon1  = Wagon()
    let wagon2  = Wagon()
    let wagon3  = Wagon()
    let wagon4  = Wagon()
    let wagon5  = Wagon()
    
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
        
        kitty.position = wagon1.position
        self.addChild(kitty)
        joint1 = SKPhysicsJointPin.joint(withBodyA: wagon1.physicsBody! , bodyB: kitty.physicsBody!, anchor: CGPoint(x: self.wagon1.frame.midX, y: self.wagon1.frame.midY))
        
       
       self.physicsWorld.add(joint1)
        
    }
    // MARK:    functions to make actors move
    //track position setup
    func jumpKitty( xPostion:Int)   {
        
       // let jump = SKAction.applyImpulse(CGVector(dx: xPostion, dy: 300), duration: 0.3)
       // kitty.run(jump)

    }
    
    /* Called when a touch begins */
    
    func switchJoint(iWagon :Wagon )  {
        self.physicsWorld.remove(joint1)
        if let wagonPhysicBody = iWagon.physicsBody , let kittyPhysicBody = kitty.physicsBody {
            kitty.position = iWagon.position

            joint1 = SKPhysicsJointPin.joint(withBodyA: wagonPhysicBody , bodyB: kittyPhysicBody, anchor: CGPoint(x: iWagon.frame.midX, y: iWagon.frame.midY))
            self.physicsWorld.add(joint1)
            score = score + 1
        }

        
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
                moveRightWagon(irWagon: wagon3, itrack:trainTrack3 )
            case "wagon3":
                switchJoint(iWagon:wagon3)
                 moveLeftWagon(ilTrain: wagon4,itrack:trainTrack4)
            case "wagon4":
                switchJoint(iWagon:wagon4)
                moveRightWagon(irWagon: wagon5, itrack:trainTrack5 )
            case "wagon5":
                switchJoint(iWagon:wagon5)
            default:
                break
                
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
    func scoreSetup()  {
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.zPosition = 1
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x:0,y:self.frame.maxY - 250)
        scoreLabel.fontSize=250
        scoreLabel.fontColor=UIColor.white
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .center
        self.addChild(scoreLabel)
        scoreLabelHelper = SKLabelNode(fontNamed: "Arial")
        scoreLabelHelper.zPosition = 1
        scoreLabelHelper.text = "Current Score"
        scoreLabelHelper.position = CGPoint(x:0,y:self.frame.maxY - 400)
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
        
        wagon2.position = CGPoint(x: self.frame.maxX + wagon2.size.width , y:trainTrack2.position.y  + trainTrack2.size.height)
        wagon2.name = "wagon2"
        
        self.addChild(wagon2)
        
        
        // fourth train from down
        wagon4.position = CGPoint(x: self.frame.maxX + wagon4.size.width , y:trainTrack4.position.y  + trainTrack3.size.height )
        wagon4.name = "wagon4"
        
        self.addChild(wagon4)
        
        
    }
    
    func rightTrainSetup()  {
        
        let  htrainHeight = rightTrain1.size.height / 2
        let  htrainWidth = rightTrain1.size.width / 2
        let  trackHeight = trainTrack1.size.height
        
        //last train
        
        wagon1.position = CGPoint(x: self.frame.minX + wagon1.size.width , y:trainTrack1.position.y  + trackHeight )
        wagon1.name = "wagon1"
        self.addChild(wagon1)
        
        rightTrain1.position = CGPoint(x: wagon1.frame.maxX + htrainWidth  , y:trainTrack1.position.y  + trackHeight  + htrainHeight)
         rightTrain1.name = "train1"
         self.addChild(rightTrain1)
        let train1joint = SKPhysicsJointPin.joint(withBodyA: wagon1.physicsBody! , bodyB: rightTrain1.physicsBody!, anchor: CGPoint(x: self.rightTrain1.frame.minX, y: self.rightTrain1.frame.minY))
        
        self.physicsWorld.add(train1joint)
        
        //third train
        
        wagon3.position = CGPoint(x: self.frame.minX - wagon1.size.width , y:trainTrack3.position.y  + trackHeight )
        wagon3.name = "wagon3"
        self.addChild(wagon3)
        
        rightTrain3.position = CGPoint(x: wagon3.frame.maxX + htrainWidth  , y:trainTrack3.position.y  + trackHeight  + htrainHeight)
        rightTrain3.name = "train3"
        self.addChild(rightTrain3)
        let train3joint = SKPhysicsJointPin.joint(withBodyA: wagon3.physicsBody! , bodyB: rightTrain3.physicsBody!, anchor: CGPoint(x: self.rightTrain3.frame.minX, y: self.rightTrain3.frame.minY))
        
        self.physicsWorld.add(train3joint)
        
        //5th from down
        
        wagon5.position = CGPoint(x:self.frame.minX - wagon1.size.width , y:trainTrack5.position.y  + trainTrack3.size.height )
        wagon5.name = "wagon5"
        self.addChild(wagon5)
        
    }
    
        func moveRightWagon(irWagon:Wagon, itrack:TrainTrack)  {
        
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + irWagon.size.height/2
        let path = CGMutablePath()
        
            if  irWagon.name == "wagon1"{
                path.move(to: CGPoint(x: self.frame.minX + irWagon.size.width , y: yPostionC))

            }else{
                path.move(to: CGPoint(x: self.frame.minX - irWagon.size.width , y: yPostionC))

            }
        path.addLine(to: CGPoint(x: self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 10.0)
         
        irWagon.run(
            SKAction.repeatForever(
                SKAction.sequence([
                                   followLine

                    ])
            )
            
        )
        
    }
    
    func moveLeftWagon(ilTrain:Wagon, itrack:TrainTrack)  {
        // TODO: merlin fix this function similar to right train move
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + ilTrain.size.height/2
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.frame.maxX  + ilTrain.size.width , y: yPostionC))
        path.addLine(to: CGPoint(x: -self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 10.0)
        // let reversedLine = followLine.reversed()
        
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
        moveRightWagon(irWagon: wagon1, itrack:trainTrack1 )
         moveLeftWagon(ilTrain: wagon2, itrack: trainTrack2)
        self.physicsWorld.contactDelegate = self
        
    }
    
    
    func trainyPostionCal(delta : Int) -> CGFloat {
        
        // TODO: merlin fix this function and call this in setup functions
        
        
        let calcYpostion = trainYpostion  + trainDiffpostion  + trainTrack1.size.height
        
        return calcYpostion
    }
    
    func showLost() {
        
        if score > highScore {
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


