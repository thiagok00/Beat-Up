//
//  SKUtil.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 14/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//
//                              ¯\_(ツ)_/¯
import Foundation

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
//extension Array {
//    mutating func removeObject<U: Equatable>(object: U) {
//        var index: Int?
//        for (idx, objectToCompare) in enumerate(self) {
//            if let to = objectToCompare as? U {
//                if object == to {
//                    index = idx
//                }
//            }
//        }
//        
//        if(index != nil) {
//            self.removeAtIndex(index!)
//        }
//    }
//}
// Swift 2 Array Extension
extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

class SKUtil {






}