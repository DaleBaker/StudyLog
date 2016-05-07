//
//  TimerModel.swift
//  Study Log
//
//  Created by Dale Baker on 7/05/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import UIKit

class TimerModel {
    
    var timerSeconds : Int
    var timerIsRunning : Bool
    
    init() {
        self.timerSeconds = 0
        self.timerIsRunning = false
    }
    
    func timerReset() {
        self.timerIsRunning = false
        self.timerSeconds = 0
    }
    
    
}
