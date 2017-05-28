
    
       /* var radius: CGFloat {
            return min(bounds.width, bounds.height)
        }
    
        override func draw(_ rect: CGRect) {
        }*/
   
    
       /* override init(frame: CGRect){
            super.init(frame: frame)
            setUpClock()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        */
        
import UIKit
import QuartzCore

class ClockView1:UIView {
    
    var updateTimer: Timer?
    var hourHand: CAShapeLayer?
    var minuteHand: CAShapeLayer?
    var secondHand: CAShapeLayer?
    
    
    override func draw(_ rect: CGRect) {
        setUpClock()
    }
    /*
    override init(frame: CGRect){
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    
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
        
        
        
        let minutesIntoDay: Int = comps.hour! * 60 + comps.minute!
        let percentageMinutesIntoDay: Float = Float(minutesIntoDay) / (12.0 * 60.0)
        let percentageMinutesIntoHour = Float((comps.minute)!) / 60.0
        
        
        let percentageSecondsIntoMinute = Float((comps.second)!) / 60.0//error here
        
        
        secondHand?.transform = CATransform3DMakeRotation(CGFloat((.pi * 2) * percentageSecondsIntoMinute), 0, 0, 1)
        minuteHand?.transform = CATransform3DMakeRotation(CGFloat((.pi * 2) * percentageMinutesIntoHour), 0, 0, 1)
        hourHand?.transform = CATransform3DMakeRotation(CGFloat((.pi * 2) * percentageMinutesIntoDay), 0, 0, 1)
    }
    
    
    func setUpClock() {
        let face = CAShapeLayer()
        // face
        face.frame = frame
        face.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
        face.fillColor = UIColor.clear.cgColor
        face.strokeColor = UIColor.black.cgColor
        face.lineWidth = 4.0
        var path: CGMutablePath = CGMutablePath()
        
        path.addEllipse(in: frame, transform: .identity)
        face.path = path
        layer.addSublayer(face)
        /*
        // numbers
        for i in 1...12 {
            let number = CATextLayer()
            number.string = "\(i)"
            number.alignmentMode = "center"
            number.fontSize = 18.0
            number.foregroundColor = UIColor.black.cgColor
            number.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(25.0), height: CGFloat(frame.size.height / 2.0 - 10.0))
            number.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
            
        }*/
        
        
        //ticks
        for i in 1...60 {
            
            if i%15 == 0 {
                
                
            let tick = CAShapeLayer()
            path = CGMutablePath()
            path.addEllipse(in: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(5.0)), transform: .identity)
            tick.strokeColor = UIColor.black.cgColor
            tick.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(frame.size.height / 2.0))
            tick.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
            tick.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(1.0))
            tick.transform = CATransform3DMakeRotation(CGFloat((.pi * 2) / 60.0 * CGFloat(i)), 0, 0, 1)
            tick.path = path
            layer.addSublayer(tick)
            }
        }
      //  CGPathMoveToPoint(path, nil, )
       // CGPathAddLineToPoint(path, nil, xn, yn)

        
        //CGPathAddLineToPoint(path, nil, xn, yn)
       
        // second hand
        secondHand = CAShapeLayer()
        path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(1.0), y: CGFloat(0.0)), transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(1.0), y: CGFloat(frame.size.height / 2.0 + 8.0)), transform: .identity)
        secondHand?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(3.0), height: CGFloat(frame.size.height / 2.0 + 8.0))
        secondHand?.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(0.8))
        secondHand?.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
        secondHand?.lineWidth = 3.0
        secondHand?.strokeColor = UIColor.red.cgColor
        secondHand?.path = path
        secondHand?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(3.0))
        secondHand?.shadowOpacity = 0.6
        secondHand?.lineCap = kCALineCapRound
        layer.addSublayer(secondHand!)
        
        
        // minute hand
        minuteHand = CAShapeLayer()
        path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(2.0), y: CGFloat(0.0)), transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(2.0), y: CGFloat(frame.size.height / 2.0)), transform: .identity)
        minuteHand?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(5.0), height: CGFloat(frame.size.height / 2.0))
        minuteHand?.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(0.8))
        minuteHand?.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
        minuteHand?.lineWidth = 5.0
        minuteHand?.strokeColor = UIColor.black.cgColor
        minuteHand?.path = path
        minuteHand?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(3.0))
        minuteHand?.shadowOpacity = 0.3
        minuteHand?.lineCap = kCALineCapRound
        layer.addSublayer(minuteHand!)
        
        // hour hand
        hourHand = CAShapeLayer()
        path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(3), y: CGFloat(0)), transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(3.0), y: CGFloat(frame.size.height / 3.0)), transform: .identity)
        hourHand?.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(7.0), height: CGFloat(frame.size.height / 3.0))
        hourHand?.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(0.8))
        hourHand?.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
        hourHand?.lineWidth = 7.0
        hourHand?.strokeColor = UIColor.black.cgColor
        hourHand?.path = path
        hourHand?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(3.0))
        hourHand?.shadowOpacity = 0.3
        hourHand?.lineCap = kCALineCapRound
        layer.addSublayer(hourHand!)
        
        
        // midpoint
        let circle = CAShapeLayer()
        path = CGMutablePath()
        path.addEllipse(in: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(11.0), height: CGFloat(11.0)), transform: .identity)
        circle.fillColor = UIColor.yellow.cgColor
        circle.frame = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(11.0), height: CGFloat(11.0))
        circle.path = path
        circle.shadowOpacity = 0.3
        circle.position = CGPoint(x: CGFloat(frame.midX), y: CGFloat(frame.midY))
        circle.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(5.0))
        layer.addSublayer(circle)
        updateHands()
    }
    
    
}
