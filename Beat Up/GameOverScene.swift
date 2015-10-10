//
//  GameOverScene.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 20/05/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import SpriteKit
import GameKit

class GameOverScene: SKScene {
   
    var lastScore = 0
    
    override func didMoveToView(view: SKView) {
        
        let dataFromUser = UserDataDAO.loadUserData()
        
        self.backgroundColor = UIColor.blackColor()
        let sWidth = self.frame.size.width
        let sHeight = self.frame.size.height
        
        var titleFontSize:CGFloat = 22
        var scoreFontSize:CGFloat = 10
        var highscoreFontSize:CGFloat = 10
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            titleFontSize = 44
            scoreFontSize = 24
            highscoreFontSize = 20
        }
        
        let gameOverLabel = SKLabelNode(fontNamed: "Abstract")
        gameOverLabel.text = "Game"
        gameOverLabel.fontSize = titleFontSize
        gameOverLabel.position = CGPointMake(sWidth/2, sHeight * 0.89)
        self.addChild(gameOverLabel)
        
        let overLabel = SKLabelNode(fontNamed: "Abstract")
        overLabel.text = "Over"
        overLabel.fontSize = titleFontSize
        overLabel.position = CGPointMake(sWidth/2, gameOverLabel.position.y - gameOverLabel.fontSize*1.5)
        self.addChild(overLabel)
        
        
        // Caixa de points (score atual do jogo)
        
        // Caixa Maior
        let scoreBox = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(sWidth*0.75, sHeight*0.21))
        scoreBox.position = CGPointMake(sWidth/2, sHeight*0.66 )
        
        // Faixa menor dentro da caixa
        let subScoreBox = SKSpriteNode(color: UIColor(red: 192/255, green: 35/255, blue: 35/255, alpha: 1), size: CGSizeMake(scoreBox.size.width, scoreBox.size.height/2))
        subScoreBox.position.y = scoreFontSize
        
        // Label para o numero do score do usuario
        let scoreLabel = SKLabelNode(fontNamed: "Abstract")
        scoreLabel.text = "\(self.lastScore)"
        scoreLabel.fontSize = 16
        scoreLabel.position.y = -10
        
        //description label
        let descricaoScoreLabel = SKLabelNode(fontNamed: "Abstract")
        descricaoScoreLabel.text = "Points"
        descricaoScoreLabel.fontSize = scoreFontSize
        descricaoScoreLabel.position.y = -subScoreBox.size.height + scoreFontSize
        
        self.addChild(scoreBox)
        scoreBox.addChild(subScoreBox)
        subScoreBox.addChild(scoreLabel)
        scoreBox.addChild(descricaoScoreLabel)
        
        /*************************************/
        
        // Caixa de highscore (score atual do jogo)
        
        // Caixa Maior
        let highscoreBox = SKSpriteNode(color: UIColor(red: 106/255, green: 243/255, blue: 85/255, alpha: 1), size: CGSizeMake(sWidth*0.75, sHeight*0.21))
        highscoreBox.position = CGPointMake(sWidth/2, sHeight * 0.41 )
        
        // Faixa menor dentro da caixa
        let subHighscoreBox = SKSpriteNode(color: UIColor(red: 35/255, green: 192/255, blue: 77/255, alpha: 1), size: CGSizeMake(highscoreBox.size.width, highscoreBox.size.height/2))
        subHighscoreBox.position.y = 10
        
        // Label para o numero do score do usuario
        let highscoreLabel = SKLabelNode(fontNamed: "Abstract")
        highscoreLabel.text = "\(dataFromUser.highscore)"
        highscoreLabel.fontSize = 16
        highscoreLabel.position.y = -10
        
        //description label
        let descricaoHighscoreLabel = SKLabelNode(fontNamed: "Abstract")
        descricaoHighscoreLabel.text = "Highscore"
        descricaoHighscoreLabel.fontSize = highscoreFontSize
        descricaoHighscoreLabel.position.y = -subHighscoreBox.size.height + highscoreFontSize
        
        self.addChild(highscoreBox)
        highscoreBox.addChild(subHighscoreBox)
        subHighscoreBox.addChild(highscoreLabel)
        highscoreBox.addChild(descricaoHighscoreLabel)
        
        /*************************************/
        
        
        // REPLAY BUTTON
        
        let replayButton = SKSpriteNode(color: UIColor.orangeColor(), size: CGSizeMake(sWidth*0.625, sHeight*0.08))
        replayButton.position = CGPointMake(sWidth/2, sHeight * 0.198)
        replayButton.name = "Replay Button"
        
        //Replay Label
        let replayLabel = SKLabelNode(fontNamed: "Abstract")
        replayLabel.text = "REPLAY"
        replayLabel.fontSize = 10
        replayLabel.position.y = -5
        replayLabel.name = "Replay Label"
        
        self.addChild(replayButton)
        replayButton.addChild(replayLabel)
        
        //MAIN MENU BUTTON
        
        let homeButton = SKSpriteNode(color: UIColor.orangeColor(), size: CGSizeMake(sWidth*0.625, sHeight*0.08))
        homeButton.position = CGPointMake(sWidth/2, sHeight * 0.093)
        homeButton.name = "Main Menu Button"
        
        
        //Main Menu Label
        let homeLabel = SKLabelNode(fontNamed: "Abstract")
        homeLabel.text = "HOME"
        homeLabel.fontSize = 10
        homeLabel.position.y = -5
        homeLabel.name = "Main Menu Label"
        
        self.addChild(homeButton)
        homeButton.addChild(homeLabel)
        
        self.postGameCenter()
        
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if (node.name == "Replay Button" || node.name == "Replay Label") {
                self.JogaDeNovo()
            }
            else if ( node.name == "Main Menu Button" || node.name == "Main Menu Label") {
                self.VoltaMenu()
            }
           
        }
        
    }
    
    func postGameCenter() {
    
        //posting on gamecenter
        let leaderBoard = "Highscore"
        let gkscore = GKScore(leaderboardIdentifier: leaderBoard)
        gkscore.value = Int64(self.lastScore)
        gkscore.shouldSetDefaultLeaderboard = true
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            GKScore.reportScores([gkscore], withCompletionHandler:  {(error:NSError?) ->Void in
                if error != nil {
                    print(error)
                }
            })
        }
        else {
            print("nao autenticado")
        }

    }
    
    private func VoltaMenu() {
    
        
        NSNotificationCenter.defaultCenter().postNotificationName("quitToLevelID", object: nil)
    
    
    }
    
    private func JogaDeNovo() {
    
    
        let transition = SKTransition.fadeWithDuration(1.5)
        
        let scene = GameScene(size:self.frame.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene, transition: transition)
    
    
    }
    
    
} // CLASS
