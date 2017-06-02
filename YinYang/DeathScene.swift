//
//  DeathScene.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import SpriteKit
import UIKit


class DeathScene: SKScene, ScoreDelegate
{
    //hack for a button, done in the touches began
    var playButton: SKLabelNode?
    
    //title of game
    var scoreTitle: SKLabelNode?
    
    //scores button
    var scoresButton: SKLabelNode?
    
    var backButton: SKLabelNode?
    
    //gives background
    var background: SKSpriteNode?
    
    //sets picture of background
    var backgroundTexture = SKTexture(imageNamed: "brokenYinYang")
    
    //score to display
    var score: Int?
    
    
    override func didMoveToView(view: SKView)
    {
        //sets background to black for transparency of the picture
        self.backgroundColor = UIColor.blackColor()
        background = SKSpriteNode(texture: backgroundTexture)
        
        //sizes the sprite,
        background?.size = self.frame.size
        background?.setScale(0.5)
        
        //adds to scene + positions
        background?.position = CGPoint(x: CGRectGetMidX(self.frame),y: CGRectGetMidY(self.frame))
        addChild(background!)
        
        
        //sets up the title
        scoreTitle = SKLabelNode(text: "SCORE: \(score!)")
        scoreTitle?.fontColor = UIColor.whiteColor()
        scoreTitle?.fontSize = 40
        scoreTitle?.fontName = "Verdana-Bold"
        scoreTitle?.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - 150)
        
        
        //sets up playButton
        playButton = SKLabelNode(text: "PLAY AGAIN")
        playButton?.fontColor = UIColor.whiteColor()
        //playButton.c
        playButton?.fontSize = 40
        playButton?.fontName = "Verdana-Bold"
        playButton?.name = "playButton"
        playButton?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 250)
        
        //sets up playButton
        backButton = SKLabelNode(text: "BACK")
        backButton?.fontColor = UIColor.whiteColor()
        backButton?.fontSize = 20
        backButton?.fontName = "Verdana-Bold"
        backButton?.name = "backButton"
        backButton?.position = CGPoint(x: 100, y: self.frame.height - 150)
        
        //sets up playButton
        scoresButton = SKLabelNode(text: "SCORES")
        scoresButton?.fontColor = UIColor.whiteColor()
        scoresButton?.fontSize = 20
        scoresButton?.fontName = "Verdana-Bold"
        scoresButton?.name = "scoresButton"
        scoresButton?.position = CGPoint(x: self.frame.width - 150, y: self.frame.height - 150)
        
        
        addChild(scoreTitle!)
        addChild(playButton!)
        addChild(scoresButton!)
        addChild(backButton!)
        
        
    }
    
    
    func showScore(sentScore: Int)
    {
        score = sentScore
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch: UITouch = (touches.first)!
        
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
        
        //if they press back
        if nodeTouched.name == "backButton"
        {
            let transition = SKTransition.fadeWithDuration(1)
            
            let scene = GameScene(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        //if they press scores
        if nodeTouched.name == "scoresButton"
        {
            let transition = SKTransition.fadeWithDuration(1)
            
            let scene = Scores(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        
    }
    
}
