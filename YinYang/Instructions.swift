//
//  Instructions.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import SpriteKit
import UIKit


class Instructions: SKScene, ScoreDelegate
{
    //title of game
    var instTitle: SKLabelNode?
    
    //scores button
    var backButton: SKLabelNode?
    
    //Writing all the instructions, there has got to be a better way to do this
    var tapScreenInst: SKLabelNode?
    var changeColorInst: SKLabelNode?
    var colorInst: SKLabelNode?         //this was too long, cant wrap labelnodes
    var colorInstCont1: SKLabelNode?
    var colorInstCont2: SKLabelNode?
    var spikesInst: SKLabelNode?
    
    //gives background
    var background: SKSpriteNode?
    
    //score to display
    var score: Int?
    
    
    override func didMoveToView(view: SKView)
    {
        self.backgroundColor = UIColor.blackColor()
        
        //sets up the title
        instTitle = SKLabelNode(text: "H O W  T O  P L A Y")
        instTitle?.fontColor = UIColor.whiteColor()
        instTitle?.fontSize = 40
        instTitle?.fontName = "Verdana-Bold"
        instTitle?.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - 200)
        
        //jumping instructions
        tapScreenInst = SKLabelNode(text: "JUMP: Tap anywhere but the bottom left of the screen")
        tapScreenInst?.fontColor = UIColor.whiteColor()
        tapScreenInst?.fontSize = 25
        tapScreenInst?.fontName = "Verdana-Bold"
        tapScreenInst?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 75)
        
        //color instructions
        colorInst = SKLabelNode(text: "COLORS: Your outer color determines what colors you color ")
        colorInst?.fontColor = UIColor.whiteColor()
        colorInst?.fontSize = 25
        colorInst?.fontName = "Verdana-Bold"
        colorInst?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        //color instructions
        colorInstCont1 = SKLabelNode(text: "of ground you can touch, your outer color can only")
        colorInstCont1?.fontColor = UIColor.whiteColor()
        colorInstCont1?.fontSize = 25
        colorInstCont1?.fontName = "Verdana-Bold"
        colorInstCont1?.position = CGPoint(x:CGRectGetMidX(self.frame) + 65, y:CGRectGetMidY(self.frame) - 20)
        
        //color instructions
        colorInstCont2 = SKLabelNode(text: "touch your runner's opposite color")
        colorInstCont2?.fontColor = UIColor.whiteColor()
        colorInstCont2?.fontSize = 25
        colorInstCont2?.fontName = "Verdana-Bold"
        colorInstCont2?.position = CGPoint(x:CGRectGetMidX(self.frame) + 40, y:CGRectGetMidY(self.frame) - 40)
        
        //changing color instructions
        changeColorInst = SKLabelNode(text: "CHANGE PHASE: Tap the bottom left of the screen")
        changeColorInst?.fontColor = UIColor.whiteColor()
        changeColorInst?.fontSize = 25
        changeColorInst?.fontName = "Verdana-Bold"
        changeColorInst?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 100)
    
        //spikes instructions
        spikesInst = SKLabelNode(text: "SPIKES: Try to avoid them")
        spikesInst?.fontColor = UIColor.whiteColor()
        spikesInst?.fontSize = 25
        spikesInst?.fontName = "Verdana-Bold"
        spikesInst?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 175)
        
        //sets up playButton
        backButton = SKLabelNode(text: "BACK")
        backButton?.fontColor = UIColor.whiteColor()
        backButton?.fontSize = 20
        backButton?.fontName = "Verdana-Bold"
        backButton?.name = "backButton"
        backButton?.position = CGPoint(x: 100, y: self.frame.height - 150)
        
        
        //add to scene
        addChild(instTitle!)
        addChild(tapScreenInst!)
        addChild(changeColorInst!)
        addChild(colorInst!)
        addChild(colorInstCont1!)
        addChild(colorInstCont2!)
        addChild(spikesInst!)
        addChild(backButton!)
        
        
    }
    
    
    func showScore(sentScore: Int)
    {
        score = sentScore
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch: UITouch = (touches.first as UITouch?)!
        
        let location = touch.locationInNode(self)
        let nodeTouched = self.nodeAtPoint(location)
                
        //if they press play
        if nodeTouched.name == "playButton"
        {
        
            let transition = SKTransition.crossFadeWithDuration(1.0)
            
            let scene = InGameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        //if they press play
        if nodeTouched.name == "backButton"
        {
            let transition = SKTransition.doorsCloseHorizontalWithDuration(1)
            
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        
    }
    
}
