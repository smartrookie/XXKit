//
//  XXFPSLabel.swift
//  XXDemo
//
//  Created by rookie on 16/10/18.
//  Copyright © 2016年 rookie. All rights reserved.
//

import UIKit

class XXFPSLabel: UILabel {
    
    
    private var _count : NSInteger = 0
    private var _lastTime : NSTimeInterval = 0.0
    
    private var _link : CADisplayLink?
    private let _font    = UIFont(name: "Menlo", size: 14) ?? UIFont(name: "Courier", size: 14)
    private let _subfont = UIFont(name: "Menlo", size: 4)  ?? UIFont(name: "Courier", size: 4)
    
    private let kSize = CGSizeMake(70, 20)
    private var beganPoint = CGPointZero
    
   
    class func launch() -> XXFPSLabel {
        
        let fps = XXFPSLabel()
        return fps
    }
    
    
    override private init(frame: CGRect) {
        var _frame = frame
        if _frame.size.width == 0 && _frame.size.height == 0 {
            _frame.origin.x = 0
            _frame.origin.y = 64
            _frame.size = kSize
        }
        super.init(frame: _frame)
        
        
        layer.cornerRadius = 5
        clipsToBounds      = true
        textAlignment      = .Center
        userInteractionEnabled = true
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        _link = CADisplayLink(target: self, selector: .fpsTick)
        _link!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    
    func fpsTick(link:CADisplayLink) {
        
        guard _lastTime != 0 else {
            _lastTime = link.timestamp
            return
        }
        _count += 1
        let delta = link.timestamp - _lastTime
        if delta < 1 {
            return
        }
        _lastTime = link.timestamp
        let fps = Float(_count) / Float(delta)
        _count = 0
        
        let progress = CGFloat(fps) / 60.0
        
        let color = UIColor(hue: 0.27 * (progress - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        
        let text = NSMutableAttributedString(string: String(format: "%.1f FPS",round(fps)))
        text.addAttributes([NSForegroundColorAttributeName:color], range: NSMakeRange(0, text.length - 3))
        text.addAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], range: NSMakeRange(text.length - 3, 3))
        text.addAttributes([NSFontAttributeName:_font!], range: NSMakeRange(0, text.length - 3))
        text.addAttributes([NSFontAttributeName:_subfont!], range: NSMakeRange(text.length - 4, 1))
        attributedText = text
        
        if UIApplication.sharedApplication().keyWindow!.subviews.contains(self) == false {
            UIApplication.sharedApplication().keyWindow!.addSubview(self)
            UIApplication.sharedApplication().keyWindow!.bringSubviewToFront(self)
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch?.locationInView(superview)
        beganPoint = point!
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch?.locationInView(superview)
        
        let x = point!.x - beganPoint.x
        let y = point!.y - beganPoint.y
        
        var _frame = frame
        _frame.origin.x += x
        _frame.origin.y += y
        
        let maxW = UIScreen.mainScreen().bounds.width - _frame.size.width
        let maxH = UIScreen.mainScreen().bounds.height - frame.size.height
        
        beganPoint = point!
        if     _frame.origin.x < 0
            || _frame.origin.y < 20
            || _frame.origin.x > maxW
            || _frame.origin.y > (maxH - 20) {
            return
        } else {
            frame = _frame
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        beganPoint = CGPointZero
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let left  = frame.origin.x
        let right = screenWidth - frame.origin.x - frame.size.width
        
        let distance = min(left, right)
        let duration : NSTimeInterval = Double( 0.6 * (distance / (screenWidth / 2)) )
        
        var isLeft : CGFloat = 1
        if left > right {
            isLeft = -1
        } else {
            isLeft = 1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseIn, animations: {
            self.frame.origin.x -= isLeft * CGFloat( distance )
            self.userInteractionEnabled = false
        }) { (_) in
            self.userInteractionEnabled = true
        }
        
    }
    
    deinit {
        _link!.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Selector {
    static let fpsTick = #selector(XXFPSLabel.fpsTick(_:))
}



