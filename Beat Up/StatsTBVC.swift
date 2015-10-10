//
//  StatsTBVC.swift
//  Tap Cube
//
//  Created by Thiago De Angelis on 26/05/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import UIKit

class StatsTBVC: UITableViewController {

    let dataFromUser = UserDataDAO.loadUserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.userInteractionEnabled = true
        self.tableView.scrollEnabled = false
        
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.view.frame.size.height/5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 4) {
            self.dismissViewControllerAnimated(true, completion: {})
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath)

        // Configure the cell...
        cell.backgroundColor = UIColor.blackColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
    
        
        cell.textLabel?.font = UIFont(name: "Arista 2.0 Alternate Light", size: self.view.frame.size.height/20)
        
        
        
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.textAlignment = .Center
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = "Highscore: \(dataFromUser.highscore)"
        }
        else if (indexPath.row == 1) {
            cell.textLabel?.text = "Total Games: \(dataFromUser.totalGamesPlayed)"
        }
        else if (indexPath.row == 2) {
            cell.textLabel?.text = "Total Score: \(dataFromUser.totalScore)"
        }
        else if (indexPath.row == 3) {
            cell.textLabel?.text = "Average Score: \(dataFromUser.averageScorePerGame)"
        }
        else if (indexPath.row == 4) {
            cell.textLabel?.text = "Leave"
        }

        return cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
} // End of class
