//
//  ViewController.swift
//  SASecretCommandViewControllerSample
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

class ViewController: SASecretCommandViewController {
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func secretCommandPassed() {
        super.secretCommandPassed()
        
        let controller = MSAlertController(title: "Command Passed", message: "This is secret mode!!", preferredStyle: .Alert)
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

