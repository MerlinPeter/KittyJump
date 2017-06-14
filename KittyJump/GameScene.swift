//
//  GameScene.swift
//  KittyJump
//
//  Created by Merlin Ahila on 6/9/17.
//  Copyright © 2017 Merlin Ahila. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

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

    
    /* Called when a touch begins */
    
    func switchJoint(iWagon :RightTrain )  {
        
        let trainBeforeJump  = joint1.bodyA.node
       
        self.physicsWorld.remove(joint1)
        
        trainBeforeJump?.removeAllActions()
        trainBeforeJump?.removeFromParent()
        
        if let wagonPhysicBody = iWagon.physicsBody , let kittyPhysicBody = kitty.physicsBody {
            
            kitty.position.x  = iWagon.frame.minX + kitty.size.width / 2
            kitty.position.y  = iWagon.frame.maxY

            joint1 = SKPhysicsJointPin.joint(withBodyA: wagonPhysicBody , bodyB: kittyPhysicBody, anchor: CGPoint(x: iWagon.frame.minX, y: iWagon.frame.midY))
            self.physicsWorld.add(joint1)
            score = score + 1
        }

        
    }
    
    func switchJointL(iWagon :LeftTrain )  {
        
        let trainBeforeJump  = joint1.bodyA.node
        
        self.physicsWorld.remove(joint1)
        
        trainBeforeJump?.removeAllActions()
        trainBeforeJump?.removeFromParent()
        
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
                    locationDetectR(train: rightTrain1, location: location)
                case "leftTrain1":
                    locationDetectL(train: leftTrain1, location: location)
                case "rightTrain2":
                    locationDetectR(train: rightTrain2, location: location)
                case "leftTrain2":
                    locationDetectL(train: leftTrain2, location: location)
                case "rightTrain3":
                    locationDetectR(train: rightTrain3, location: location)
                    
                default:
                    //self.physicsWorld.removeAllJoints()
                   // kitty.position = location
                    break
                    
                }
            }
            
            
        }
        
        
    }
    
    func locationDetectR(train:RightTrain, location:CGPoint) {
        if (location.x < (train.frame.minX + 100)){
            
            switchJoint(iWagon:train)
            if (train.name == "rightTrain3"){
                showStop(reason : "Game Won !!!")
            }
            
        }else{
            showStop(reason :"Game Over !!! Train Hit")
            
        }
        
    }
    func locationDetectL(train:LeftTrain, location:CGPoint) {
        if (location.x > (train.frame.maxX - 100)){
            
            switchJointL(iWagon:train)
        }else{
            showStop(reason :"Game Over !!! Train Hit")
            
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
        scoreLabelHelper.position = CGPoint(x:0,y:self.frame.maxY - 325)
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
        
        for c in 0...4 {
            let grass = Grass()
            grass.position = getTilePosition( row: c)
            self.addChild(grass)
        }
        
    }
    
    func getTilePosition( row:Int) -> CGPoint
    {
        let x = self.frame.minX
        let y = trainYpostion  + trainDiffpostion * CGFloat(row)  + trainTrack1.size.height
        return CGPoint(x: x, y: y)
    }
    
    
    func leftTrainSetup()  {
        
        //second train from  down
        
        leftTrain1.position = CGPoint(x: self.frame.maxX + leftTrain1.size.width/2 , y:trainTrack2.position.y  + trainTrack2.size.height)
        leftTrain1.name = "leftTrain1"
        
        self.addChild(leftTrain1)
        
        
        // fourth train from down
        leftTrain2.position = CGPoint(x: self.frame.maxX + leftTrain2.size.width/2 , y:trainTrack4.position.y  + trainTrack3.size.height )
        leftTrain2.name = "leftTrain2"
        
        self.addChild(leftTrain2)
        
        
    }
    
    func rightTrainSetup()  {
        
        let  htrainWidth = rightTrain1.size.width
        let  trackHeight = trainTrack1.size.height
        
        //last train
        
        rightTrain1.position = CGPoint(x: self.frame.minX + (htrainWidth-200) , y:trainTrack1.position.y  + trackHeight )
        rightTrain1.name = "rightTrain1"
        self.addChild(rightTrain1)
        
        
        //third train
        
        rightTrain2.position = CGPoint(x: self.frame.minX + rightTrain2.size.width - 300 , y:trainTrack3.position.y  + trackHeight )
        rightTrain2.name = "rightTrain2"
        self.addChild(rightTrain2)
        
        
        //5th from down
        
        rightTrain3.position = CGPoint(x:self.frame.minX + rightTrain3.size.width - 300, y:trainTrack5.position.y  + trainTrack3.size.height )
        rightTrain3.name = "rightTrain3"
        self.addChild(rightTrain3)
        
    }
    
    func moveRightWagon(irWagon:RightTrain, itrack:TrainTrack)  {
        
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + irWagon.size.height/2
        let path = CGMutablePath()
        
        if  irWagon.name == "rightTrain1"{
            path.move(to: CGPoint(x: self.frame.minX + irWagon.size.width - 200, y: yPostionC))
            
        }else{
            path.move(to: CGPoint(x: self.frame.minX + irWagon.size.width - 300, y: yPostionC))
            
        }
        path.addLine(to: CGPoint(x: self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: TimeInterval(randRange(lower: 15, upper: 25)))

         irWagon.run(
            
            SKAction.repeatForever(
                
                SKAction.sequence([
                
                    followLine
                    
                    ])
            )
            
        )
        
    }
    
    func moveLeftTrain(ilTrain:LeftTrain, itrack:TrainTrack)  {
        
        let yPostionC :CGFloat = itrack.position.y  + itrack.size.height + ilTrain.size.height/2
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.frame.maxX  + ilTrain.size.width/2 , y: yPostionC))
        path.addLine(to: CGPoint(x: -self.frame.size.width , y: yPostionC))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: TimeInterval(randRange(lower: 20, upper: 25)))
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
        
 
 
        if firstBody.categoryBitMask == category_kitty && secondBody.categoryBitMask == category_border {
           // print("Kitty hit border. First contact has been made.")
            kitty.removeFromParent()
            showStop(reason:"Game Over !!! Kitty hit border")
            
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
        if firstBody.categoryBitMask == category_kitty && secondBody.categoryBitMask == category_train {
            
            print("Kitty jumped from  train.")
        
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
    
    
    
    func showStop(reason:String) {
        
        if score >  SharingManager.sharedInstance.highScore {
            SharingManager.sharedInstance.highScore = score
        }
        self.gamePaused = true
        let alert = UIAlertController(title: "Kitty Jump" , message:  reason + " Do you want to restart the game ", preferredStyle: UIAlertControllerStyle.alert)
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

    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }

}


