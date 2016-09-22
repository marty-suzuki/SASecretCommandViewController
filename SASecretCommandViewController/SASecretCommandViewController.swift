//
//  SASecretCommandViewController.swift
//  SASecretCommandViewController
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

open class SASecretCommandViewController: UIViewController {

    fileprivate let commandManager = SASecretCommandManager()
    
    fileprivate var buttonView: SASecreatCommandButtonView?
    fileprivate var keyView: SASecretCommandKeyView?
    
    open var showInputCommand = false    
    fileprivate var gestures: [UISwipeGestureRecognizer]?
    
    open var didPassSecretCommandHandler: (() -> ())?
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        commandManager.delegate = self
        addGesture()
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func addGesture() {
        gestures = [.up, .down, .right, .left].map { (dicrection: UISwipeGestureRecognizerDirection) -> UISwipeGestureRecognizer in
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(SASecretCommandViewController.detectSwipeGesture(_:)))
            gesture.direction = dicrection
            view.addGestureRecognizer(gesture)
            return gesture
        }
    }
    
    fileprivate func removeGesture() {
        gestures?.forEach { view.removeGestureRecognizer($0) }
    }
    
    fileprivate func createButtonView() -> SASecreatCommandButtonView {
        let buttonView = SASecreatCommandButtonView(frame: view.bounds)
        buttonView.delegate = self
        return buttonView
    }
    
    fileprivate func removeButtonView() -> Bool {
        guard let buttonView = buttonView else { return false }
        buttonView.removeFromSuperview()
        addGesture()
        return true
    }
    
//    private func showButtonView() {
//        
//        self.buttonView = self.createButtonView()
//        self.buttonView.alpha = 0.0
//        self.buttonView.transform = CGAffineTransformMakeScale(1.2, 1.2)
//        self.view.addSubview(self.buttonView)
//        self.removeGesture()
//        
//        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseIn, animations: {
//            
//            self.buttonView.alpha = 1.0
//            self.buttonView.transform = CGAffineTransformIdentity
//
//        }, completion: { (finished) in
//            
//        })
//    }
//    
//    private func hideButtonView() {
//        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseIn, animations: {
//            
//            self.buttonView.alpha = 0.0
//            self.buttonView.transform = CGAffineTransformMakeScale(0.8, 0.8)
//            
//        }, completion: { (finished) in
//            
//            self.buttonView?.removeFromSuperview()
//            self.addGesture()
//            
//        })
//    }
    
    fileprivate func createKeyView(_ commandType: SASecretCommandType) -> SASecretCommandKeyView {
        let keyView = SASecretCommandKeyView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        keyView.center = CGPoint(x: view.frame.size.width / 2.0, y: view.frame.size.height / 2.0)
        keyView.commandType = commandType
        return keyView
    }
    
    fileprivate func removeKeyView() {
        keyView?.removeFromSuperview()
    }
    
    fileprivate func showKeyView(_ command: SASecretCommandType) {
        guard showInputCommand else { return }
        self.keyView?.removeFromSuperview()
        
        let keyView = createKeyView(command)
        keyView.alpha = 0.0
        view.addSubview(keyView)
        self.keyView = keyView
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
            keyView.alpha = 1.0
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                keyView.alpha = 0.0
            }, completion: { (finished) in
                self.removeKeyView()
            })
        })
    }
    
    func detectSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        guard let crossKeyCommand = SASecretCommandType(direction: gesture.direction) else { return }
        commandManager.checkCommand(crossKeyCommand)
        showKeyView(crossKeyCommand)
    }
    
    open func registerSecretCommand(_ commandList: [SASecretCommandType]) {
        if let command = commandList.first {
            switch command {
            case .a, .b:
                let buttonView = createButtonView()
                removeGesture()
                view.addSubview(buttonView)
                self.buttonView = buttonView
            case .up, .down, .left, .right:
                break
            }
        }
        commandManager.secretCommandList = commandList
    }
}

extension SASecretCommandViewController: SASecretCommandManagerDelegate {
    func secretCommandManagerShowButtonView(_ manager: SASecretCommandManager) {
        if !removeButtonView() {
            buttonView = createButtonView()
        }
        
        removeGesture()
        guard let buttonView = buttonView else { return }
        view.addSubview(buttonView)
    }
    
    func secretCommandManagerCloseButtonView(_ manager: SASecretCommandManager) {
        removeButtonView()
    }
    
    func secretCommandManagerSecretCommandPassed(_ manager: SASecretCommandManager) {
        removeButtonView()
        didPassSecretCommandHandler?()
    }
}

extension SASecretCommandViewController: SASecreatCommandButtonViewDelegate {
    func secretCommandButtonView(_ buttonView: SASecreatCommandButtonView, didTap type: SASecretCommandType) {
        commandManager.checkCommand(type)
        showKeyView(type)
    }
}
