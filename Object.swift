//
//  Object.swift
//  YinYang
//
//  Created by u0830004 on 4/23/15.
//  Copyright (c) 2015 Samuel England. All rights reserved.
//

import Foundation
import SpriteKit

class Object: SKNode
{
    //used for collision detection
    enum ObjectColor: String
    {
        //I think i only need this
        case white = "white"
        case black = "black"
    }
    
    //sets up the currentObjectType as white, because that will be the first ground displayed
    var currentObjectColor = ObjectColor.white
    
    //gives objects physics attributes
    var hasSomePhysics: Bool = false
    
    //keeps track of latest ground object
    var lastWasHole: Bool = false
    
    //stored as a ___ is ____
    //0 - bottom
    //1 - middle
    //2 - top
    var lastPositions: [Int] = []
    
    //i dont know if i need this
    var lastWasWhite: Bool = true
    
    //array to hold all of the objects arrays
    var _groundColorArray: [String] = []
    
    //getter
    var groundColorArray: [String] {return _groundColorArray}
    
    
    //needed
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(theDict: Dictionary<String, String>)
    {
        super.init()

        //this will be the image name to show for 1 or more textures of sprites as the ground
        var image = "whiteBackground"
        
        //gets the location out of the string
        let location: CGPoint = CGPointFromString(theDict["Location"]!)
        
        self.position = location
        
        //if the dictionary key isnt nil
        if(theDict["PlaceMultiplesOnX"] != nil)
        {
            //then we are going to place more than one sprite
            let multiples = theDict["PlaceMultiplesOnX"]!
            let amount: Int = Int(multiples)!
            
            //go through the given amount of objects
            for i in 0 ..< amount
            {
                //creates a number randomly between 1 and 100
                var generateRandomNum: Int = Int(arc4random_uniform(100) + 1)
                
                //sets the ground to the imamge given as a spritenode
                let objectSprite = SKSpriteNode(imageNamed: image)
                
                self.addChild(objectSprite)
                
                //less than three
                if(i >= 3)
                {
                    //towers exist, more than 10 objects
                    if(i > 10)
                    {
                        //spikes exist, more than 20 objects
                        if(i > 20)
                        {
                            //last wasnt a hole
                            if(lastWasHole == false)
                            {
                                generateRandomNum = Int(arc4random_uniform(100) + 1)
                                
                                if(generateRandomNum > 33)
                                {
                                        //generate another random between
                                        generateRandomNum = Int(arc4random_uniform(1000)+1)
                                        
                                        //half the time its white, half the time its black
                                        if(generateRandomNum <= 250)
                                        {
                                            //create white ground
                                            image = "whiteBackground"
                                            currentObjectColor = ObjectColor.white
                                        }
                                        else if(generateRandomNum <= 500 && generateRandomNum > 250)
                                        {
                                            //create black ground
                                            image = "blackBackground"
                                            currentObjectColor = ObjectColor.black
                                        }
                                        else if(generateRandomNum <= 625 && generateRandomNum > 500)
                                        {
                                            //create black ground
                                            image = "whiteSpikes"
                                            currentObjectColor = ObjectColor.white
                                        }
                                        else if(generateRandomNum <= 750 && generateRandomNum > 625)
                                        {
                                            //create black ground
                                            image = "blackSpikes"
                                            currentObjectColor = ObjectColor.black
                                        }
                                        else if(generateRandomNum <= 875 && generateRandomNum > 750)
                                        {
                                            //create black ground
                                            image = "blackGroundWhiteSpikes"
                                            currentObjectColor = ObjectColor.white
                                        }
                                        else
                                        {
                                            image = "whiteGroundBlackSpikes"
                                            currentObjectColor = ObjectColor.black
                                        }
                                    
                                        //generates random number
                                        generateRandomNum = Int(arc4random_uniform(10) + 1)
                                        
                                        //if it was on bottom
                                        if(lastPositions[0] == 0)
                                        {
                                            //half the time position 0, half the time position 1
                                            if(generateRandomNum > 5)
                                            {
                                                //bottom
                                                objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                                updatePositions(0)
                                            }
                                            else
                                            {
                                                //middle
                                                objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                                updatePositions(1)
                                                
                                            }
                                        }
                                        else //if last ground was mid or top
                                        {
                                            generateRandomNum = Int(arc4random_uniform(100) + 1)
                                            
                                            //33% chance for each height
                                            if(generateRandomNum <= 33) //create bot
                                            {
                                                //bottom
                                                objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                                updatePositions(0)
                                            }
                                            else if(generateRandomNum > 33 && generateRandomNum <= 66) //create mid
                                            {
                                                //middle
                                                objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                                updatePositions(1)
                                                
                                            }
                                            else //create top
                                            {
                                                objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 224)
                                                updatePositions(2)
                                            }
                                        }
                                        lastWasHole = false
                                        
                                    }
                                else
                                {
                                    //dont create object, set bool
                                    lastWasHole = true
                                }
                            }
                            else //last was a hole
                            {
                                //generate another random between
                                generateRandomNum = Int(arc4random_uniform(1000)+1)
                                
                                //half the time its white, half the time its black
                                if(generateRandomNum <= 250)
                                {
                                    //create white ground
                                    image = "whiteBackground"
                                    currentObjectColor = ObjectColor.white
                                }
                                else if(generateRandomNum <= 500 && generateRandomNum > 250)
                                {
                                    //create black ground
                                    image = "blackBackground"
                                    currentObjectColor = ObjectColor.black
                                }
                                else if(generateRandomNum <= 625 && generateRandomNum > 500)
                                {
                                    //create black ground
                                    image = "whiteSpikes"
                                    currentObjectColor = ObjectColor.white
                                }
                                else if(generateRandomNum <= 750 && generateRandomNum > 625)
                                {
                                    //create black ground
                                    image = "blackSpikes"
                                    currentObjectColor = ObjectColor.black
                                }
                                else if(generateRandomNum <= 875 && generateRandomNum > 750)
                                {
                                    //create black ground
                                    image = "blackGroundWhiteSpikes"
                                    currentObjectColor = ObjectColor.white
                                }
                                else
                                {
                                    image = "whiteGroundBlackSpikes"
                                    currentObjectColor = ObjectColor.black
                                }
                                
                                //generates random number
                                generateRandomNum = Int(arc4random_uniform(10) + 1)
                                
                                //if it was on bottom
                                if(lastPositions[0] == 0)
                                {
                                    //half the time position 0, half the time position 1
                                    if(generateRandomNum > 5)
                                    {
                                        //bottom
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                        updatePositions(0)
                                    }
                                    else
                                    {
                                        //middle
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                        updatePositions(1)
                                        
                                    }
                                }
                                else //if last ground was mid or top
                                {
                                    generateRandomNum = Int(arc4random_uniform(100) + 1)
                                    
                                    //33% chance for each height
                                    if(generateRandomNum <= 33) //create bot
                                    {
                                        //bottom
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                        updatePositions(0)
                                    }
                                    else if(generateRandomNum > 33 && generateRandomNum <= 66) //create mid
                                    {
                                        //middle
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                        updatePositions(1)
                                        
                                    }
                                    else //create top
                                    {
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 224)
                                        updatePositions(2)
                                    }
                                }
                                lastWasHole = false
                                
                            }
                        }
                        
                        //less than 20 objects created
                        else
                        {
                            //generates random number
                            generateRandomNum = Int(arc4random_uniform(100) + 1)
                            
                            //last object was created
                            if(lastWasHole == false)
                            {
                                //create ground 2/3 the time, and ground 1/3
                                if(generateRandomNum > 33)
                                {
                                    //generate another random between
                                    generateRandomNum = Int(arc4random_uniform(10)+1)
                                    
                                    //half the time its white, half the time its black
                                    if(generateRandomNum > 5)
                                    {
                                        //create white ground
                                        image = "whiteBackground"
                                        currentObjectColor = ObjectColor.white
                                    }
                                    else
                                    {
                                        //create black ground
                                        image = "blackBackground"
                                        currentObjectColor = ObjectColor.black
                                    }
                                    
                                    //generates random number
                                    generateRandomNum = Int(arc4random_uniform(10) + 1)
                                    
                                    //if it was on bottom
                                    if(lastPositions[0] == 0)
                                    {
                                        //half the time position 0, half the time position 1
                                        if(generateRandomNum > 5)
                                        {
                                            //bottom
                                            objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                            updatePositions(0)
                                        }
                                        else
                                        {
                                            //middle
                                            objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                            updatePositions(1)
                                            
                                        }
                                    }
                                    else //if last ground was mid or top
                                    {
                                        generateRandomNum = Int(arc4random_uniform(100) + 1)
                                        
                                        //33% chance for each height
                                        if(generateRandomNum < 33) //create bot
                                        {
                                            //bottom
                                            objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                            updatePositions(0)
                                        }
                                        else if(generateRandomNum > 33 && generateRandomNum < 66) //create mid
                                        {
                                            //middle
                                            objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                            updatePositions(1)
                                            
                                        }
                                        else //create top
                                        {
                                            objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 224)
                                            updatePositions(2)
                                        }
                                    }
                                    lastWasHole = false
                                    
                                }
                                else ///DONE
                                {
                                    //create hole, set hole to true
                                    lastWasHole = true
                                }
                            }
                            else ///should be working
                            {
                                //generate another random between
                                generateRandomNum = Int(arc4random_uniform(10)+1)
                                
                                //half the time its white, half the time its black
                                if(generateRandomNum > 5)
                                {
                                    //create white ground
                                    image = "whiteBackground"
                                    currentObjectColor = ObjectColor.white
                                }
                                else
                                {
                                    //create black ground
                                    image = "blackBackground"
                                    currentObjectColor = ObjectColor.black
                                }
                                
                                //generates random number
                                generateRandomNum = Int(arc4random_uniform(10) + 1)
                                
                                //if it was on bottom
                                if(lastPositions[0] == 0)
                                {
                                    //half the time position 0, half the time position 1
                                    if(generateRandomNum > 5)
                                    {
                                        //bottom
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                        updatePositions(0)
                                    }
                                    else
                                    {
                                        //middle
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                        updatePositions(1)
                                        
                                    }
                                }
                                else //if last ground was mid or top
                                {
                                    generateRandomNum = Int(arc4random_uniform(100) + 1)
                                    
                                    //33% chance for each height
                                    if(generateRandomNum < 33) //create bot
                                    {
                                        //bottom
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                        updatePositions(0)
                                    }
                                    else if(generateRandomNum > 33 && generateRandomNum < 66) //create mid
                                    {
                                        //middle
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                        updatePositions(1)
                                        
                                    }
                                    else //create top
                                    {
                                        objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 224)
                                        updatePositions(2)
                                    }
                                }
                            }
                        }
                    }
                        
                    // less than 10 objects created so far SHOULD BE WORKINGGGGGGGGGGGGGGG
                    else
                    {
                        
                        //generates random number
                        generateRandomNum = Int(arc4random_uniform(100) + 1)
                        
                        //last object was created
                        if(lastWasHole == false)
                        {
                            //create ground 2/3 the time, and ground 1/3
                            if(generateRandomNum > 33)
                            {
                                //generate another random between
                                generateRandomNum = Int(arc4random_uniform(10)+1)
                                
                                //half the time its white, half the time its black
                                if(generateRandomNum > 5)
                                {
                                    //create white ground
                                    image = "whiteBackground"
                                    currentObjectColor = ObjectColor.white
                                }
                                else
                                {
                                    //create black ground
                                    image = "blackBackground"
                                    currentObjectColor = ObjectColor.black
                                }
                                
                                //generates random number
                                generateRandomNum = Int(arc4random_uniform(10) + 1)
                                
                                //half the time position 0, half the time position 1
                                if(generateRandomNum > 5)
                                {
                                    //bottom
                                    objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                    updatePositions(0)
                                }
                                else
                                {
                                    //middle
                                    objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                    updatePositions(1)
                                    
                                }
                                lastWasHole = false
                                
                            }
                            else
                            {
                                //make a hole by not adding it
                                lastWasHole = true
                            }
                        }
                        //last was a hole
                        else
                        {
                                //generate another random between
                                generateRandomNum = Int(arc4random_uniform(10)+1)
                                
                                //half the time its white, half the time its black
                                if(generateRandomNum > 5)
                                {
                                    //create white ground
                                    image = "whiteBackground"
                                    currentObjectColor = ObjectColor.white
                                }
                                else
                                {
                                    //create black ground
                                    image = "blackBackground"
                                    currentObjectColor = ObjectColor.black
                                }
                                
                                //generates random number
                                generateRandomNum = Int(arc4random_uniform(10) + 1)
                                
                                //half the time position 0, half the time position 1
                                if(generateRandomNum > 5)
                                {
                                    //bottom
                                    objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                                    updatePositions(0)
                                }
                                else
                                {
                                    //middle
                                    objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 112)
                                    updatePositions(1)
                                    
                                }
                            lastWasHole = false
                                
                        }
                    }
                }
                    
                //there are not more than 3 objects yet SHOUTL BEEEE EWORRRKRINGNGNGNG
                else
                {
                    //create object whiteGround and put them into the array
                    
                    //all will be whiteGround postion 0
                    objectSprite.position = CGPoint(x: objectSprite.size.width * CGFloat(i), y: 0)
                    currentObjectColor = ObjectColor.white
                    lastPositions.append(0)
                    
                }
                
                //gives physics
                hasSomePhysics = true
                
                //append color to our array
                _groundColorArray.append(currentObjectColor.rawValue)
                
                //makes the body a rectange to fit the ground
                objectSprite.physicsBody = SKPhysicsBody(rectangleOfSize: objectSprite.size)
                objectSprite.physicsBody?.dynamic = false
                objectSprite.physicsBody?.categoryBitMask = BodyType.ground.rawValue
                
            
            }
            
        //shouldnt happen, but safety

        }
        else
        {
            //we only need to place one
            let objectSprite: SKSpriteNode = SKSpriteNode(imageNamed: image)
            self.addChild(objectSprite)
            
            if(theDict["GroundType"] == "square")
            {
                hasSomePhysics = true
                
                //makes the body a rectange
                objectSprite.physicsBody = SKPhysicsBody(rectangleOfSize: objectSprite.size)
                objectSprite.physicsBody?.dynamic = false
                
            }
        }
    }
    
    //getter for object types
    func getObjectColor() -> String
    {
        return currentObjectColor.rawValue
    }
    
    func updatePositions(pos: Int)
    {

        lastPositions[1] = lastPositions[0]
        lastPositions[0] = pos
    }
    
    
}
