//
//  GameScene.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 10/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import SpriteKit
import AVFoundation


class GameScene: SKScene, FibbyDelegate {


    
    /* proprerty */
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    var allFibbies:[Fibby] = [Fibby]()
    var activedFibbies:[Fibby] = [Fibby]()
    var inactivatedFibbies:[Fibby] = [Fibby]()
    var scoreLabel = SKLabelNode()
    var scoreMultiplier = 1
    var isGameOver = false
    var delay = 1.0
    var score = 0
    var delayChanged = false
    var lastTouchDate = NSDate()
    var lastFibby = Fibby()
    var dataFromUser = UserDataDAO.loadUserData()
    var level = 0

    var seqGenerator = SequenceGenerator()
    
    var backgroundMusicPlayer: AVAudioPlayer!

    
    /************/
    

    
    override func didMoveToView(view: SKView) {

        screenWidth = self.frame.size.width
        screenHeight = self.frame.size.height
        self.backgroundColor = UIColor.blackColor()
            
        //Set up Score Label
        
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.fontName = "Abstract"
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPointMake(screenWidth/2, screenHeight - scoreLabel.fontSize*2);
        scoreLabel.zPosition = 10;
        
        self.createFibbies()
        
        self.addChild(scoreLabel)
        
        if (dataFromUser.soundON == true) {
            self.playBackgroundMusic("Batida2.caf")
        }
        
        self.runAction( SKAction.waitForDuration(2), completion: {
            self.activeGenerator()
        })
        
        

        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Called when a touch begins */
    
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if (node.name == "fibby") {
            
                let fibby = node as! Fibby
            
                if (fibby.state == States.Active) {
                    
                    fibby.clicked()
                    score += 1

                    lastFibby = fibby
                    
                    let elapsedTime = NSDate().timeIntervalSinceDate(lastTouchDate)
                    lastTouchDate = NSDate()
                    if (elapsedTime < 0.1) {
                        score += 1
                    }
                    self.updateDelay()
                    self.updateScoreLabel()
                }
                else if (fibby.state == States.Inactive || fibby.state == States.Sleep) {
                
                    fibby.explode()
            
                }
                
                
                
            }
            
        }
    
    }
    

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
    }
    
    
    private func createFibbies() {
    
        var fibbySize = CGSizeMake(screenWidth/4,screenWidth/4)

       //var index = 0
        

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        
        
                fibbySize = CGSizeMake(screenWidth/6, screenWidth/6)
        
        }
        
        var x = screenWidth/16 + fibbySize.width/2
        var y = screenHeight/16 + fibbySize.width/2
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            x = (screenWidth - (screenWidth/8 + fibbySize.width/2)*2)/2
            y = screenWidth/8 + fibbySize.width/2
        
        }
        
        
        for var i = 0 ; i < 4 ; i += 1 {
            for var j = 0 ; j < 3 ; j += 1 {
            
            
                let fibby = Fibby.create(fibbySize, position:CGPointMake(x,y))
                fibby.delegate = self
                
                if(dataFromUser.soundON == false) {
                    fibby.mute = true
                }
                
                self.addChild(fibby)
                allFibbies.append(fibby)
                
                x = x + fibbySize.width + screenWidth/16
            }
            x = screenWidth/16 + fibbySize.width/2
            y = y + fibbySize.width + screenWidth/16
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                x = (screenWidth - (screenWidth/8 + fibbySize.width/2)*2)/2
            }
            
        
        }
        inactivatedFibbies = allFibbies
    }
    
    private func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    private func activeGenerator() {
    
        self.removeAllActions()
    
        
        let wait = SKAction.waitForDuration(delay)
        let waitmin = SKAction.waitForDuration(delay/2)
        let spawn = SKAction.runBlock({ self.randomActiveFibby()})
        //var delayBetweenAction = SKAction.waitForDuration(delay, withRange: 0.1)
        
        let active = SKAction.sequence([spawn,waitmin,spawn,wait])

        self.runAction(SKAction.repeatActionForever(active))

    }
    
    private func randomActiveFibby() {
        
        if (inactivatedFibbies.count > 0) {
            let max = inactivatedFibbies.count-1
            let random = Int.random(0...max)
            let fibby = inactivatedFibbies[random]
            
            
            let randomPercentage = Int.random(0...100)
            
            if (randomPercentage < 15) {
            
                fibby.sleep()
            }
            else if (randomPercentage < 20 && self.score >= 50){
                self.activeSequence()
            }
            else {
            fibby.active()
            }
            
        }
    }
    
    private func gameOver() {
 
        let rand = Int.random(0...5)
        if rand < 7 {
            NSNotificationCenter.defaultCenter().postNotificationName("ShowAd", object: nil)
        }
        let oldHighscore = dataFromUser.highscore as Int
        
        if (score > oldHighscore) {
            let newHighscore = NSNumber(integer: score)
            dataFromUser.highscore = newHighscore
        }
        
        var newTotalGamesPlayed = dataFromUser.totalGamesPlayed as Int
        newTotalGamesPlayed += 1
        dataFromUser.totalGamesPlayed = newTotalGamesPlayed
        
        var newTotalScore = dataFromUser.totalScore as Int
        newTotalScore = newTotalScore + score
        dataFromUser.totalScore = newTotalScore
        
        let newAverageScore = newTotalScore / newTotalGamesPlayed
        dataFromUser.averageScorePerGame = NSNumber(integer: newAverageScore)
        
        UserDataDAO.salva(dataFromUser)
        
        if (dataFromUser.soundON == true) {
            self.backgroundMusicPlayer.stop()
        }
        
        let transition = SKTransition.fadeWithDuration(1.5)
        
        let scene = GameOverScene(size:self.frame.size)
        scene.scaleMode = .AspectFill
        scene.lastScore = self.score
        self.view?.presentScene(scene, transition: transition)
    
    }
    
    
    
    private func updateScoreLabel() {
    
        scoreLabel.text = "\(self.score)"
    
    }
    
    private func updateDelay() {
    
        if (score >= 500 && level < 10) {
            delay = 0.35
            delayChanged = true
            level = 10
        }
        else if (score >= 300 && level < 9) {
            delay = 0.4
            delayChanged = true
            level = 9
        }
        else if (score >= 250 && level < 8) {
            delay = 0.45
            delayChanged = true
            level = 8
        }
        else if (score >= 200 && level < 7) {
            delay = 0.5
            level = 3
            delayChanged = true
            level = 7
        }
        else if (score >= 150 && level < 6) {
            delay = 0.55
            delayChanged = true
            level = 6
        }
        else if (score >= 120 && level < 5) {
            delay = 0.6
            delayChanged = true
            level = 5
        }
        else if (score >= 100 && level < 4) {
            delay = 0.7
            level = 2
            delayChanged = true
            level = 4
        }
        else if (score >= 70 && level < 3) {
            delay = 0.78
            delayChanged = true
            level = 3
        }
        else if (score >= 50 && level < 2) {
            delay = 0.85
            level = 2
            delayChanged = true
        }
        else if (score >= 30 && level < 1) {
            delay = 0.9
            delayChanged = true
            level = 1
        }
    
        if delayChanged {
            self.activeGenerator()
            delayChanged = false
        }
    
    }
    
    /* sequences */
    
    private func activeFibby(fibby:Fibby,withDuration:Double) ->Bool {
    
        
        self.runAction(SKAction.waitForDuration(withDuration), completion: {
        
            fibby.active()
        
        })

        return true
    }

   private func runRandomSequence(level:Int){
        
        
        var sequences = seqGenerator.generateRandomSequence()
        var duration:Double = 0.0
        
        for (var i = 0; i < sequences.count; i += 1) {
        
            if (allFibbies.count <= i) {
                return
            }
            
            let fibby = self.allFibbies[sequences[i].value]
            if (fibby.state == States.Inactive) {
                activeFibby(fibby, withDuration: duration)
            }
            duration = duration + sequences[i].duration
                
        
        }
    
    
    self.runAction(SKAction.waitForDuration(2), completion: {self.activeGenerator()})
    
    
    }
    
    private func activeSequence() {
        
        self.removeAllActions()
        let wait = SKAction.waitForDuration(1)
        self.runAction(wait, completion: {self.runRandomSequence(0)})
    }
    
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOfURL: url!)
        if self.backgroundMusicPlayer == nil {
            print("Could not create audio player")
            return
        }
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }
    
    
/*********************************

    Fibby Protocol Methods
    
*********************************/
    
    func actived(fibby:Fibby) {
        
        activedFibbies.append(fibby)
        inactivatedFibbies.removeObject(fibby)
        
    }
    func inactivated(fibby:Fibby) {
      
        inactivatedFibbies.append(fibby)
        activedFibbies.removeObject(fibby)
        
        
    }
    
    
    func exploded() {
    
        
        
        self.gameOver()
    }
    
    
} //End of Class
