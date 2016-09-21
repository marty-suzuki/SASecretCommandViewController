//
//  ViewController.swift
//  SASecretCommandViewControllerSample
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit
import SASecretCommandViewController

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
        
        registerSecretCommand(commandList)
        showInputCommand = true
        
        imageView.frame = view.bounds
        imageView.image = UIImage(named: "normal")
        view.addSubview(imageView)
        
        didPassSecretCommandHandler = { [weak self] in
            let controller = UIAlertController(title: "Command Passed", message: "This is secret mode!!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                self?.imageView.image = UIImage(named: "secret")
            }
            controller.addAction(action)
            self?.presentViewController(controller, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
