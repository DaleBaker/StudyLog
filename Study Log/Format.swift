//
//  Format.swift
//  Study Log
//
//  Created by Dale Baker on 7/05/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import UIKit

class Format {
    static func display(time time: Int, label: UILabel!, prefix: String)
    {
        var countSeconds = time
        var countMinutes: Int = 0, countHours: Int = 0
        while ( countSeconds >= 60 ) {
            if countSeconds >= 60 {
                countMinutes += 1
                countSeconds -= 60
            }
        }
        while ( countMinutes >= 60 ) {
            if countMinutes >= 60 {
                countHours += 1
                countMinutes -= 60
            }
        }
        
        var countTotal = [0,0,0]
        countTotal[0] = countSeconds
        countTotal[1] = countMinutes
        countTotal[2] = countHours
        
        
        let totalTime = label
        let prefix2 = prefix
        
        if countTotal[2] == 0 && countTotal[1] == 0 && countTotal[0] == 0 {
            totalTime.text = "\(prefix2)00:00"
        }
        else if countTotal[2] > 0 {  //if hours is more than one
            if countTotal[1] > 9 { //if minutes is double digits
                if countTotal[0] > 9 { //if seconds is double digits
                    totalTime.text = "\(prefix2)\(countTotal[2]):\(countTotal[1]):\(countTotal[0])"
                    //hour is present & minutes and seconds are both double digit
                }
                else {
                    totalTime.text = "\(prefix2)\(countTotal[2]):\(countTotal[1]):0\(countTotal[0])"
                    //hour is present & minutes is double digits but seconds is not
                }
            }
            else { // if minutes is not double digits
                if countTotal[0] > 9 { //if seconds is double digits
                    totalTime.text = "\(prefix2)\(countTotal[2]):0\(countTotal[1]):\(countTotal[0])"
                    //hour is present and minutes is a single digit number and seconds is a double digit number
                }
                else {
                    totalTime.text = "\(prefix2)\(countTotal[2]):0\(countTotal[1]):0\(countTotal[0])"
                    //hour is present, both minutes and seconds are single digit numbers
                }
                
            }
        }
        else { //here the amount of hours is less than one
            if countTotal[1] > 9 { //the amount of minutes is a double digit number
                if countTotal[0] > 9 { //the amount of seconds is a double digit number
                    totalTime.text = "\(prefix2)\(countTotal[1]):\(countTotal[0])"
                    //here there is no hour number and both the minute and second number is a double digit number
                }
                else {
                    totalTime.text = "\(prefix2)\(countTotal[1]):0\(countTotal[0])"
                    //here there is no hour number and the minute number is double digit but the second number is a single digit
                }
            }
            else { //the amount of minutes is a single digit number
                if countTotal[0] > 9 { //the amount of seconds is a double digit number
                    totalTime.text = "\(prefix2)0\(countTotal[1]):\(countTotal[0])"
                    //here the amount of hours is 0, the number of minutes is a single digit number but the number of seconds is a double digit number
                }
                else {
                    totalTime.text = "\(prefix2)0\(countTotal[1]):0\(countTotal[0])"
                    //here the amount of hours is 0, the number of minutes and the number of seconds are both single digit numbers
                }
                
            }
            
            
        }
        
    }

}