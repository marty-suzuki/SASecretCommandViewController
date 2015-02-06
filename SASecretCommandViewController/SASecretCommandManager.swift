//
//  SASecretCommandManager.swift
//  SASecretCommandViewController
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public enum SASecretCommandType {
    case Up, Down, Left, Right, A, B
    static func convert(direction: UISwipeGestureRecognizerDirection) -> SASecretCommandType! {
        if direction == .Right {
            return .Right
        } else if direction == .Left {
            return .Left
        } else if direction == .Down {
            return .Down
        } else if direction == .Up {
            return .Up
        }
        return nil
    }
    
    func value() -> String {
        switch self {
            case .Up:
                return "Up"
            case .Down:
                return "Down"
            case .Left:
                return "Left"
            case .Right:
                return "Right"
            case .A:
                return "A"
            case B:
                return "B"
        }
    }
}

protocol SASecretCommandManagerDelegate: class {
    func secretCommandManagerShowButtonView(manager: SASecretCommandManager)
    func secretCommandManagerCloseButtonView(manager: SASecretCommandManager)
    func secretCommandManagerSecretCommandPassed(manager: SASecretCommandManager)
}

class SASecretCommandManager: NSObject {
    private var commandStack = [SASecretCommandType]()
    var secretCommandList: [SASecretCommandType]!
    weak var delegate: SASecretCommandManagerDelegate!

    func checkCommand(command: SASecretCommandType) {
        let index = self.commandStack.count
        
        if (index > self.secretCommandList.count - 1) {
            self.commandStack.removeAll(keepCapacity: false)
            println("remove 1")
            return;
        }
        
        if let secretCommand = self.secretCommandList?[index] {
            if secretCommand == command {
                self.commandStack.append(command)
                
                if index + 1 < self.secretCommandList.count {
                    if let nextCommand = self.secretCommandList?[index + 1] {
                        switch nextCommand {
                            case .A, .B:
                                self.delegate?.secretCommandManagerShowButtonView(self)
                            case .Up, .Down, .Left, .Right:
                                self.delegate?.secretCommandManagerCloseButtonView(self)
                        }
                    }
                }
                
            } else {
                if index > 0 {
                    self.commandStack.removeAll(keepCapacity: false)
                    println("remove 2")
                    return;
                }
            }
        }
        
        if self.commandStack.count == self.secretCommandList.count {
            for (index, secretCommand) in enumerate(self.secretCommandList) {
                if (secretCommand != self.commandStack[index]) {
                    return;
                }
            }
            
            self.delegate?.secretCommandManagerSecretCommandPassed(self)
            self.commandStack.removeAll(keepCapacity: false)
            println("remove 3")
        }
    }
}
