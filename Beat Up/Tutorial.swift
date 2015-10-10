//
//  Tutorial.swift
//  Tap Cube
//
//  Created by Thiago De Angelis on 03/06/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//

import SpriteKit

class Tutorial: SKScene {
    
    
    var img:SKSpriteNode!
    var index = 1
    var clicked = false
    var menu:Bool! = false
    
    override func didMoveToView(view: SKView) {
        
        
        img = SKSpriteNode(imageNamed: "tutorial_1")
        img.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        img.size = self.frame.size
        
        self.addChild(img)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {        
        if (self.index < 5 ) {
            
            if (!self.clicked) {
                
                let fade = SKAction.fadeOutWithDuration(0.5)
                self.clicked = true
                img.runAction(fade, completion: {
                    
                    self.index++
                    self.clicked = false
                    self.img.runAction(SKAction.fadeInWithDuration(0))
                    self.mudaImg()
                    
                })
                
            }
            
        }
        else {
            self.quitTutorial()
        }
        
    }
    
    private func mudaImg(){
        self.img.texture = SKTexture(imageNamed: "tutorial_\(self.index)")
    }
    
    private func quitTutorial() {
        
        let dataFromUser = UserDataDAO.loadUserData()
        
        if (dataFromUser.tutorial == -1) {
            
            dataFromUser.tutorial = 1
            UserDataDAO.salva(dataFromUser)
            
            NSNotificationCenter.defaultCenter().postNotificationName("quitToLevelID", object: nil)
            
            
        }
        else {
            dataFromUser.tutorial = 1
            
            UserDataDAO.salva(dataFromUser)
            
            let transition = SKTransition.fadeWithDuration(1.0)
            let scene = GameScene(size:self.frame.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition: transition)
        }
        
        
    }
    
    
} // END OF CLASS
