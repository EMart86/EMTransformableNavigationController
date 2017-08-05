//
//  UIView+TransformExtension.swift
//  Pods
//
//  Created by Martin Eberl on 05.08.17.
//
//

import UIKit

extension UIView {
    func resize(between firstTouchLocation: CGPoint, and secondTouchLocation: CGPoint, minSize: CGSize? = nil) {
        var contentSize = size(between: firstTouchLocation, and: secondTouchLocation)
        if let minSize = minSize {
            contentSize.width = max(contentSize.width, minSize.width)
            contentSize.height = max(contentSize.height, minSize.height)
        }
        self.size = contentSize
    }
    
    func move(to newOrigin: CGPoint, stayIn allowedFrame: CGRect?) {
        guard let allowedFrame = allowedFrame else {
            self.origin = newOrigin
            return
        }
        self.origin = position(for: newOrigin, stayIn: allowedFrame)
    }
    
    //MARK: - Private
    
    private var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return frame.size
        }
    }
    
    private var origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return frame.origin
        }
    }
    
    private var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return frame.width
        }
    }
    
    private var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return frame.height
        }
    }
    
    private func position(for newOrigin: CGPoint, stayIn rect: CGRect) -> CGPoint {
        let width = frame.width
        let height = frame.height
        var correctedPosition = newOrigin
    
        if correctedPosition.x + width > rect.maxX {
            correctedPosition.x = rect.maxX - width;
        } else if correctedPosition.x < 0 {
            correctedPosition.x = 0
        }
    
        if correctedPosition.y + height > rect.maxY {
            correctedPosition.y = rect.maxY - height
        } else if correctedPosition.y < 0 {
            correctedPosition.y = 0
        }
    
        return correctedPosition
    }
}
