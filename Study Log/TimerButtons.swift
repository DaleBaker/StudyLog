//
//  File.swift
//  Study Log
//
//  Created by Dale Baker on 8/05/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//
import Foundation

import UIKit

@IBDesignable
class TimerButtons: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.blackColor()
    @IBInspectable var lineColor: UIColor = UIColor.whiteColor()
    @IBInspectable var isAddButton: Bool = true
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 5) //Creating of the circle
        fillColor.setFill() //The colour of the circle
        path.fill()
        
        let plusHeight: CGFloat = 3.0 //Sets how thick the lines are
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6 //How long the lines are as a percentage of the boundaries
        let plusPath = UIBezierPath() //creates the path
        
        plusPath.lineWidth = plusHeight //asigns the width
        
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5, y:bounds.height/2 + 0.5)) //the start point of the line
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5, y:bounds.height/2 + 0.5)) //the end point of the line
        if isAddButton {
            plusPath.moveToPoint(CGPoint(
                x:bounds.width/2 + 0.5, y:bounds.height/2 + plusWidth/2 + 0.5))
            plusPath.addLineToPoint(CGPoint(
                x:bounds.width/2 + 0.5, y:bounds.height/2 - plusWidth/2 + 0.5))
        }
        lineColor.setStroke() //The colour of the line
        
        plusPath.stroke()
        
        
    }
    
    
}
