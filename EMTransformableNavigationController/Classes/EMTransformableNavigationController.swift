//
//  EMTransformableNavigationController.swift
//  Pods
//
//  Created by Martin Eberl on 05.08.17.
//
//

import UIKit

public protocol EMTransformableNavigationControllerDelegate: class {
    func transformableNavigationController(_ transformableNavigationController: EMTransformableNavigationController, didResize to: CGSize)
}

public final class EMTransformableNavigationController: UINavigationController {
    var allowedFrame = CGRect.zero
    var minViewSize = CGSize(width: 100, height: 100)
    weak var transformDelegate: EMTransformableNavigationControllerDelegate?
    
    fileprivate var lastTouchDownLocation = CGPoint.zero
    fileprivate var lastStoredTouchDownLocation = CGPoint.zero
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(EMTransformableNavigationController.handlePan(_ :))
        )
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }()
    
    private lazy var pinchGestureRecognizer: UIPinchGestureRecognizer = {
        let gestureRecognizer = UIPinchGestureRecognizer(
            target: self,
            action: #selector(EMTransformableNavigationController.handlePinch(_ :))
        )
        return gestureRecognizer
    }()
    
    deinit {
        view.removeGestureRecognizer(panGestureRecognizer)
        view.removeGestureRecognizer(pinchGestureRecognizer)
    }
    
    //MARK: - UIViewController Methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - Public
    
    public func add(to parent: UIViewController) {
        parent.addChildViewController(self)
        if let window = parent.view.window {
            window.addSubview(view)
            if allowedFrame == .zero {
                allowedFrame = window.frame
            }
        } else {
            parent.view.addSubview(view)
            if allowedFrame == .zero {
                allowedFrame = parent.view.frame
            }
        }
        view.frame = allowedFrame
        didMove(toParentViewController: parent)
    }
    
    //MARK: - Private
    
    private func setupUI() {
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        if let windowFrame = view.window?.bounds {
            if allowedFrame == .zero {
                allowedFrame = windowFrame
            }
        }
        
        view.addGestureRecognizer(panGestureRecognizer)
        view.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    private func correctedOrigin(for view: UIView, moveTo origin: CGPoint, in allowedFrame: CGRect) -> CGPoint {
        let frame = view.frame
        let height = frame.height
        let width = frame.width
        let allowedWidth = allowedFrame.width
        let allowedHeight = allowedFrame.height
        let newXPos = origin.x
        let newYPos = origin.y
        var newOriginXPos = newXPos
        var newOriginYPos = newYPos
        
        if newOriginXPos + width > allowedWidth {
            newOriginXPos = allowedWidth - width
        } else if newOriginXPos < 0 {
            newOriginXPos = 0
        }
        
        if newOriginYPos + height > allowedHeight {
            newOriginYPos = allowedHeight - height
        } else if newOriginYPos < 0 {
            newOriginYPos = 0
        }
        
        return CGPoint(x: newOriginXPos, y: newOriginYPos);
    }
    
    //MARK: - Private Objc
    
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        var origin = gestureRecognizer.translation(in: self.view.window)
        origin.x += lastTouchDownLocation.x
        origin.y += lastTouchDownLocation.y
        
        view.move(to: origin, stayIn: allowedFrame)
        lastStoredTouchDownLocation = view.frame.origin
    }
    
    @objc private func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.numberOfTouches == 2 else {
            return
        }
        let originFrame = view.frame
        let firstTouchLocation = gestureRecognizer.location(ofTouch: 0, in: view.window)
        let secondTouchLocation = gestureRecognizer.location(ofTouch: 1, in: view.window)
        
        view.resize(between: firstTouchLocation, and: secondTouchLocation)
        lastStoredTouchDownLocation = view.frame.origin
        
        view.move(
            to: topLeft(between: firstTouchLocation, and: secondTouchLocation),
            stayIn: allowedFrame
        )
        
        let newSize = view.frame.size
        
        if !newSize.equalTo(originFrame.size) {
            transformDelegate?.transformableNavigationController(self, didResize: newSize)
        }
    }
}

extension EMTransformableNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            lastTouchDownLocation = lastStoredTouchDownLocation
        }
        return true
    }
}
