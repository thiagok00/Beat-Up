//
//  Sequence.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 16/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import UIKit

class Sequence: NSObject {
   
    //Property
    var value = 0
    var duration:Double = 0.0
    
    
    class func create(value:Int, duration:Double)->Sequence {
    
        let seq = Sequence()
        seq.duration = duration
        seq.value = value

        
        return seq
    }

}