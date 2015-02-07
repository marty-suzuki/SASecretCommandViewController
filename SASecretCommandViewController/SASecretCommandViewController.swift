//
//  SASecretCommandViewController.swift
//  SASecretCommandViewController
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public class SASecretCommandViewController: UIViewController {

    private let commandManager = SASecretCommandManager()
    
    private var buttonView: SASecreatCommandButtonView!
    private var keyView: SASecretCommandKeyView!
    
    private var upGesture: UISwipeGestureRecognizer!
    private var downGesture: UISwipeGestureRecognizer!
    private var leftGesture: UISwipeGestureRecognizer!
    private var rightGesture: UISwipeGestureRecognizer!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.commandManager.delegate = self
        self.addGesture()
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addGesture() {
        self.upGesture = UISwipeGestureRecognizer(target: self, action: "detectSwipeGesture:")
        self.upGesture.direction = .Up
        self.view.addGestureRecognizer(self.upGesture)
        
        self.downGesture = UISwipeGestureRecognizer(target: self, action: "detectSwipeGesture:")
        self.downGesture.direction = .Down
        self.view.addGestureRecognizer(self.downGesture)
        
        self.rightGesture = UISwipeGestureRecognizer(target: self, action: "detectSwipeGesture:")
        self.rightGesture.direction = .Right
        self.view.addGestureRecognizer(self.rightGesture)
        
        self.leftGesture = UISwipeGestureRecognizer(target: self, action: "detectSwipeGesture:")
        self.leftGesture.direction = .Left
        self.view.addGestureRecognizer(self.leftGesture)
    }
    
    private func removeGesture() {
        self.view.removeGestureRecognizer(self.upGesture)
        self.view.removeGestureRecognizer(self.downGesture)
        self.view.removeGestureRecognizer(self.leftGesture)
        self.view.removeGestureRecognizer(self.rightGesture)
    }
    
    private func createButtonView() -> SASecreatCommandButtonView {
        let buttonView = SASecreatCommandButtonView(frame: self.view.bounds)
        buttonView.delegate = self
        return buttonView
    }
    
    private func removeButtonView() -> Bool {
        if let buttonView = self.buttonView? {
            buttonView.removeFromSuperview()
            self.addGesture()
            return true
        }
        return false
    }
    
    private func createKeyView(commandType: SASecretCommandType) -> SASecretCommandKeyView {
        let keyView = SASecretCommandKeyView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        keyView.center = CGPoint(x: self.view.frame.size.width / 2.0, y: self.view.frame.size.height / 2.0)
        keyView.commandType = commandType
        return keyView
    }
    
    private func removeKeyView() {
        self.keyView.removeFromSuperview()
    }
    
    private func showKeyView(command: SASecretCommandType) {
        self.keyView = self.createKeyView(command)
        self.keyView.alpha = 0.0
        self.view.addSubview(self.keyView)
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseIn, animations: {
            self.keyView.alpha = 1.0
        }, completion: { (finished) in
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseIn, animations: {
                self.keyView.alpha = 0.0
            }, completion: { (finished) in
                self.removeKeyView()
            })
        })
    }
    
    func detectSwipeGesture(gesture: UISwipeGestureRecognizer) {
        let crossKeyCommand = SASecretCommandType.convert(gesture.direction)

        self.commandManager.checkCommand(crossKeyCommand)
        
        self.showKeyView(crossKeyCommand)
    }
    
    public func registerSecretCommand(commandList: [SASecretCommandType]) {
        if commandList.count > 0 {
            if let command = commandList.first {
                switch command {
                    case .A, .B:
                        self.buttonView = self.createButtonView()
                        self.removeGesture()
                        self.view.addSubview(self.buttonView)
                    case .Up, .Down, .Left, .Right:
                        break
                }
            }
        }
        
        self.commandManager.secretCommandList = commandList
    }
    
    public func secretCommandPassed() {}
}

extension SASecretCommandViewController: SASecretCommandManagerDelegate {
    func secretCommandManagerShowButtonView(manager: SASecretCommandManager) {
        if !self.removeButtonView() {
            self.buttonView = self.createButtonView()
        }
        
        self.removeGesture()
        self.view.addSubview(self.buttonView)
    }
    
    func secretCommandManagerCloseButtonView(manager: SASecretCommandManager) {
        self.removeButtonView()
    }
    
    func secretCommandManagerSecretCommandPassed(manager: SASecretCommandManager) {
        self.removeButtonView()
        self.secretCommandPassed()
    }
}

extension SASecretCommandViewController: SASecreatCommandButtonViewDelegate {
    func secretCommandButtonViewAButtonTapped(buttonView: SASecreatCommandButtonView) {
        self.commandManager.checkCommand(.A)
        
        self.showKeyView(.A)
    }
    
    func secretCommandButtonViewBButtonTapped(buttonView: SASecreatCommandButtonView) {
        self.commandManager.checkCommand(.B)
        
        self.showKeyView(.B)
    }
}

protocol SASecreatCommandButtonViewDelegate: class {
    func secretCommandButtonViewAButtonTapped(buttonView: SASecreatCommandButtonView)
    func secretCommandButtonViewBButtonTapped(buttonView: SASecreatCommandButtonView)
}
