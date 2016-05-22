//
//  RefreshViewDropletLayer.swift
//  PullToRefresh
//
//  Created by Gregor Kerstein on 22/05/16.
//  Copyright © 2016 Gregor Kerstein. All rights reserved.
//

import UIKit

class RefreshViewDropletLayer: RefreshViewLayer {
    
    private let radius: CGFloat = 20.0
    private let totalHeight: CGFloat = 80.0
    
    override func pathForProgress(progress: CGFloat) -> CGPath {
        let height: CGFloat = progress * totalHeight
        let hHalf: CGFloat = bounds.width * 0.5
        let top = bounds.height - height
        let bottomMin = bounds.height - height + radius * 8
        let bottomMax = bounds.height - height + radius * 2
        let bottom = bottomMin + (bottomMax - bottomMin) * progress
        let c: CGFloat = 0.55191502449
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: hHalf - radius, y: top + radius))
        path.addCurveToPoint(CGPoint(x: hHalf, y: top), controlPoint1: CGPoint(x: hHalf - radius, y: top + radius * (1 - c)), controlPoint2: CGPoint(x: hHalf - radius * c, y: top))
        path.addCurveToPoint(CGPoint(x: hHalf + radius, y: top + radius), controlPoint1: CGPoint(x: hHalf + radius * c, y: top), controlPoint2: CGPoint(x: hHalf + radius, y: top + radius * (1 - c)))
        path.addCurveToPoint(CGPoint(x: hHalf, y: bottom), controlPoint1: CGPoint(x: hHalf + radius, y: top + radius * (1 + c)), controlPoint2: CGPoint(x: hHalf + radius * c * progress, y: bottom))
        path.addCurveToPoint(CGPoint(x: hHalf - radius, y: top + radius), controlPoint1: CGPoint(x: hHalf - radius * c * progress, y: bottom), controlPoint2: CGPoint(x: hHalf - radius, y: top + radius * (1 + c)))
        
        return path.CGPath
    }
    
}
