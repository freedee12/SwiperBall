//
//  GameScene.swift
//  SwipeBall
//
//  Created by Teddy Dubno on 1/21/15.
//  Copyright (c) 2015 Teddy Dubno. All rights reserved.
//

import SpriteKit
import Darwin
let balls = SKShapeNode()
let sprite1 = SKShapeNode(circleOfRadius: 8)
let sprite2 = SKShapeNode(circleOfRadius: 8)
let sprite3 = SKShapeNode(circleOfRadius: 8)
let sprite4 = SKShapeNode(circleOfRadius: 8)
let psprite = SKShapeNode(circleOfRadius: 12)
var Score = 0
var winBall = 0
let ballarray:[SKShapeNode] = [sprite1,sprite2,sprite3,sprite4]
let scoreBoard = SKLabelNode(fontNamed: "Superclarendon-BlackItalic")
let colorPicker:[UIColor] = [UIColor.redColor(),UIColor.blueColor(),UIColor.brownColor(),UIColor.greenColor(),UIColor.purpleColor()]
var ranint = [0,1,2,3]
var swiped = 0
var bGColor = UIColor.grayColor()
var upcolor = false
let swipeDirections:[CGVector] = [CGVector(dx: 0, dy: 400),CGVector(dx: 0, dy: -400),CGVector(dx: 400, dy: 0),CGVector(dx: -400, dy: 0)]
var direction = CGVector(dx: 0, dy: 0)
var highScore = 0

extension Array {
    func randomItem() -> T {
        let i = Int(arc4random_uniform(UInt32(self.count)))
        return self[i]
    }
}

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        initballs()
        //Circle parent class
        initcirc()
        //adds the balls to view
        initplayer()
        //adds the player
        initscore()
        //add score
        reset()
    
    }
    func RotatePointAboutOrigin(point:CGPoint, angle:Float)-> CGPoint
    {
        let s:Float = sin(angle)
        let c:Float = cos(angle)
        let xcordr = CGFloat(c * Float(point.x) - s * Float(point.y))
        let ycordr = CGFloat(s * Float(point.x) + c * Float(point.y))
        return CGPoint(x:xcordr, y: ycordr)
    }
    func RotateVectorAboutOrigin(point:CGVector, angle:Float)-> CGVector
    {
        let s:Float = sin(angle)
        let c:Float = cos(angle)
        let xcordr = CGFloat(c * Float(point.dx) - s * Float(point.dy))
        let ycordr = CGFloat(s * Float(point.dx) + c * Float(point.dy))
        return CGVector(dx:xcordr, dy: ycordr)
    }


    func initballs(){
        balls.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(balls)
    }
    func initcirc(){
        for var index = 0; index<4; ++index{
            ballarray[index].strokeTexture = SKTexture(imageNamed:"Image")
            balls.addChild(ballarray[index])
            let a = Float(index)
            let rt = Float(3.141 * a / 2.0 )
            let lpoint = RotatePointAboutOrigin(CGPoint(x:200,y:0),angle: rt)
            ballarray[index].position = lpoint
            ballarray[index].physicsBody = SKPhysicsBody(circleOfRadius: 8, center: lpoint)
            ballarray[index].physicsBody?.affectedByGravity = false
            ballarray[index].physicsBody?.linearDamping = 0
        }
        
    
    }
    func initplayer(){
        psprite.position = CGPoint(x:0,y:0)
        psprite.strokeTexture = SKTexture(imageNamed:"Image")
        psprite.physicsBody = SKPhysicsBody(circleOfRadius: 12,center:CGPoint(x: 0,y: 0))
        psprite.physicsBody?.affectedByGravity = false
        balls.addChild(psprite)
    }
    func initscore(){
        scoreBoard.text = "\(Score)"
        scoreBoard.fontSize = 35
        scoreBoard.fontColor = UIColor.blackColor()
        scoreBoard.position = CGPoint(x: self.size.width-self.size.width/3, y: self.size.height-self.size.height/18)
        //self.addChild(scoreBoard)
        
    
    }
    func chanagecolor( ng:UIColor){
        upcolor = true
        bGColor = ng
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
                }
    }
    func uSwipe(){
        if swiped == 0 {
        psprite.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
        swiped = 1
        direction = CGVector(dx: 0, dy: 400)
        }
    
    }
    func dSwipe(){
       if swiped == 0 {
        psprite.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        swiped = 1
        direction = CGVector(dx: 0, dy: -400)
        }
    }
    func lSwipe(){
       if swiped == 0 {
        psprite.physicsBody?.velocity = CGVector(dx: -400, dy: 0)
        swiped = 1
        direction = CGVector(dx: 400, dy: 0)
        }
    }
    func rSwipe(){
      if swiped == 0 {
        psprite.physicsBody?.velocity = CGVector(dx: 400, dy: 0)
        swiped = 1
        direction = CGVector(dx: -400, dy: 0)
        }
    }
    func reset(){
        for var index = 0; index<4; ++index{//reset balls
            let a = Float(index)
            let rt = Float(3.141 * a / 2.0 )
            let lpoint = RotatePointAboutOrigin(CGPoint(x:200,y:0),angle: rt)
            let nVel = RotateVectorAboutOrigin(CGVector(dx:-(150+3*Score),dy:0),angle: rt)
            ballarray[index].position = lpoint
            //balls.childNodeWithName("sprite\(index)")?.position = lpoint
           ballarray[index].physicsBody?.velocity = nVel
        }
        //reset player
        psprite.position =  CGPoint(x: 0, y: 0)
        psprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        colorSelect()
        updateScore()
        swiped = 0
        direction = CGVector(dx: 0, dy: 0)
    }
    func pause(){
        for var index = 0; index<4; ++index{
        ballarray[index].physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
        psprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if swiped == 1{
            swiped = 2
        }
        else{
        swiped = 1
        }
    }
    func unpause(){
        for var index = 0; index<4; ++index{
            let rt = Float(3.141 *  Float(index)/2.0 )
            let nVel = RotateVectorAboutOrigin(CGVector(dx:-(150+3*Score),dy:0),angle: rt)
            ballarray[index].physicsBody?.velocity = nVel
    }
        psprite.physicsBody?.velocity = direction
        swiped = swiped - 1
    }
    func colorSelect(){
        psprite.fillColor = colorPicker.randomItem()
        for var i = 0; i<4; ++i{
        ballarray[i].fillColor = colorPicker.randomItem()
            while ballarray[i].fillColor == psprite.fillColor{
                ballarray[i].fillColor = colorPicker.randomItem()
            }
        }
        let ri = ranint.randomItem()
        ballarray[ri].fillColor = psprite.fillColor
        winBall = ri
        

    }
    func updateScore(){
     scoreBoard.text = "\(Score)"
        /*if Score > highScore {
        highScore = Score
                }*/
        
        var defaults=NSUserDefaults()
        var highscore=defaults.integerForKey("highscore")
        
        if(Score>highscore)
        {
            defaults.setInteger(Score, forKey: "highscore")
        }
        var highscoreshow=defaults.integerForKey("highscore")
        print("\(highscoreshow)")
    highScore = highscoreshow
    }
    /*func gethighscore() -> Int{
    
   
    return highScore
    }*/
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if upcolor {
        self.backgroundColor = bGColor
            upcolor = false
        }
        for var i=0; i<4; ++i
        {
            if psprite.containsPoint(ballarray[i].position)
                {
                    if i == winBall && swiped == 1{
                    ++Score
                    }
                    else {
                    Score = 0
                    }
                reset()
                }
        }
        
        if psprite.position.x>self.size.width/4.7 || psprite.position.x<self.size.width/4.7 * -1 || psprite.position.y<self.size.height/2 * -1 || psprite.position.y>self.size.height/2
            {
            reset()
            }

    }
}
