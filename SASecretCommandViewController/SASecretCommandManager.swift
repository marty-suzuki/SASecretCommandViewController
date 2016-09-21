//
//  SASecretCommandManager.swift
//  SASecretCommandViewController
//
//  Created by 鈴木大貴 on 2015/02/07.
//  Copyright (c) 2015年 鈴木大貴. All rights reserved.
//

import UIKit

public enum SASecretCommandType: String {
    case Up = "Up"
    case Down = "Down"
    case Left = "Left"
    case Right = "Right"
    case A = "A"
    case B = "B"
    
    init?(direction: UISwipeGestureRecognizerDirection) {
        if direction.contains(.Right) {
            self = .Right
            return
        } else if direction.contains(.Left) {
            self = .Left
            return
        } else if direction.contains(.Down) {
            self = .Down
            return
        } else if direction.contains(.Up) {
            self = .Up
            return
        }
        return nil
    }
}

protocol SASecretCommandManagerDelegate: class {
    func secretCommandManagerShowButtonView(manager: SASecretCommandManager)
    func secretCommandManagerCloseButtonView(manager: SASecretCommandManager)
    func secretCommandManagerSecretCommandPassed(manager: SASecretCommandManager)
}

class SASecretCommandManager: NSObject {
    
    private var commandStack: [SASecretCommandType] = []
    var secretCommandList: [SASecretCommandType]?
    weak var delegate: SASecretCommandManagerDelegate?

    func checkCommand(command: SASecretCommandType) {
        let index = commandStack.count
        
        guard let secretCommandList = secretCommandList else { return }
        if index > secretCommandList.count - 1 {
            commandStack.removeAll(keepCapacity: false)
            return
        }
        
        let secretCommand = secretCommandList[index]
        if secretCommand == command {
            commandStack.append(command)
            
            if let nextCommand = secretCommandList.next(index) {
                switch nextCommand {
                case .A, .B:
                    delegate?.secretCommandManagerShowButtonView(self)
                case .Up, .Down, .Left, .Right:
                    delegate?.secretCommandManagerCloseButtonView(self)
                }
            }
        } else {
            if index > 0 {
                commandStack.removeAll(keepCapacity: false)
                
                if let secretCommand = secretCommandList.first {
                    if secretCommand == command {
                        commandStack.append(command)
                    }
                }
                
                if let nextCommand = secretCommandList.next(0) {
                    switch nextCommand {
                    case .A, .B:
                        delegate?.secretCommandManagerShowButtonView(self)
                    case .Up, .Down, .Left, .Right:
                        delegate?.secretCommandManagerCloseButtonView(self)
                    }
                }
                
                return
            }
        }

        guard commandStack.count == secretCommandList.count else { return }
        
        let filtedCommandList = secretCommandList.enumerate().filter { $0.element != secretCommandList[$0.index] }
        if filtedCommandList.count > 0 { return }
            
        delegate?.secretCommandManagerSecretCommandPassed(self)
        commandStack.removeAll(keepCapacity: false)
    }
}

private extension Array {
    private func hasNext(index: Int) -> Bool {
        return count > index + 1
    }
    
    func next(index: Int) -> Element? {
        guard hasNext(index) else { return nil }
        return self[index + 1]
    }
}
