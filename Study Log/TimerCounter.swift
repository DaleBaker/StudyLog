//
//  TimerCounter.swift
//  Study Log
//
//  Created by Dale Baker on 17/04/16.
//  Copyright © 2016 NedCorp. All rights reserved.
//

import Foundation
import UIKit

let π: CGFloat = CGFloat(M_PI)


@IBDesignable class CounterView: UIView {
    
    let number = 450
    
    @IBInspectable var counter: Int = 8 {
        didSet {
            if counter <= number {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var counterColor: UIColor = Colors.orange1 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var outlineColor: UIColor = Colors.red1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2) //Set center of rotation
        let radius: CGFloat = max(bounds.width, bounds.height) //Calculate
        let arcWidth: CGFloat = 10
        
        let startAngle: CGFloat = 4.35//5 * π / 3
        let endAngle: CGFloat = 4 * π / 3
        
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle - 0.02, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        
        if (counter == 0 ){
            let angleDifference: CGFloat = 2 * π - startAngle + endAngle
            let arcLengthPerNumber = angleDifference / CGFloat(number)
            let outlineEndAngle = arcLengthPerNumber * CGFloat(counter) + startAngle
            
            let outlinePath = UIBezierPath(arcCenter: center,
                                           radius: bounds.width/2 - 2.5,
                                           startAngle: startAngle,
                                           endAngle: outlineEndAngle,
                                           clockwise: true)
            
            outlinePath.addArcWithCenter(center,
                                         radius: bounds.width/2 - arcWidth + 2.5,
                                         startAngle: outlineEndAngle,
                                         endAngle: startAngle,
                                         clockwise: false)
            
            outlinePath.closePath()
            
            outlineColor.setStroke()
            outlinePath.lineWidth = 1.0
            outlinePath.stroke()
        }
        else if (counter != 0) {
            let angleDifference: CGFloat = 2 * π - startAngle + endAngle
            let arcLengthPerNumber = angleDifference / CGFloat(number)
            let outlineEndAngle = arcLengthPerNumber * CGFloat(counter) + startAngle
            
            let outlinePath = UIBezierPath(arcCenter: center,
                                           radius: bounds.width/2 - 2.5,
                                           startAngle: startAngle,
                                           endAngle: outlineEndAngle,
                                           clockwise: true)
            
            outlinePath.addArcWithCenter(center,
                                         radius: bounds.width/2 - arcWidth + 2.5,
                                         startAngle: outlineEndAngle,
                                         endAngle: startAngle,
                                         clockwise: false)
            
            outlinePath.closePath()
            
            outlineColor.setStroke()
            outlinePath.lineWidth = 3.0
            outlinePath.stroke()
        }
        
        
    }
    
    
    
}
