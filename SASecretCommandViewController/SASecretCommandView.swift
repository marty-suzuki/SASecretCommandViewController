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
    fileprivate struct Const {
        static let aButtonTag: Int = 10001
        static let bButtonTag: Int = 10002
    }
    
    fileprivate lazy var buttonContainerView: UIView = {
        let buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        buttonContainerView.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        buttonContainerView.backgroundColor = UIColor(red: 140.0 / 255.0, green: 45.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        buttonContainerView.layer.cornerRadius = 10.0
        self.addSubview(buttonContainerView)
        return buttonContainerView
    }()
    
    weak var delegate: SASecreatCommandButtonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        
        let colorView = UIView(frame: CGRect(x: 10.0, y: 10.0, width: 180, height: 80))
        colorView.backgroundColor = UIColor(red: 225.0 / 255.0, green: 215.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
        colorView.layer.cornerRadius = 5.0
        buttonContainerView.addSubview(colorView)
        
        let line1 = UIView(frame: CGRect(x: 10.0, y: 60.0, width: 180.0, height: 3.0))
        line1.backgroundColor = .black
        buttonContainerView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: 10.0, y: 70.0, width: 180.0, height: 3.0))
        line2.backgroundColor = .black
        buttonContainerView.addSubview(line2)
        
        let aButtonContainer = UIView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
        aButtonContainer.backgroundColor = UIColor(red: 140.0 / 255.0, green: 45.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        aButtonContainer.layer.cornerRadius = 30
        buttonContainerView.addSubview(aButtonContainer)
        
        let aButtonColor = UIView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        aButtonColor.backgroundColor = .black
        aButtonColor.layer.cornerRadius = 25
        aButtonContainer.addSubview(aButtonColor)
        
        let aButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        aButton.setTitle("A", for: UIControlState())
        aButton.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        aButton.setTitleColor(UIColor.red, for: .highlighted)
        aButton.tag = Const.aButtonTag
        aButton.addTarget(self, action: #selector(SASecreatCommandButtonView.buttonTapped(_:)), for: .touchUpInside)
        aButtonContainer.addSubview(aButton)
        
        let bButtonContainer = UIView(frame: CGRect(x: buttonContainerView.frame.size.width - 80, y:20, width: 60, height: 60))
        bButtonContainer.backgroundColor = UIColor(red: 140.0 / 255.0, green: 45.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        bButtonContainer.layer.cornerRadius = 30
        buttonContainerView.addSubview(bButtonContainer)
        
        let bButtonColor = UIView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        bButtonColor.backgroundColor = .black
        bButtonColor.layer.cornerRadius = 25
        bButtonContainer.addSubview(bButtonColor)
        
        let bButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        bButton.setTitle("B", for: UIControlState())
        bButton.titleLabel?.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        bButton.setTitleColor(UIColor.red, for: .highlighted)
        bButton.tag = Const.bButtonTag
        bButton.addTarget(self, action: #selector(SASecreatCommandButtonView.buttonTapped(_:)), for: .touchUpInside)
        bButtonContainer.addSubview(bButton)
    }
    
    func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case Const.aButtonTag:
            delegate?.secretCommandButtonView(self, didTap: .a)
        case Const.bButtonTag:
            delegate?.secretCommandButtonView(self, didTap: .b)
        default:
            return
        }
    }
}

protocol SASecreatCommandButtonViewDelegate: class {
    func secretCommandButtonView(_ buttonView: SASecreatCommandButtonView, didTap type: SASecretCommandType)
}

class SASecretCommandKeyView: UIView {
    
    fileprivate var arrow: SASecretCommandArrowView?
    fileprivate var commandLabel: UILabel?
    
    var commandType: SASecretCommandType? {
        didSet {
            guard let commandType = commandType else { return }
            
            let transform: CATransform3D
            switch commandType {
            case .a, .b:
                let commandLabel = createCommandLabel(commandType.rawValue)
                addSubview(commandLabel)
                self.commandLabel = commandLabel
                return
            case .up:
                transform = CATransform3DIdentity
            case .down:
                transform = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, 0.0, 1.0)
            case .left:
                transform = CATransform3DMakeRotation(-CGFloat(M_PI_2), 0.0, 0.0, 1.0)
            case .right:
                transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0)
            }
            let arrow = createArrowView()
            arrow.layer.transform = transform
            addSubview(arrow)
            self.arrow = arrow
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    fileprivate func initialize() {
        isUserInteractionEnabled = false
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        layer.cornerRadius = 30.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }
    
    fileprivate func createArrowView() -> SASecretCommandArrowView {
        let arrow = SASecretCommandArrowView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        arrow.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        return arrow
    }
    
    fileprivate func createCommandLabel(_ string: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        label.text = string
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 100)
        return label
    }
}

private class SASecretCommandArrowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    fileprivate override func draw(_ rect: CGRect) {
        let minX = rect.minX
        let midX = rect.midX
        let maxX = rect.maxX
        let minY = rect.minY
        let midY = rect.midY
        let maxY = rect.maxY;
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.white.cgColor)
        context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        context.move(to: CGPoint(x: midX, y: minY))
        context.addLine(to: CGPoint(x: maxX, y: midY))
        context.addLine(to: CGPoint(x: maxX - 20, y: midY))
        context.addLine(to: CGPoint(x: maxX - 20, y: maxY))
        context.addLine(to: CGPoint(x: minX + 20, y: maxY))
        context.addLine(to: CGPoint(x: minX + 20, y: midY))
        context.addLine(to: CGPoint(x: minX, y: midY))
        context.addLine(to: CGPoint(x: midX, y: minY))
        
        context.closePath()
    
        context.drawPath(using: .fillStroke);
    }
}
