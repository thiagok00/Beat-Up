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
    
        var rootPath:NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        var path:NSString = rootPath.stringByAppendingPathComponent("UserDataList2.plist")
        
        var fileManager = NSFileManager.defaultManager()
        
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path as String)) {
            
            var sourcePath:NSString = NSBundle.mainBundle().pathForResource("UserDataList2", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath as String, toPath: path as String, error: nil)
            return "ERROR"
        }

        return path as String
    }
    
    
    
    class func salva(dataFromUser:UserData)  {
        
        
        var path = self.pathFromPlist()
        if (path == "ERROR") {
            return
        }
        

        
        var dictionary = ["Highscore":dataFromUser.highscore, "TotalGames":dataFromUser.totalGamesPlayed,"TotalScore":dataFromUser.totalScore,"AverageScore":dataFromUser.averageScorePerGame,"Tutorial":dataFromUser.tutorial, "SoundON":dataFromUser.soundON]
        
        var array:NSMutableArray = NSMutableArray()
        
        array.addObject(dictionary)
        
        array.writeToFile(path, atomically: false)

    }
    
    class func loadUserData() ->UserData {
    
        
        var path = self.pathFromPlist()
        if (path == "ERROR") {
            var newData = UserData()
            return newData
        }
        

        
        var dictsArray = NSMutableArray(contentsOfFile: path)

        var data:UserData = UserData()
    
        if (dictsArray?.count == 1) {
            var dict = dictsArray?.objectAtIndex(0) as! NSDictionary
            
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