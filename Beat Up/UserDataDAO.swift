//
//  HighScoreDAO.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 14/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import Foundation


class UserDataDAO {

    class func pathFromPlist() ->String {
        let rootPath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let plistPath = rootPath.stringByAppendingString("/UserDataList2.plist")
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(plistPath) {
            
            let bundlePath: String? = NSBundle.mainBundle().pathForResource("UserDataList2", ofType: "plist")
            
            if let bundle = bundlePath {
                do {
                    try fileManager.copyItemAtPath(bundle, toPath: plistPath)
                }
                catch let error as NSError {
                    print("Erro ao copiar UserDataList2.plist do mainBundle para plistPath: \(error.description)")
                }
            }
            else {
                print("UserDataList2.plist não está no mainBundle")
            }
        }
        return plistPath
    }
    
    class func salva(dataFromUser:UserData)  {
        
        
        let path = self.pathFromPlist()
        if (path == "ERROR") {
            return
        }
        

        
        let dictionary = ["Highscore":dataFromUser.highscore, "TotalGames":dataFromUser.totalGamesPlayed,"TotalScore":dataFromUser.totalScore,"AverageScore":dataFromUser.averageScorePerGame,"Tutorial":dataFromUser.tutorial, "SoundON":dataFromUser.soundON]
        
        let array:NSMutableArray = NSMutableArray()
        
        array.addObject(dictionary)
        
        array.writeToFile(path, atomically: false)

    }
    
    class func loadUserData() ->UserData {
    
        
        let path = self.pathFromPlist()
        if (path == "ERROR") {
            let newData = UserData()
            return newData
        }
        

        
        let dictsArray = NSMutableArray(contentsOfFile: path)

        let data:UserData = UserData()
    
        if (dictsArray?.count == 1) {
            let dict = dictsArray?.objectAtIndex(0) as! NSDictionary
            
            data.highscore = dict.objectForKey("Highscore") as! NSNumber
            data.totalGamesPlayed = dict.objectForKey("TotalGames") as! NSNumber
            data.totalScore = dict.objectForKey("TotalScore") as! NSNumber
            data.averageScorePerGame = dict.objectForKey("AverageScore") as! NSNumber
            data.tutorial = dict.objectForKey("Tutorial") as! NSNumber
            data.soundON =  dict.objectForKey("SoundON") as! Bool
            
            
        }
    
        return data
    }

    
 }// end of class