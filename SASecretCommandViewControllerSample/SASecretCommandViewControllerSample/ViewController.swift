//
//  ViewController.swift
//  SASecretCommandViewControllerSample
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class ViewController: SASecretCommandViewController {
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let commandList: [SASecretCommandType] = [
            .Up,
            .Up,
            .Down,
            .Down,
            .Left,
            .Right,
            .Left,
            .Right,
            .B,
            .A
        ]
        
        self.registerSecretCommand(commandList)
        self.showInputCommand = true
        
        self.imageView.frame = self.view.bounds
        self.imageView.image = UIImage(named: "normal")
        self.view.addSubview(self.imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func secretCommandPassed() {
        super.secretCommandPassed()
        
        let font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 16.0)
        let redColor = UIColor.redColor()
        
        let controller = MSAlertController(title: "Command Passed", message: "This is secret mode!!", preferredStyle: .Alert)
        controller.alertBackgroundColor = .blackColor()
        controller.titleColor = redColor
        controller.separatorColor = redColor
        controller.messageColor = redColor
        controller.titleFont = font
        controller.messageFont = font
        let action = MSAlertAction(title: "OK", style: .Default) { (action) in
            self.imageView.image = UIImage(named: "secret")
        }
        action.titleColor = redColor
        action.highlightedColor = .grayColor()
        action.font = font
        controller.addAction(action)
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

