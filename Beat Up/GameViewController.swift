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
import GoogleMobileAds

class GameViewController: UIViewController, GADInterstitialDelegate, UIAlertViewDelegate {

    var interstitial: GADInterstitial?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        let userData = UserDataDAO.loadUserData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.quitToLevel(_:)), name: "quitToLevelID", object: nil)
        self.view.multipleTouchEnabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.showInterstitial), name: "ShowAd", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.loadInterstitial), name: "LoadAd", object: nil)

        loadInterstitial()
        
        
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
    
    func showInterstitial() {
        if (interstitial!.isReady) {
            interstitial!.presentFromRootViewController(self)
        } else {
            UIAlertView(title: "Interstitial not ready",
                message: "The interstitial didn't finish loading or failed to load",
                delegate: self,
                cancelButtonTitle: "Drat").show()
        }
    }
    
    func loadInterstitial() {
        if interstitial != nil {return}
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3256183457519570/5940964046")
        interstitial!.delegate = self
        
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADInterstitial automatically returns test ads when running on a
        // simulator.
        interstitial!.loadRequest(GADRequest())
    }

    func interstitialDidFailToReceiveAdWithError (
        interstitial: GADInterstitial,
        error: GADRequestError) {
            print("interstitialDidFailToReceiveAdWithError: %@" + error.localizedDescription)
    }
    
    func interstitialDidDismissScreen (interstitial: GADInterstitial) {
        print("interstitialDidDismissScreen")
        self.interstitial = nil
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    
    func quitToLevel(notification: NSNotification) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return (UIInterfaceOrientationMask.AllButUpsideDown)
        } else {
            return (UIInterfaceOrientationMask.All)
        }
    }

    func voltaHome() {
    
      
       self.dismissViewControllerAnimated(false, completion: nil)
    
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        print("Receveid memory warning.")
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
