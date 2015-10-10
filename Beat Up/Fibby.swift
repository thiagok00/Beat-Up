//
//  Fibby.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 10/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import SpriteKit


   protocol FibbyDelegate {
    
    
        func actived(fibby:Fibby)
        func inactivated(fibby:Fibby)
        func exploded()
        //func doubleScoreTime(
    
    }

enum States {
    case Inactive
    case Sleep
    case Active
    case Explode

}



class Fibby: SKSpriteNode {


    var delegate:FibbyDelegate?
    var state = States.Inactive
    var activeTextures = [SKTexture]()
    var mute:Bool! = false
    
    
    class func create(size:CGSize, position:CGPoint) -> Fibby {
    
    
        let fibby:Fibby = Fibby(imageNamed:"quadrado_inativo")
        fibby.position = position
        fibby.size = size
        fibby.name = "fibby"
    
        for var i = 0; i < 20; i++ {
            
            let texture = SKTexture(imageNamed: "button_\(i)" )
            fibby.activeTextures.append(texture)
        }
        
        //TAPSOUND here
        return fibby
    }

    func active() {
        
        let animation = SKAction.animateWithTextures(activeTextures, timePerFrame: 0.15)
        
        
        
        self.runAction(animation, completion: {
        
            self.explode()
        
        } )
        
        self.state = States.Active
        self.delegate?.actived(self)
        
    }
    
    func clicked() {
    
        let efeito = SKSpriteNode(imageNamed: "button_effect")
        efeito.size = self.size
        efeito.zPosition=20;
        self.addChild(efeito)
        
        if (self.mute == false) {
            self.runAction(SKAction.playSoundFileNamed("Tap.caf", waitForCompletion: false))
        }
        
        let wait = SKAction.waitForDuration(0.1)
        
        self.runAction(wait, completion: {
        
            self.removeAllChildren()
            self.inactive()
        })
    
    }
    
    
    func inactive() {
    
        self.removeAllActions()
        self.texture = SKTexture(imageNamed:"quadrado_inativo")
        self.state = States.Inactive
        self.delegate?.inactivated(self)
        
    }
    
    func sleep() {
    
        self.texture = SKTexture(imageNamed:"button_sleep")
        self.state = States.Sleep
        
        let wait = SKAction.waitForDuration(1.0)
        

        
        self.runAction(wait, completion: {
            
        self.active()
        
        })
        
    }
    
    func explode() {
    
        if (self.mute == false) {
            let sound = SKAction.playSoundFileNamed("Explode.caf", waitForCompletion: false)
            self.runAction(sound)
        }
        
        self.texture = SKTexture(imageNamed: "button_19")
       
        let efeito = SKSpriteNode(imageNamed: "button_effect")
        efeito.size = self.size
        efeito.zPosition=20;
        self.addChild(efeito)
        
        self.delegate?.exploded()
        self.state = States.Explode
    }
    
}
