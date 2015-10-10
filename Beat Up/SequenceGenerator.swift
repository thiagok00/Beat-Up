//
//  SequenceGenerator.swift
//  Beat Up
//
//  Created by Thiago De Angelis on 16/04/15.
//  Copyright (c) 2015 Thiago De Angelis. All rights reserved.
//                              ¯\_(ツ)_/¯

import UIKit

class SequenceGenerator: NSObject {
    
    
    func generateRandomSequence () -> [Sequence] {
        
        let randomNumb = Int.random(0...5)

        if (randomNumb == 0) {
            return self.T_sequence()
        }

        else if (randomNumb == 1) {
            return self.x_sequence()
        }
    
        else if (randomNumb == 2) {
            return self.wave_sequence()
        }
        else if (randomNumb == 3) {
            return self.double_sequence()
        }
        
        else if (randomNumb == 4) {
            return self.bla_sequence()
        }
        else if (randomNumb == 5) {
            return self.T_sequence()
        }
    
        return self.T_sequence()
    }
    
    
    /* Private sequences implementation */
    
    private func T_sequence() ->[Sequence] {

        var vet = [Sequence]()
        var seq:Sequence
        
        
        seq = Sequence.create(1, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(4, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(7, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(10, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(9, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(11, duration: 0.0)
        vet.append(seq)
        
        return vet
    
    }
    
    private func x_sequence() ->[Sequence]{
    
        var vet = [Sequence]()
        var seq:Sequence
        
        seq = Sequence.create(0, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(4, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(8, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(11, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(10, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(9, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(6, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(4, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(2, duration: 0.0)
        vet.append(seq)

        return vet
    }
    
    private func wave_sequence() ->[Sequence] {
    
        var vet = [Sequence]()
        var seq:Sequence
        
        seq = Sequence.create(0, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(3, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(6, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(9, duration: 0.5)
        vet.append(seq)
        seq = Sequence.create(1, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(4, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(7, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(10, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(2, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(5, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(8, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(11, duration: 0.0)
        vet.append(seq)
        
        return vet
    
    }
    
    private func double_sequence() ->[Sequence] {
    
    
        var vet = [Sequence]()
        var seq:Sequence

        
        let randomInitial = Int.random(0...1)

        if (randomInitial == 0) {
        for (var inicial = 9; inicial >= 0 ; inicial = inicial - 3) {
        
            seq = Sequence.create(inicial, duration: 0.0)
            vet.append(seq)
            seq = Sequence.create(inicial+2, duration: 0.2)
            vet.append(seq)
        }
        }
        else {
        for (var inicial = 0; inicial < 11 ; inicial = inicial + 3) {
            
            seq = Sequence.create(inicial, duration: 0.0)
            vet.append(seq)
            seq = Sequence.create(inicial+2, duration: 0.2)
            vet.append(seq)
        }
        
        }
        
    return vet
    
    }
    
    private func bla_sequence() ->[Sequence] {
    
        
        var vet = [Sequence]()
        var seq:Sequence
        
        seq = Sequence.create(0, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(11, duration: 0.2)
        vet.append(seq)
        seq = Sequence.create(9, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(2, duration: 0.5)
        vet.append(seq)
        seq = Sequence.create(6, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(7, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(8, duration: 0.5)
        vet.append(seq)
        seq = Sequence.create(3, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(4, duration: 0.0)
        vet.append(seq)
        seq = Sequence.create(5, duration: 0.0)
        vet.append(seq)
        
        return vet
    
    }
    
    
   
} //End of class
