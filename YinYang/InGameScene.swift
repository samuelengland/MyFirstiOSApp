//
//  InGameScene.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import SpriteKit
import UIKit

//helps collision
enum BodyType: UInt32
{
    case runner = 1
    case ground = 2
    //possibly put holes
}

//delegate to the deathScene to show score
protocol ScoreDelegate: class
{
    func showScore(sentScore: Int)
}

class InGameScene: SKScene, SKPhysicsContactDelegate
{
    //your main character runner
    var runnerNode: Runner?
    
    //object holder for the ground
    var platform: Object?
    
    //creates a node for the background
    var background = SKSpriteNode()
    
    //creates the score label
    var scoreLabel = SKLabelNode()
    
    //keeps track of score
    var _score: Int = 0
    
    var totalJumps: Int = 0
    
    //holder for total blocks
    var totalBlocks: Int = 0
    
    //doesnt work right now
    var firstUpdate: Bool = true
    
    //set up the delegate
    var scoreDelegate: ScoreDelegate? = nil
    
    //helps index the current color of the object runner is above
    var currentObjectIndex: Int = 0
    
    //stores the array of all colors for the objects
    var objectColors: [String] = []
    
    //holds the stats to append to
    var statsArray: NSMutableArray = [0]
    
    
    //currentgamestats
    var jumps: Int = 0
    var blocks: Int = 0
    
    override func didMoveToView(view: SKView)
    {
        
        //sets up score
        _score = 0
        
        //helps keep the flow of transitions nice
        let wait = SKAction.waitForDuration(2)
        self.runAction(wait)
        
        //creates the moving background
        createBackground()
        
        //sets up score
        scoreLabel = SKLabelNode(text: "\(_score)")
        scoreLabel.fontName = "Verdana-Bold"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = UIColor.whiteColor()
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - 150)
        addChild(scoreLabel)
        
        
        //creates data for the ground
        let groundData:[String: String] = [ /*"ImageName": "whiteSpikes",*/
            "GroundType": "square",
            "Location": "{0,100}",
            "PlaceMultiplesOnX": "200"]
        
        
        //sets up contact delegate
        physicsWorld.contactDelegate = self
        
        //sets up the runner
        runnerNode = Runner(imageNamed: "yinYang")
        runnerNode!.position = CGPointMake(150, 600)
        runnerNode?.setBlack()
        addChild(runnerNode!)
        
        //sets up the ground
        platform = Object(theDict: groundData)
        
        addChild(platform!)
        
        //store the colors of all the objects
        objectColors = platform!.groundColorArray
        
        
        
    }
    
    //gets called on initial collision
    func didBeginContact(contact: SKPhysicsContact)
    {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask)
        {
            //after contact set to running
        case BodyType.runner.rawValue | BodyType.ground.rawValue:
            runnerNode?.setRunning()
            
            //runners outer color is black
            if(runnerNode?.returnColor() == "black" && objectColors[currentObjectIndex-1] == "black")
            {
                let wait = SKAction.waitForDuration(2)
                self.runAction(wait)
                
                let deathScene = DeathScene(size: self.scene!.size)
                deathScene.scaleMode = SKSceneScaleMode.AspectFill
                self.scoreDelegate = deathScene
                scoreDelegate?.showScore(_score)
                self.scene?.view?.presentScene(deathScene)
                
                
                ////////WRITING AND READING TO FILE///////////////
                loadFromFile()
                writeToFile()

                

            }
            
            //runners outer color is white
            if(runnerNode?.returnColor() == "white" && objectColors[currentObjectIndex-1] == "white")
            {
                let wait = SKAction.waitForDuration(2)
                self.runAction(wait)
                
                let deathScene = DeathScene(size: self.scene!.size)
                deathScene.scaleMode = SKSceneScaleMode.AspectFill
                self.scoreDelegate = deathScene
                scoreDelegate?.showScore(_score)
                self.scene?.view?.presentScene(deathScene)
                
                
                ////////WRITING AND READING TO FILE///////////////
                writeToFile()
                loadFromFile()
//                writeToFile()

            }

            
            
        default:
            return
        }
    }
    
    
    //gets called at the end of collision
    func didEndContact(contact: SKPhysicsContact)
    {
        //this gets called automatically
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self)
            
            //if they click near the runner
            if( location.x < 325 && location.y < 350)
            {
                //if the current color is black, set it to white and vice versa
                if(runnerNode?.returnColor() == "black")
                {
                    runnerNode?.setWhite()
                }
                else
                {
                    runnerNode?.setBlack()
                }
            }
            

            //they click anywhere but the on the runner
            else
            {
                //if running, let jump ... if jumping, dont do anything
                if(runnerNode!.returnState() == "running")
                {
                    runnerNode?.physicsBody?.velocity = CGVectorMake(0, 0)
                    
                    runnerNode?.physicsBody?.applyImpulse(CGVectorMake(0, 60))
                    
                    //set to jumping
                    runnerNode?.setJumping()
                    
                    //increments current game jumps
                    jumps += 1
                    
                }
                else
                {
                    //else do nothing
                    return
                }
            }
            
        }
    }
    
    //hack to make it look like the background is always moving
    func createBackground()
    {
        
        let backgroundTexture = SKTexture(imageNamed: "hexBackground")
        
        //action to move background right to left; replace
        let shiftBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 2.5)
        
        //action to replace the background
        let replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y: 0, duration: 0)
        
        //everytime shiftbackground is finishes, replace background
        let movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        //to create a crisp flow, have 5
        for i in 1 ..< 5
        {
            
            background = SKSpriteNode(texture:backgroundTexture)
            
            background.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * CGFloat(i)), y: CGRectGetMidY(self.frame))
            
            background.size.height = self.frame.height
            
            background.runAction(movingAndReplacingBackground)
            
            self.addChild(background)
            
        }
        
    }
    
    
    override func update(currentTime: NSTimeInterval)
    {
        if( Int(platform!.position.x) < (currentObjectIndex * -336))
        {
            currentObjectIndex += 1
            blocks += 1
        }
        
        //called before each frame is rendered, doesnt do anything right now
        if(firstUpdate == true)
        {
            _ = SKAction.waitForDuration(2)
            firstUpdate = false
        }
        
        //make it harder
        if(_score > 1000)
        {
            platform?.position.x-=16.8
        }
        //make it even harder
        else if(_score > 2500)
        {
            platform?.position.x-=22.4
        }
        else
        {
            //makes the ground move
            platform?.position.x-=11.2
        }
        _score += 1
        scoreLabel.text = "\(_score)"
        scoreLabel.zPosition = 1
        
        
        //goes to game end
        if(runnerNode?.position.y < 0) //add or contact on left side of an object
        {
            let wait = SKAction.waitForDuration(2)
            self.runAction(wait)
            
            let deathScene = DeathScene(size: self.scene!.size)
            deathScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scoreDelegate = deathScene
            scoreDelegate?.showScore(_score)
            self.scene?.view?.presentScene(deathScene)
        }
        
        //fixes the runner's position
        if(runnerNode?.position.x < 150)
        {
            runnerNode?.position.x = 150
        }
        
    }
    
    
    
    
    func writeToFile()
    {
        let file = "stats.txt"
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        {
            let dir = dirs[0] //documents directory
            let path = (dir as NSString).stringByAppendingPathComponent(file);
            let text1 = String("\(_score),\(totalJumps),\(totalBlocks)")
            
            do {
                //writing
                try text1.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            } catch _ {
            }
            
        }
    }
    
    func loadFromFile()
    {
            let file = "stats.txt"
            
            if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
            {
                let dir = dirs[0] //documents directory
                let path = (dir as NSString).stringByAppendingPathComponent(file);
                
                //reading
                let incomingString = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                var arrayOfStats = incomingString.componentsSeparatedByString(",")
                
                //check to see if the array is valid
                if(arrayOfStats.count != 3)
                {
                    
                    totalJumps = jumps
                    totalBlocks = blocks
                }
                else
                {
                    //takes care of highest score
                    if(_score < Int(arrayOfStats[0]))
                    {
                        _score = Int(arrayOfStats[0])!
                    }
                    
                    totalJumps = jumps + Int(arrayOfStats[1])!
                    totalBlocks = blocks + Int(arrayOfStats[2])!
                }
            }
        
    }
    
    
    //NOT USING
    func writeToPlist()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let path = (paths as NSString).stringByAppendingPathComponent("stats.plist")
        
        if let plistArray = NSMutableArray(contentsOfFile: path)
        {
            plistArray.addObject(_score)
            plistArray.addObject(totalJumps)
            plistArray.addObject(totalBlocks)
            plistArray.writeToFile(path, atomically: false)
        }
    }
    
    
    
    //NOT USING
    func loadFromPlist()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("stats.plist")
        let fileManager = NSFileManager.defaultManager()
        if(!fileManager.fileExistsAtPath(path))
        {
            let bundle = NSBundle.mainBundle().pathForResource("FavouriteIndex", ofType: "plist")
            do {
                try fileManager.copyItemAtPath(bundle!, toPath: path)
            } catch _ {
            }
        }
        statsArray = NSMutableArray(contentsOfFile: path)!
        
        if(Int(statsArray[0] as! NSNumber) < _score)
        {
            _score = Int(statsArray[0] as! NSNumber)
        }
        totalJumps = Int(statsArray[1] as! NSNumber) + jumps
        totalBlocks = Int(statsArray[2] as! NSNumber) + blocks
        
    }
    
}
