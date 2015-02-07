//
//  SASecretCommandView.swift
//  SASecretCommandViewControllerSample
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import QuartzCore

class SASecreatCommandButtonView: UIView {
    
    private var buttonContainerView: UIView!
    weak var delegate: SASecreatCommandButtonViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        self.buttonContainerView.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        self.buttonContainerView.backgroundColor = UIColor(red: 140.0 / 255.0, green: 45.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        self.buttonContainerView.layer.cornerRadius = 10.0
        self.addSubview(self.buttonContainerView)
        
        let colorView = UIView(frame: CGRect(x: 10.0, y: 10.0, width: 180, height: 80))
        colorView.backgroundColor = UIColor(red: 225.0 / 255.0, green: 215.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
        colorView.layer.cornerRadius = 5.0
        self.buttonContainerView.addSubview(colorView)
        
        let line1 = UIView(frame: CGRect(x: 10.0, y: 60.0, width: 180.0, height: 3.0))
        line1.backgroundColor = .blackColor()
        self.buttonContainerView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: 10.0, y: 70.0, width: 180.0, height: 3.0))
        line2.backgroundColor = .blackColor()
        self.buttonContainerView.addSubview(line2)
        
        let aButtonContainer = UIView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
        aButtonContainer.backgroundColor = UIColor(red: 140.0 / 255.0, green: 45.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        aButtonContainer.layer.cornerRadius = 30
        self.buttonContainerView.addSubview(aButtonContainer)
        
        let aButtonColor = UIView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        aButtonColor.backgroundColor = .blackColor()
        aButtonColor.layer.cornerRadius = 25
        aButtonContainer.addSubview(aButtonColor)
        
        let aButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        aButton.setTitle("A", forState: .Normal)
        aButton.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        aButton.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        aButton.addTarget(self, action: "aButtonTapped:", forControlEvents: .TouchUpInside)
        aButtonContainer.addSubview(aButton)
        
        let bButtonContainer = UIView(frame: CGRect(x: self.buttonContainerView.frame.size.width - 80, y:20, width: 60, height: 60))
        bButtonContainer.backgroundColor = UIColor(red: 140.0 / 255.0, green: 45.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        bButtonContainer.layer.cornerRadius = 30
        self.buttonContainerView.addSubview(bButtonContainer)
        
        let bButtonColor = UIView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        bButtonColor.backgroundColor = .blackColor()
        bButtonColor.layer.cornerRadius = 25
        bButtonContainer.addSubview(bButtonColor)
        
        let bButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        bButton.setTitle("B", forState: .Normal)
        bButton.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        bButton.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        bButton.addTarget(self, action: "bButtonTapped:", forControlEvents: .TouchUpInside)
        bButtonContainer.addSubview(bButton)
    }
    
    func aButtonTapped(sender: AnyObject) {
        self.delegate?.secretCommandButtonViewAButtonTapped(self)
    }
    
    func bButtonTapped(sender: AnyObject) {
        self.delegate?.secretCommandButtonViewBButtonTapped(self)
    }
}

class SASecretCommandKeyView: UIView {
    
    private var arrow: SASecretCommandArrowView!
    private var commandLabel: UILabel!
    
    private var _commandType: SASecretCommandType!
    var commandType: SASecretCommandType! {
        set {
            _commandType = newValue
            
            switch _commandType! {
                case .A, .B:
                    self.commandLabel = self.createCommandLabel(_commandType.value())
                    self.addSubview(self.commandLabel)
                case .Up:
                    self.arrow = self.createArrowView()
                    self.addSubview(self.arrow)
                case .Down:
                    self.arrow = self.createArrowView()
                    self.arrow.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, 0.0, 1.0)
                    self.addSubview(self.arrow)
                case .Left:
                    self.arrow = self.createArrowView()
                    self.arrow.layer.transform = CATransform3DMakeRotation(-CGFloat(M_PI_2), 0.0, 0.0, 1.0)
                    self.addSubview(self.arrow)
                case .Right:
                    self.arrow = self.createArrowView()
                    self.arrow.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0)
                    self.addSubview(self.arrow)
            }
        }
        get {
            return _commandType
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        self.layer.cornerRadius = 30.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 5
    }
    
    private func createArrowView() -> SASecretCommandArrowView {
        let arrow = SASecretCommandArrowView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        arrow.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        return arrow
    }
    
    private func createCommandLabel(string: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        label.text = string
        label.textColor = .whiteColor()
        label.textAlignment = .Center
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 100)
        return label
    }
}

private class SASecretCommandArrowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clearColor()
    }
    
    private override func drawRect(rect: CGRect) {
        let minX = CGRectGetMinX(rect)
        let midX = CGRectGetMidX(rect)
        let maxX = CGRectGetMaxX(rect)
        let minY = CGRectGetMinY(rect)
        let midY = CGRectGetMidY(rect)
        let maxY = CGRectGetMaxY(rect);
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0)
        
        CGContextMoveToPoint(context, midX, minY)
        CGContextAddLineToPoint(context, maxX, midY)
        CGContextAddLineToPoint(context, maxX - 20, midY)
        CGContextAddLineToPoint(context, maxX - 20, maxY)
        CGContextAddLineToPoint(context, minX + 20, maxY)
        CGContextAddLineToPoint(context, minX + 20, midY)
        CGContextAddLineToPoint(context, minX, midY)
        CGContextAddLineToPoint(context, midX, minY)
        
        CGContextClosePath(context)
    
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}