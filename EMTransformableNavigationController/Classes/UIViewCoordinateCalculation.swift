//
//  MathExtension.swift
//  Pods
//
//  Created by Martin Eberl on 05.08.17.
//
//

import Foundation

extension NSObject {
    func topLeft(between firstTouchLocation: CGPoint, and secondTouchLocation: CGPoint) -> CGPoint {
        return CGPoint(x: min(firstTouchLocation.x, secondTouchLocation.x),
                       y: min(firstTouchLocation.y, secondTouchLocation.y))
    }
    
    func bottomRight(between firstTouchLocation: CGPoint, and secondTouchLocation: CGPoint) -> CGPoint {
        return CGPoint(x: max(firstTouchLocation.x, secondTouchLocation.x),
                       y: max(firstTouchLocation.y, secondTouchLocation.y))
    }
    
    func size(between firstTouchLocation: CGPoint, and secondTouchLocation: CGPoint) -> CGSize {
        let topLeftOrigin = topLeft(between: firstTouchLocation, and: secondTouchLocation)
        let bottomRightOrigin = bottomRight(between: firstTouchLocation, and: secondTouchLocation)
        return CGSize(width: bottomRightOrigin.x - topLeftOrigin.x,
                      height: bottomRightOrigin.y - topLeftOrigin.y)
    }
}
