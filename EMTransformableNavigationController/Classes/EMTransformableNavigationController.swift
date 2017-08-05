//
//  EMTransformableNavigationController.swift
//  Pods
//
//  Created by Martin Eberl on 05.08.17.
//
//

import UIKit

public protocol EMTransformableNavigationControllerDelegate: class {
    func transformableNavigationController(_ transformableNavigationController: EMTransformableNavigationController, didTransform to: CGRect)
}

public final class EMTransformableNavigationController: UINavigationController {
    public var allowedFrame: CGRect?
    public var minViewSize = CGSize(width: 100, height: 100)
    public weak var transformDelegate: EMTransformableNavigationControllerDelegate?
    
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
        willMove(toParentViewController: parent)
        parent.addChildViewController(self)
        parent.view.addSubview(view)
        view.frame = allowedFrame ?? parent.view.bounds
        didMove(toParentViewController: parent)
    }
    
    public override func removeFromParentViewController() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        didMove(toParentViewController: nil)
        super.removeFromParentViewController()
    }
    
    //MARK: - Private
    
    private func setupUI() {
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        view.addGestureRecognizer(panGestureRecognizer)
        view.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    //MARK: - Private Objc
    
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let originFrame = view.frame
        var origin = gestureRecognizer.translation(in: self.view.window)
        origin.x += lastTouchDownLocation.x
        origin.y += lastTouchDownLocation.y
        
        view.move(to: origin, stayIn: allowedFrame)
        lastStoredTouchDownLocation = view.frame.origin
        
        checkIfChangedAndNotify(originFrame)
    }
    
    @objc private func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.numberOfTouches == 2 else {
            return
        }
        let originFrame = view.frame
        let firstTouchLocation = gestureRecognizer.location(ofTouch: 0, in: view.window)
        let secondTouchLocation = gestureRecognizer.location(ofTouch: 1, in: view.window)
        
        view.resize(between: firstTouchLocation, and: secondTouchLocation, minSize: minViewSize)
        lastStoredTouchDownLocation = view.frame.origin
        
        view.move(
            to: topLeft(between: firstTouchLocation, and: secondTouchLocation),
            stayIn: allowedFrame
        )
        
        checkIfChangedAndNotify(originFrame)
    }
    
    private func checkIfChangedAndNotify(_ originFrame: CGRect) {
        if !originFrame.equalTo(view.frame)  {
            transformDelegate?.transformableNavigationController(self, didTransform: view.frame)
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
