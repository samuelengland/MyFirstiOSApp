//
//  TestGameScene.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import SpriteKit



//holds the different types of objects for collision help

enum SprType:UInt32
    
{
    
    case runner = 1
    
    case ground = 2
    
    
    
}



class TestGameScene: SKScene, SKPhysicsContactDelegate
    
{
    
    var ball = SKSpriteNode()
    
    
    
    var background = SKSpriteNode()
    
    
    
    var ground = SKSpriteNode()
    
    
    
    var jumpCount: Int = 0
    
    
    
    var timer: Int = 0
    
    
    
    var percentLabel = SKLabelNode()
    
    
    
    var percentComplete = 0
    
    
    
    override func didMoveToView(view: SKView)
        
    {
        
        /* Setup your scene here */
        
        
        
        //PHYSICS
        
        
        
        //sets gravity
        
        self.physicsWorld.gravity = CGVectorMake(0, -7.0)
        
        
        
        createBackground()
        
        createBaseGround()
        
        
        
        
        
        
        
        //set up runner and give it physics capabilites
        
        var ballTexture = SKTexture(imageNamed: "yinYang")
        
        ballTexture.filteringMode = SKTextureFilteringMode.Nearest
        
        
        
        ball = SKSpriteNode(texture: ballTexture)
        
        ball.setScale(0.5)
        
        ball.position = CGPoint(x: self.frame.size.width * 0.35, y: self.frame.size.height * 0.2)
        
        
        
        //makes physics body exactly the ball
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.height / 2.0)
        
        
        
        //lets it move
        
        ball.physicsBody?.dynamic = true
        
        
        
        //not allowed to rotate
        
        ball.physicsBody?.allowsRotation = false
        
        
        
        //ball.physicsBody?.categoryBitMask
        
        
        
        self.addChild(ball)
        
        
        
        //sets label attributes
        
        percentLabel = SKLabelNode(text: "0%")
        
        //percentLabel.fontColor = UIColor.blackColor()
        
        percentLabel.fontSize = 48
        
        percentLabel.fontName = "AvenirNext-Bold"
        
        percentLabel.position.y = (self.size.height * 0.75)
        
        percentLabel.position.x = (self.size.width/2)
        
        addChild(percentLabel)
        
        
        
        //updates percent
        
        updatePercent()
        
        
        
        
        
        
        
    }
    
    
    
    
    
    //creates texture background
    
    func createBackground()
        
    {
        
        var backgroundTexture = SKTexture(imageNamed: "hexBackground")
        
        
        
        //move background right to left; replace
        
        var shiftBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 200)
        
        var replaceBackground = SKAction.moveByX(backgroundTexture.size().width, y: 0, duration: 0)
        
        var movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))

        for var i: CGFloat = 0; i<5; i++
        {
            
            background = SKSpriteNode(texture:backgroundTexture)
            
            background.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * i), y: CGRectGetMidY(self.frame))
            
            background.size.height = self.frame.height
            
            background.runAction(movingAndReplacingBackground)
            
            
            
            self.addChild(background)
            
        }
        
    }
    
    
    
    func createBaseGround()
        
    {
        
        var groundTexture = SKTexture(imageNamed: "whiteBackground")
        
        
        
        var shiftGround = SKAction.moveByX(-groundTexture.size().width, y: 0, duration: 2)
        
        var replaceGround = SKAction.moveByX(groundTexture.size().width, y: 0, duration: 0)
        
        var moveAndReplaceBackground = SKAction.repeatActionForever(SKAction.sequence([shiftGround,replaceGround]))
        
        
        
        
        
        //creates a sprite with the groundTexture
        
        for var i: CGFloat = 0; i<5; i++
            
        {
            
            ground = SKSpriteNode(texture: groundTexture)
            
            
            
            //set position
            
            ground.position = CGPoint(x: groundTexture.size().width / 2 + (groundTexture.size().width * i), y: groundTexture.size().height)
            
            ground.size.height = self.frame.height * 0.2
            
            ground.runAction(moveAndReplaceBackground)
            
            
            
            //adds physics to the node
            
            ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height))
            
            
            
            //set it so it doesnt move
            
            ground.physicsBody?.dynamic = false
            
            
            
            self.addChild(ground)
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
        
    {
        
        /* Called when a touch begins */
        
        
        
        for touch: AnyObject in touches
            
        {
            
            let location = touch.locationInNode(self)
            
            
            
            //gives balls velocity
            
            ball.physicsBody?.velocity = CGVectorMake(0, 0)
            
            
            
            //gives the ball the jump mechanic, 0 movement on x plane, 35 on y plane
            
            ball.physicsBody?.applyImpulse(CGVectorMake(0, 35))
            
        }
        
    }
    
    
    
    func didBeginContact(contact: SKPhysicsContact)
        
    {
        
        //this gets called automatically when two objects begin contact
        
        
        
        //holds onto whatever contegory bitmasks are connected to eachother
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        
        
        switch(contactMask)
            
        {
            
        case BodyType.runner.rawValue | BodyType.ground.rawValue:
            
            //either the contactMask was the bro type or the ground type
            
            println("contact made")
            
            
            
        default:
            
            return
            
        }
        
    }
    
    
    
    func didEndContact(contact: SKPhysicsContact)
        
    {
        
        //this gets called automatically when two objects end contact
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        
        
        switch(contactMask)
            
        {
            
        case BodyType.runner.rawValue | BodyType.ground.rawValue:
            
            //either the contactMask was the bro type or the ground type
            
            println("contact ended")
            
            
            
        default:
            
            return
            
        }
        
    }
    
    
    
    
    
    //update percent complete
    
    func updatePercent()
        
    {
        
        var timePointsInterval = SKAction.waitForDuration(1)
        
        var incrementPoints = SKAction.runBlock(
            
            {
                
                self.percentComplete++
                
                self.percentLabel.text = "\(self.percentComplete)%"
                
        })
        
        
        
        var updatePoints = SKAction.repeatAction(SKAction.sequence([timePointsInterval, incrementPoints]), count: 100)
        
        
        
        percentLabel.runAction(updatePoints)
        
        
        
        println("\(percentLabel.position.y)")
        
        println("\(percentLabel.position.x)")
        
        
        
        
        
    }
    
    
    
}