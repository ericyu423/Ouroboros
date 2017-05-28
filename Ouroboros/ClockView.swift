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

@IBDesignable
class ClockView: UIView {

    var radius:CGFloat{
        return min(bounds.width/2 , bounds.height/2) - 5
    }

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
        
        updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateHands), userInfo: nil, repeats: true)
        
        
    }
    func stopUpdates(){
        
        updateTimer?.invalidate()
        updateTimer = nil
        
    }
    
    func updateHands() {
        let now = Date()
        let cal = Calendar.current
   
        let comps = cal.dateComponents([.year, .month, .day, .hour, .minute,.second], from: now)
     
       
       // var percentageSeconds = CGFloat((comps.second)!) / 60.0
       // let percentageMinutes = CGFloat((comps.minute)!) / 60.0
       // let percentageHours = CGFloat(comps.hour!) / 24.0
        
        let radianOffset = CGFloat(Double.pi)
        //start at 12 o'clock direction
        
        let radianSeconds = CGFloat(Double(comps.second! * 6) * (Double.pi/180.0)) + radianOffset
        let radianMinutes = CGFloat(Double(comps.minute! * 6) * (Double.pi/180.0)) + radianOffset
        let RadianHours = CGFloat(Double(comps.hour! * 15) * (Double.pi/180.0)) + radianOffset
    
        secondHand?.transform = CATransform3DMakeRotation(radianSeconds, 0, 0, 1)
       
        minuteHand?.transform =
            CATransform3DMakeRotation(radianMinutes, 0, 0, 1)
       
        
        hourHand?.transform =
            CATransform3DMakeRotation(RadianHours, 0, 0, 1)
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
        
        let path = UIBezierPath()
        
        path.lineWidth = 3
        path.addArc(withCenter:centerPoint,
                    radius: 7,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.fill()
//MARK: - can not get this to work properly 
        /*
        
        circle = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter:centerPoint,
                    radius: 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        hourHand?.path = path.cgPath
        circle?.fillColor = UIColor.black.cgColor
        circle?.shadowOpacity = 0.3
        
        //with out poistion addArc will be at wrong place
        circle?.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
        circle?.shadowOffset = CGSize(width: 0, height: 5)
        layer.addSublayer(circle!)
        updateHands()*/
    }
    
    func drawTicks() {
        
        let path = UIBezierPath()
        let outerRadius: CGFloat = radius
        let innerRadius: CGFloat = radius * 0.90
        let numOfTicks = 12
        let dx = bounds.midX
        let dy = bounds.midY
        
        for i in 0..<numOfTicks {
            var angle = CGFloat(i) * CGFloat(2*Double.pi) / CGFloat(numOfTicks)
            angle = angle - CGFloat(0.5*Double.pi)
            let inner = CGPoint(x: innerRadius * cos(angle) + dx, y: innerRadius * sin(angle) + dy)
            let outer = CGPoint(x: outerRadius * cos(angle) + dx, y: outerRadius * sin(angle) + dy)
            path.move(to: inner)
            path.addLine(to: outer)
            path.stroke()
        }
    }
}
