//
//  Statistics.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 05/05/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//

import SpriteKit

class Statistics: SKScene {
   
    
    
    override func didMoveToView(view: SKView) {

    
    self.backgroundColor = SKColor(red: 0.138, green: 0.138, blue: 0.138, alpha: 1)
   
    var userStats = UserDataDAO.loadUserData()

        
    var backButton = SKSpriteNode(imageNamed: "Back Button")
    backButton.name = "back"
    backButton.size = CGSizeMake(80, 58)
    backButton.position = CGPointMake(self.size.width/2, self.size.height - backButton.size.height)
    self.addChild(backButton)
        
    var highscoreLabel = SKLabelNode(text:"Highscore: \(userStats.highscore)")
    highscoreLabel.position = CGPointMake(self.size.width/2, self.size.height - highscoreLabel.fontSize-100)
    self.addChild(highscoreLabel)
    
    var totalGamesLabel = SKLabelNode(text:"Total Games : \(userStats.totalGamesPlayed)")
    totalGamesLabel.position = CGPointMake(self.size.width/2, highscoreLabel.position.y - totalGamesLabel.fontSize - 100)
    self.addChild(totalGamesLabel)
        
    var totalScoreLabel = SKLabelNode(text:"Total Score: \(userStats.totalScore)")
    totalScoreLabel.position = CGPointMake(self.size.width/2, totalGamesLabel.position.y - totalScoreLabel.fontSize - 100)
    self.addChild(totalScoreLabel)
    
    var averageLabel = SKLabelNode(text:"Average per Game: \(userStats.averageScorePerGame)")
    averageLabel.position = CGPointMake(self.size.width/2, totalScoreLabel.position.y - averageLabel.fontSize - 100)
    self.addChild(averageLabel)
    
        
        
        
    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if (node.name == "back") {
                
                self.presentMenu()
            }
            
        }
    }
    
    private func presentMenu() {
        
        
        
    }
    
}
