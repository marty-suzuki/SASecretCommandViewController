//
//  SASecretCommandManager.swift
//  SASecretCommandViewController
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public enum SASecretCommandType: String {
    case up = "Up"
    case down = "Down"
    case left = "Left"
    case right = "Right"
    case a = "A"
    case b = "B"
    
    init?(direction: UISwipeGestureRecognizerDirection) {
        if direction.contains(.right) {
            self = .right
            return
        } else if direction.contains(.left) {
            self = .left
            return
        } else if direction.contains(.down) {
            self = .down
            return
        } else if direction.contains(.up) {
            self = .up
            return
        }
        return nil
    }
}

protocol SASecretCommandManagerDelegate: class {
    func secretCommandManagerShowButtonView(_ manager: SASecretCommandManager)
    func secretCommandManagerCloseButtonView(_ manager: SASecretCommandManager)
    func secretCommandManagerSecretCommandPassed(_ manager: SASecretCommandManager)
}

class SASecretCommandManager: NSObject {
    
    fileprivate var commandStack: [SASecretCommandType] = []
    var secretCommandList: [SASecretCommandType]?
    weak var delegate: SASecretCommandManagerDelegate?

    func checkCommand(_ command: SASecretCommandType) {
        let index = commandStack.count
        
        guard let secretCommandList = secretCommandList else { return }
        if index > secretCommandList.count - 1 {
            commandStack.removeAll(keepingCapacity: false)
            return
        }
        
        let secretCommand = secretCommandList[index]
        if secretCommand == command {
            commandStack.append(command)
            
            if let nextCommand = secretCommandList.next(index) {
                switch nextCommand {
                case .a, .b:
                    delegate?.secretCommandManagerShowButtonView(self)
                case .up, .down, .left, .right:
                    delegate?.secretCommandManagerCloseButtonView(self)
                }
            }
        } else {
            if index > 0 {
                commandStack.removeAll(keepingCapacity: false)
                
                if let secretCommand = secretCommandList.first {
                    if secretCommand == command {
                        commandStack.append(command)
                    }
                }
                
                if let nextCommand = secretCommandList.next(0) {
                    switch nextCommand {
                    case .a, .b:
                        delegate?.secretCommandManagerShowButtonView(self)
                    case .up, .down, .left, .right:
                        delegate?.secretCommandManagerCloseButtonView(self)
                    }
                }
                
                return
            }
        }

        guard commandStack.count == secretCommandList.count else { return }
        
        let filtedCommandList = secretCommandList.enumerated().filter { $0.element != secretCommandList[$0.offset] }
        if filtedCommandList.count > 0 { return }
            
        delegate?.secretCommandManagerSecretCommandPassed(self)
        commandStack.removeAll(keepingCapacity: false)
    }
}

private extension Array {
    func hasNext(_ index: Int) -> Bool {
        return count > index + 1
    }
    
    func next(_ index: Int) -> Element? {
        guard hasNext(index) else { return nil }
        return self[index + 1]
    }
}
