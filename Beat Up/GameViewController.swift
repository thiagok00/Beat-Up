//
//  GameViewController.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 10/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        var userData = UserDataDAO.loadUserData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "quitToLevel:", name: "quitToLevelID", object: nil)
        
        if (userData.tutorial == 1) {
            let scene = GameScene(size: skView.bounds.size)
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            
            
        }
        else {
    
            let scene = Tutorial(size: skView.bounds.size)
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }


        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    
    func quitToLevel(notification: NSNotification) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    func voltaHome() {
    
      
       self.dismissViewControllerAnimated(false, completion: nil)
    
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        println("Receveid memory warning.")
    }

    

    
//    -(void)authenticateLocalPlayer{
//    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
//    
//    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
//    if (viewController != nil) {
//    [self presentViewController:viewController animated:YES completion:nil];
//    }
//    else{
//    if ([GKLocalPlayer localPlayer].authenticated) {
//    _gameCenterEnabled = YES;
//    
//    // Get the default leaderboard identifier.
//    [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
//    
//    if (error != nil) {
//    NSLog(@"%@", [error localizedDescription]);
//    }
//    else{
//    _leaderboardIdentifier = leaderboardIdentifier;
//    }
//    }];
//    }
//    
//    else{
//    _gameCenterEnabled = NO;
//    }
//    }
//    };
//    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
