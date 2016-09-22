# SASecretCommandViewController

[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/SASecretCommandViewController.svg?style=flat)](http://cocoadocs.org/docsets/SASecretCommandViewController)
[![License](https://img.shields.io/cocoapods/l/SASecretCommandViewController.svg?style=flat)](http://cocoadocs.org/docsets/SASecretCommandViewController)
[![Platform](https://img.shields.io/cocoapods/p/SASecretCommandViewController.svg?style=flat)](http://cocoadocs.org/docsets/SASecretCommandViewController)

#### You can use secret command with swipe gesture and A, B button. Show a secret mode you want!

![](./SampleImage/secret.gif)

## Features

- [x] Secret command register
- [x] Unlock with secret command
- [x] Show input command with animation
- [x] Support Swift2.3

## Installation

#### CocoaPods

SASecretCommandViewController is available through [CocoaPods](http://cocoapods.org). If you have cocoapods 0.36 beta or greater, you can install
it, simply add the following line to your Podfile:

    pod "SASecretCommandViewController"

#### Manually

Add the [SASecretCommandViewController](./SASecretCommandViewController) directory to your project.

## Usage

If you install from cocoapods, You have to white `import SASecretCommandViewController`.

Extend `SASecretCommandViewController` like this.

```swift

class ViewController: SASecretCommandViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Register secret command with SASecretCommandType
        let commandList: [SASecretCommandType] = [
            .up,
            .up,
            .down,
            .down,
            .left,
            .right,
            .left,
            .right,
            .b,
            .a
        ]
        self.registerSecretCommand(commandList)

        //Show inpunt command as icon
        self.showInputCommand = true
    }
}

```

if substitute `true` for `public var showInputCommand`, shown input command on view. On the other hand, if substitute `false`, hidden input command.

Allowed input command is below.

```swift
public enum SASecretCommandType {
    case Uu, down, left, right, a, b
}
```

if passed the secret command, called `public var didPassSecretCommandHandler: (() -> ())?`.

For example, showing custom alert.

```swift
didPassSecretCommandHandler = { [weak self] in
    let controller = UIAlertController(title: "Command Passed", message: "This is secret mode!!", preferredStyle: .Alert)
    let action = UIAlertAction(title: "OK", style: .Default) { _ in
        self?.imageView.image = UIImage(named: "secret")
    }
    controller.addAction(action)
    self?.presentViewController(controller, animated: true, completion: nil)
}
```

## Requirements

- Xcode 8 or greater
- iOS 8 or greater
- QuartzCore.framework

## Author

Taiki Suzuki, s1180183@gmail.com

## License

SASecretCommandViewController is available under the MIT license. See the LICENSE file for more info.
