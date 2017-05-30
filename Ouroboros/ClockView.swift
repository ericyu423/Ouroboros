//
//  ClockView2.swift
//  Ouroboros
//
//  Created by eric yu on 5/26/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import QuartzCore


let π = CGFloat(Double.pi)
func degree2radian(_ a:CGFloat)->CGFloat {
    let b = CGFloat(π) * a/180
    return b
}

//@IBDesignable
class ClockView: UIView {

    var radius:CGFloat{
        return min(bounds.width/2 , bounds.height/2) - 5
    }

    let radianOffset = CGFloat(Double.pi)

    let startAngle: CGFloat =  0
    let endAngle: CGFloat =  CGFloat(2*Double.pi)
    var centerPoint:CGPoint{
         return CGPoint(x: bounds.midX,y: bounds.midY)
    }
    var updateTimer: Timer?
    var hourHand: CAShapeLayer?
    var minuteHand: CAShapeLayer?
    var secondHand: CAShapeLayer?
    var circle: CAShapeLayer?

    override func draw(_ rect: CGRect) {
        layer.sublayers = nil
        contentMode = .redraw
        startUpdates()
        UIColor.black.set()
        drawFace()
        drawTicks()
        drawSecondHand()
        drawMinuteHand()
        drawHourHand()
        drawMiddlePoint()
        
     
    }
    func startUpdates(){
        
        updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateHands), userInfo: nil, repeats: true)
  
    }
    func stopUpdates(){
        
        updateTimer?.invalidate()
        updateTimer = nil
        
    }
    
    func updateHands() {
        let now = Date()
        let cal = Calendar.current
   
        let comps = cal.dateComponents([.year, .month, .day, .hour, .minute,.second,.nanosecond], from: now)
     
        let sec = (Double(comps.nanosecond!)/1000000000.0) + Double(comps.second!)
        let min = Double(comps.second!)/60.0 + Double(comps.minute!)
        let hr = Double(comps.minute!)/60.0 + Double(comps.hour! % 12)
        
        let radianSeconds = CGFloat(Double(sec * 6) * (Double.pi/180.0)) + radianOffset
        
        let radianMinutes = CGFloat(Double(min * 6) * (Double.pi/180.0)) + radianOffset
        
        let radianHours = CGFloat(Double(hr * 30
            ) * (Double.pi/180.0)) + radianOffset
    
        secondHand?.transform = CATransform3DMakeRotation(radianSeconds, 0, 0, 1)
       
        minuteHand?.transform =
            CATransform3DMakeRotation(radianMinutes, 0, 0, 1)
       
        
        hourHand?.transform =
            CATransform3DMakeRotation(radianHours, 0, 0, 1)
    }

    
    func drawFace() {
        let path = UIBezierPath()
     
            path.lineWidth = 3
        path.addArc(withCenter:centerPoint,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.stroke()
        path.removeAllPoints()
    }
    
    func drawSecondHand(){
        secondHand = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,y:0))
        path.addLine(to: CGPoint(x: 0, y: radius * 0.9))
        secondHand?.path = path.cgPath
        
        //need position to do rotation
        secondHand?.position = CGPoint(x: CGFloat(bounds.midX), y: CGFloat(bounds.midY))
        updateHands()
        //update hand or it will always start from bottom
        
        secondHand?.lineWidth = 3.0
        secondHand?.strokeColor = UIColor.red.cgColor
        secondHand?.shadowOffset = CGSize(width: 0.0, height: 3.0)
        secondHand?.shadowOpacity = 0.6
        secondHand?.lineCap = kCALineCapRound
        layer.addSublayer(secondHand!)
    }
    
    func drawMinuteHand(){
        minuteHand = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,y:0))
        path.addLine(to: CGPoint(x: 0, y: radius * 0.8))
        minuteHand?.path = path.cgPath
        minuteHand?.position = CGPoint(x: CGFloat(bounds.midX), y: CGFloat(bounds.midY))
        updateHands()
        minuteHand?.lineWidth = 5.0
        minuteHand?.strokeColor = UIColor.black.cgColor
        minuteHand?.shadowOffset = CGSize(width: 0, height: 3)
        minuteHand?.shadowOpacity = 0.3
        minuteHand?.lineCap = kCALineCapRound
        layer.addSublayer(minuteHand!)
        
    }
    
    func drawHourHand(){

        hourHand = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0,y:0))
        path.addLine(to: CGPoint(x: 0, y: radius * 0.6))
        hourHand?.path = path.cgPath
        hourHand?.position = CGPoint(x: CGFloat(bounds.midX), y: CGFloat(bounds.midY))
        updateHands()
        
        hourHand?.lineWidth = 7.0
        
        hourHand?.strokeColor = UIColor.black.cgColor
        hourHand?.shadowOffset = CGSize(width: 0, height: 3)
        hourHand?.shadowOpacity = 0.3
        hourHand?.lineCap = kCALineCapRound
        layer.addSublayer(hourHand!)
        
    }
    
    func drawMiddlePoint(){
        circle = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter:centerPoint,
                    radius: 8,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        circle?.path = path.cgPath
        circle?.shadowOpacity = 0.3
        circle?.shadowOffset = CGSize(width: 0, height: 5)
        layer.addSublayer(circle!)
    }
    
   
    
    func drawTicks() {

        let path = UIBezierPath()
        let digitRadius: CGFloat = radius * 0.80
        let outerRadius: CGFloat = radius
        let innerRadius: CGFloat = radius * 0.95
        let numOfTicks = 12
        let dx = bounds.midX
        let dy = bounds.midY
        let textFrame = CGRect(x: 0, y: 0, width: radius/4, height: radius/4)
        
        for i in 0..<numOfTicks {
          
            let angle = CGFloat(i) * CGFloat(2*Double.pi) / CGFloat(numOfTicks)
            
            let textLayer = CATextLayer()
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.foregroundColor = UIColor.black.cgColor
            textLayer.contentsScale = UIScreen.main.scale
            
            textLayer.frame = textFrame
        
            
            let digit = (i+3)%12 != 0 ? (i+3)%12 : 12
            textLayer.string = "\(digit)"
            
            
            textLayer.position = CGPoint(x: digitRadius * cos(angle) + dx, y: digitRadius * sin(angle) + dy)
            
            if radius/2 < 58 {
                textLayer.fontSize = textLayer.fontSize / 2
            }
           
            let inner = CGPoint(x: innerRadius * cos(angle) + dx, y: innerRadius * sin(angle) + dy)
            let outer = CGPoint(x: outerRadius * cos(angle) + dx, y: outerRadius * sin(angle) + dy)
            
            path.lineWidth = 3
            path.move(to: inner)
            path.addLine(to: outer)
            path.stroke()
           
            layer.addSublayer(textLayer)
        }
    }
}
