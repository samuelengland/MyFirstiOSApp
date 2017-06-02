//
//  Runner.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import Foundation
import SpriteKit

class Runner: SKSpriteNode
{
    //used for jumping status
    enum RunnerStates: String
    {
        case running = "running"
        case jumping = "jumping"
    }
    
    //used for collision detection
    enum RunnerColors: String
    {
        case white = "white"
        case black = "black"
    }
    
    //sets the runner to running automatically
    var currentState = RunnerStates.jumping
    
    //sets the runner to black automatically
    var currentColor = RunnerColors.black
    
    //turns the runner black
    var runnerColorIsBlack = true
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageNamed: String)
    {
        //sets the texture to the picture chosen
        let runnerTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: runnerTexture, color: UIColor.clearColor(), size: runnerTexture.size())
        
        //scales the runner down
        self.setScale(0.5)
        
        //sets the body to fit the scaled down runner
        let body: SKPhysicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 2)
        //it can move
        body.dynamic = true
        //gravity
        body.affectedByGravity = true
        //deals with rotation
        body.allowsRotation = false
        
        
        //sets up collision bitmask for runner and ground
        body.categoryBitMask = BodyType.runner.rawValue
        body.collisionBitMask = BodyType.ground.rawValue
        body.contactTestBitMask = BodyType.ground.rawValue
        
        //sets our body variable to be the physics of the runner class object
        self.physicsBody = body

        
        
    }
    

    /////////////////////DEALING WITH JUMPS///////////////////////
    func setJumping()
    {
        currentState = .jumping
    }
    
    func setRunning()
    {
        currentState = .running
    }
    
    func returnState() -> String
    {
        return currentState.rawValue
    }
    
    /////////////////////DEALING WITH COLOR///////////////////////
    
    func setWhite()
    {
        currentColor = .white
        let newTexture = SKTexture(imageNamed: "whiteOuter")
        self.texture = newTexture
    }
    func setBlack()
    {
        currentColor = .black
        let newTexture = SKTexture(imageNamed: "blackOuter")
        self.texture = newTexture
    }
    
    func returnColor() -> String
    {
        return currentColor.rawValue
    }
    
    
    
}
