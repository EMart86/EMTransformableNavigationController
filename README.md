# EMTransformableNavigationController

[![CI Status](http://img.shields.io/travis/eberl_ma@gmx.at/EMTransformableNavigationController.svg?style=flat)](https://travis-ci.org/eberl_ma@gmx.at/EMTransformableNavigationController)
[![Version](https://img.shields.io/cocoapods/v/EMTransformableNavigationController.svg?style=flat)](http://cocoapods.org/pods/EMTransformableNavigationController)
[![License](https://img.shields.io/cocoapods/l/EMTransformableNavigationController.svg?style=flat)](http://cocoapods.org/pods/EMTransformableNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/EMTransformableNavigationController.svg?style=flat)](http://cocoapods.org/pods/EMTransformableNavigationController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EMTransformableNavigationController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EMTransformableNavigationController'
```

## Author

Martin Eberl eberl_ma@gmx.at

## License

EMTransformableNavigationController is available under the MIT license. See the LICENSE file for more info.

## Example 

Simply add the NavigationController to your view controller

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    createAndAddTransformableViewController()
}

private func createAndAddTransformableViewController() {
    let viewController = UIViewController() //use any viewController
    viewController.view.backgroundColor = .lightGray
    let navigationController = EMTransformableNavigationController(rootViewController: viewController)
    navigationController.add(to: self)
}
```

A more convenient way to add a viewController is with the motion shake gesture


```swift
override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
        createTransformableNavigationController()
    }
}
```

To remove the viewController, simply call

```swift
    transformableNavigationController.removeFromParentViewController() 
    //of course the navigationController needed to be stored in a proterty which we called transformableNavigationController
```

If you don't want the user to move out of the visible frame, simply set following property (defaulf is nil, which allowes the user to drag the navigation controller out of the bounds)

```swift
transformableNavigationController.allowedFrame = view.bounds
```

If you think, the user should be allowed to only shrink your view to a specific size, simply set following property (default is 100x100 px)

```swift
transformableNavigationController.minViewSize = CGSize(width: 300, height: 150)
```

If you were wondering if all this works with autolayout; it does, i just tested it :)
