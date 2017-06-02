//
//  Scores.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import SpriteKit
import UIKit

class Scores: SKScene
{
    //hack for a button, done in the touches began
    var playButton: SKLabelNode?
    
    //title of game
    var statTitle: SKLabelNode?
    
    //highscore
    var highScoreLabel: SKLabelNode?
    
    //total jumps
    var totalJumpsLabel: SKLabelNode?
    
    //total blocks
    var totalBlocksLabel: SKLabelNode?
    
    //scores button
    var backButton: SKLabelNode?
    
    //gives background
    var background: SKSpriteNode?
    
    //holder for the read in highscore
    var highScore: String?
    
    //holder for the read in jumps
    var totalJumps: String?
    
    //holder for the read in blocks
    var totalBlocks: String?
    
    //holds stats
    var statsArray: NSMutableArray = [0]
    
    
    override func didMoveToView(view: SKView)
    {
        //grabs the data
        loadFromFile()
        
        
        //if there is nothing written yet, just present nothing
        if(highScore == nil)
        {
            highScore = ""
        }
        if(totalJumps == nil)
        {
            totalJumps = ""
        }
        if(totalBlocks == nil)
        {
            totalBlocks = ""
        }
        
        //sets background coolor
        self.backgroundColor = UIColor.blackColor()
        
        //sets up the title
        statTitle = SKLabelNode(text: "S T A T S")
        statTitle?.fontColor = UIColor.whiteColor()
        statTitle?.fontSize = 40
        statTitle?.fontName = "Verdana-Bold"
        statTitle?.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - 200)
        
        //sets up the title
        highScoreLabel = SKLabelNode(text: "High Score: \(highScore!)")
        highScoreLabel?.fontColor = UIColor.whiteColor()
        highScoreLabel?.fontSize = 25
        highScoreLabel?.fontName = "Verdana-Bold"
        highScoreLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 75)
        
        //sets up the title
        totalJumpsLabel = SKLabelNode(text: "Total Jumps: \(totalJumps!)")
        totalJumpsLabel?.fontColor = UIColor.whiteColor()
        totalJumpsLabel?.fontSize = 25
        totalJumpsLabel?.fontName = "Verdana-Bold"
        totalJumpsLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        //sets up the title
        totalBlocksLabel = SKLabelNode(text: "Total Blocks Crossed: \(totalBlocks!)")
        totalBlocksLabel?.fontColor = UIColor.whiteColor()
        totalBlocksLabel?.fontSize = 25
        totalBlocksLabel?.fontName = "Verdana-Bold"
        totalBlocksLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 75)
        
        //sets up playButton
        backButton = SKLabelNode(text: "BACK")
        backButton?.fontColor = UIColor.whiteColor()
        backButton?.fontSize = 20
        backButton?.fontName = "Verdana-Bold"
        backButton?.name = "backButton"
        backButton?.position = CGPoint(x: 100, y: self.frame.height - 150)
        
        //adds nodes to scene
        addChild(statTitle!)
        addChild(highScoreLabel!)
        addChild(totalJumpsLabel!)
        addChild(totalBlocksLabel!)
        addChild(backButton!)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch: UITouch = (touches.first as UITouch?)!
        
        let location = touch.locationInNode(self)
        let nodeTouched = self.nodeAtPoint(location)
        
        //if they press play
        if nodeTouched.name == "backButton"
        {
            let transition = SKTransition.doorsCloseHorizontalWithDuration(1)
            
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        //if they press play
        if nodeTouched.name == "scoresButton"
        {
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
            
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
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
            //                let totalJumpsString = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            //                let totalBlocksString = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            
            highScore = arrayOfStats[0]
            totalJumps = arrayOfStats[1]
            totalBlocks = arrayOfStats[2]
            
        }
        
    }
    
    
    //NOT USING
    func loadFromPlist()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("stats.plist")

        statsArray = NSMutableArray(contentsOfFile: path)!
        highScore = String(statsArray[0] as! NSString)
        totalJumps = String(statsArray[1] as! NSString)
        totalBlocks = String(statsArray[2] as! NSString)
        
    }
    
}
