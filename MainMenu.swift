//
//  GameScene.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 10/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    override func didMoveToView(view: SKView) {

        self.backgroundColor = SKColor.darkGrayColor()
        
        

        var bgImg:SKSpriteNode
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            
            bgImg = SKSpriteNode(imageNamed: "MainMenuIpadImg")
            
        }
        else {
        
            bgImg = SKSpriteNode(imageNamed: "MainMenuImg")
        }
        
        bgImg.position = CGPointMake(self.size.width/2, self.size.height/2)
        bgImg.size = CGSizeMake(self.size.width, self.size.height)
        bgImg.name = "play"
        self.addChild(bgImg)

        var statisticsButton = SKSpriteNode(imageNamed: "Info Button")
        statisticsButton.name = "stats"
        statisticsButton.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/8)
        
        
        
        self.addChild(statisticsButton)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "play" {
                self.presentGame()
            }
            else if (node.name == "stats") {
            
                self.presentStats()
            }
            
        }
    }
    
    private func presentGame() {
    
    
        let transition = SKTransition.fadeWithDuration(1.0)
        
        let scene = GameScene(size:self.frame.size)
        scene.scaleMode = .AspectFill
    
        self.view?.presentScene(scene, transition: transition)
    
    }
    
    private func presentStats() {
        
        
        let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Up, duration: 1.0)
        
        let scene = Statistics(size:self.frame.size)
        scene.scaleMode = .AspectFill
        
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
} //End Of Class
