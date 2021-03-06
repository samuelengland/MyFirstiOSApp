//
//  GameScene.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
    //hack for a button, done in the touches began
    var playButton: SKLabelNode?
    
    //title of game
    var gameTitle: SKLabelNode?
    
    //scores button
    var scoresButton: SKLabelNode?
    
    //insctructions button
    var instructButton: SKLabelNode?
    
    //gives background
    var background: SKSpriteNode?
    
    //sets picture of background
    var backgroundTexture = SKTexture(imageNamed: "homeBackgroundYinYang")
    
    override func didMoveToView(view: SKView)
    {
        
        
        background = SKSpriteNode(texture: backgroundTexture)
        background?.size = self.frame.size
        background?.position = CGPoint(x: CGRectGetMidX(self.frame),y: CGRectGetMidY(self.frame))
        addChild(background!)
        
        
        //sets up the title
        gameTitle = SKLabelNode(text: "Y I N  Y A N G")
        gameTitle?.fontColor = UIColor.whiteColor()
        gameTitle?.fontSize = 40
        gameTitle?.fontName = "Verdana-Bold"
        gameTitle?.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - 200)
        
        
        //sets up playButton
        playButton = SKLabelNode(text: "P L A Y")
        playButton?.fontColor = UIColor.blackColor()
        //playButton.c
        playButton?.fontSize = 40
        playButton?.fontName = "Verdana-Bold"
        playButton?.name = "playButton"
        playButton?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 150)

        //sets up playButton
        scoresButton = SKLabelNode(text: "SCORES")
        scoresButton?.fontColor = UIColor.whiteColor()
        scoresButton?.fontSize = 20
        scoresButton?.fontName = "Verdana-Bold"
        scoresButton?.name = "scoresButton"
        scoresButton?.position = CGPoint(x: self.frame.width - 150, y: self.frame.height - 150)

        
        instructButton = SKLabelNode(text: "INSTRUCTIONS")
        instructButton?.fontColor = UIColor.whiteColor()
        instructButton?.fontSize = 20
        instructButton?.fontName = "Verdana-Bold"
        instructButton?.name = "instructButton"
        instructButton?.position = CGPoint(x: 150, y: self.frame.height - 150)

        
        addChild(gameTitle!)
        addChild(playButton!)
        addChild(scoresButton!)
        addChild(instructButton!)
        
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
        if nodeTouched.name == "scoresButton"
        {
            let transition = SKTransition.doorsOpenHorizontalWithDuration(1)
            
            let scene = Scores(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        //pressing instructions
        if nodeTouched.name == "instructButton"
        {
            let transition = SKTransition.doorsOpenHorizontalWithDuration(1)
            
            let scene = Instructions(size: self.scene!.size)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
        
        
    }
    
    
}
