//
//  GameViewController.swift
//  scenekittest
//
//  Created by Thiago De Angelis on 18/05/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import UIKit
import QuartzCore
import SceneKit
import AVFoundation
import GameKit

class MainMenuVC: UIViewController {
    
    
    
    var clicou:Bool = false
    var backgroundMusicPlayer: AVAudioPlayer!
    
    var leaderboardIdentifier: String? = nil
    var gameCenterEnabled: Bool = false
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        
        let scene = SCNScene()
        
        // 2
        let boxGeometry = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 1.0)
        
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor(red: 120/255, green: 219/255, blue: 48/255, alpha: 1)
        greenMaterial.locksAmbientWithDiffuse = true
        
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor(red: 236/255, green: 28/255, blue: 36/255, alpha: 1)
        redMaterial.locksAmbientWithDiffuse = true
        
        let blueMaterial = SCNMaterial()
        blueMaterial.diffuse.contents = UIColor(red: 85/255, green: 197/255, blue: 246/255, alpha: 1)
        blueMaterial.locksAmbientWithDiffuse = true
        
        let yellowMaterial = SCNMaterial()
        yellowMaterial.diffuse.contents = UIColor.yellowColor()
        yellowMaterial.locksAmbientWithDiffuse = true
        
        
        let orangeMaterial = SCNMaterial()
        orangeMaterial.diffuse.contents = UIColor(red: 252/255, green: 162/255, blue: 38/255, alpha: 1)
        orangeMaterial.locksAmbientWithDiffuse = true
        
        let magentaMaterial = SCNMaterial()
        magentaMaterial.diffuse.contents = UIColor(red: 161/255, green: 36/255, blue: 160, alpha: 1)
        magentaMaterial.locksAmbientWithDiffuse = true
        
        boxGeometry.materials =  [greenMaterial,  redMaterial,    blueMaterial, yellowMaterial, orangeMaterial, magentaMaterial];
        
        let boxNode = SCNNode(geometry: boxGeometry)
        
        boxNode.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0.5, y: 1, z: 0.5, duration: 1)))
        scene.rootNode.addChildNode(boxNode)
        
        
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: -4, z: 40)
        scene.rootNode.addChildNode(cameraNode)
        
        
        
        
        // animate the 3d object
        
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        // allows the user to manipulate the camera
        
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        // Add title text
        
        let label = UILabel()
        label.text = "Tap"
        label.frame = CGRectMake(0, 0, self.view.frame.size.width/0.8, self.view.frame.size.height/5.68)
        label.center.x = self.view.center.x
        label.font = UIFont(name: "Abstract", size: 23)
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            label.font = UIFont(name: "Abstract", size: 46)
        }
        
        
        label.textAlignment = NSTextAlignment.Center
        label.center.y = self.view.frame.size.height/5.8
        label.textColor = UIColor.whiteColor()
        self.view.addSubview(label)
        
        //Add cube text
       
        
        let cubeLabel = UILabel()
        cubeLabel.text = "Cube"
        cubeLabel.frame = CGRectMake(0, 0, self.view.frame.size.width/0.8, self.view.frame.size.height/5.68)
        cubeLabel.center.x = self.view.center.x
        cubeLabel.font = UIFont(name: "Abstract", size: 23)
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            cubeLabel.font = UIFont(name: "Abstract", size: 46)
        }
        
        
        cubeLabel.textAlignment = NSTextAlignment.Center
        cubeLabel.center.y = self.view.frame.size.height/1.5
        cubeLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(cubeLabel)
        
        
        // "to play" label
        
        let toplayLabel = UILabel()
        toplayLabel.text = "to play"
        toplayLabel.frame = CGRectMake(self.view.frame.size.width/8.2, self.view.frame.size.height/1.62, self.view.frame.size.width/0.8, self.view.frame.size.height/5.68)
    
        toplayLabel.font = UIFont(name: "Arista 2.0 Alternate Light", size: 18)
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            toplayLabel.font = UIFont(name: "Arista 2.0 Alternate Light", size: 36)
        }
        
        
        toplayLabel.textAlignment = NSTextAlignment.Center
        //toplayLabel.center.y = self.view.center.y + self.view.frame.size.height/4
        toplayLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(toplayLabel)
        
        
        
        // Add UIButton to play
        
        let playButton = UIButton()
        playButton.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.625, self.view.frame.size.width * 0.625)

        
        playButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        playButton.tintColor = UIColor.whiteColor()
        
        playButton.center.x = self.view.center.x
        playButton.center.y = self.view.frame.size.height/2.5
        playButton.addTarget(self, action: Selector("PlayAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(playButton)
        
        //ADD info Button
        
        let infoButton = UIButton()
        let img = UIImage(named: "Info Button")
        
        infoButton.frame = CGRectMake(0, 0, img!.size.width, img!.size.height)
        
        infoButton.center.x = self.view.center.x
        infoButton.center.y = self.view.frame.size.height*0.9
        infoButton.addTarget(self, action: Selector("StatsAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        infoButton.setImage(img, forState:  UIControlState.Normal)
        self.view.addSubview(infoButton)
        
        //MUTE BUTTON
        
        let muteButton = UIButton()
        let imgMute = UIImage(named: "Info Button")
        
        muteButton.frame = CGRectMake(0, 0, imgMute!.size.width, imgMute!.size.height)
        
        muteButton.center.x = self.view.center.x * 3/2
        muteButton.center.y = self.view.frame.size.height*0.9
        muteButton.addTarget(self, action: Selector("MuteSound:"), forControlEvents: UIControlEvents.TouchUpInside)
        muteButton.setImage(imgMute, forState:  UIControlState.Normal)
        self.view.addSubview(muteButton)
        
        //TUTORIAL BUTTON
        
        let tutorialButton = UIButton()
        let imgTutorial = UIImage(named: "Info Button")
        
        tutorialButton.frame = CGRectMake(0, 0, imgTutorial!.size.width, imgTutorial!.size.height)
        tutorialButton.center.x = self.view.center.x * 1/2
        tutorialButton.center.y = self.view.frame.size.height*0.9
        tutorialButton.addTarget(self, action: Selector("GoTutorial:"), forControlEvents: UIControlEvents.TouchUpInside)
        tutorialButton.setImage(imgTutorial, forState:  UIControlState.Normal)
        self.view.addSubview(tutorialButton)
        
        
        // Autheticate Game Center !!
        self.authenticateLocalPlayer()
        
        
        
    }
    
    func GoTutorial(sender: UIButton!) {
        
        let dataFromUser = UserDataDAO.loadUserData()
        
        if (!clicou) {
            clicou = true
            
            dataFromUser.tutorial = -1
            UserDataDAO.salva(dataFromUser)
            
            performSegueWithIdentifier("playsegue", sender: nil)
            
            
        }
        
    
    }
    
    func MuteSound(sender: UIButton!) {
    
        
        let dataFromUser = UserDataDAO.loadUserData()
        
        if dataFromUser.soundON == true {
            dataFromUser.soundON = false
        }
        else {
            dataFromUser.soundON = true
        }
        
        UserDataDAO.salva(dataFromUser)
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
    
    func PlayAction (sender: UIButton!) {
        if (!clicou) {
            clicou = true
            performSegueWithIdentifier("playsegue", sender: nil)
            
            
        }
    }
    func StatsAction (sender: UIButton!) {
        
            performSegueWithIdentifier("showstats", sender: nil)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        clicou = false
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        print("receive memory warning")
    }
    
    //game center function
    func authenticateLocalPlayer()
    {
        let localPlayer : GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(GameViewController, error) -> Void in
            
            if ((GameViewController) != nil) {
                self.presentViewController(GameViewController!, animated: true, completion: nil)
            }
            else if (localPlayer.authenticated) {
                print("Ta autenticado game center ")
                self.gcEnabled = true
                
                //get the default leaderboard id
//                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderBoardIdentifier: String!, error: NSError!) -> Void in
//                    if error != nil {
//                        print(error)
//                    }
//                    else {
//                        self.gcDefaultLeaderBoard = leaderBoardIdentifier
//                    }
//                })
                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({(leaderBoardIdentifier: String?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    }
                })
                
            }
            else {
                self.gcEnabled = false;
                print("Deu ruim no game center, desabilitando...")
                print(error)
            }
        }
    }
    

}
