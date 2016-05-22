//
//  RefreshViewLayer.swift
//  PullToRefresh
//
//  Created by Gregor Kerstein on 22/05/16.
//  Copyright © 2016 Gregor Kerstein. All rights reserved.
//

import UIKit

class RefreshViewWaveLayer: RefreshViewLayer {
    
    private var presentationRefreshLayer: RefreshViewLayer? {
        return presentationLayer() as? RefreshViewLayer
    }
    
    override func pathForProgress(progress: CGFloat) -> CGPath {
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: 0.0, y: bounds.size.height))
        path.addLineToPoint(CGPoint(x: 0.0, y: 0.0))
        path.addLineToPoint(CGPoint(x: bounds.size.width, y: 0.0))
        path.addLineToPoint(CGPoint(x: bounds.size.width, y: bounds.size.height))
        
        if progress > 1.0 {
            path.addCurveToPoint(CGPoint(x: 0.0, y: bounds.size.height), controlPoint1: CGPoint(x: bounds.size.width * 0.7, y: bounds.size.height * progress), controlPoint2: CGPoint(x: bounds.size.width * 0.3, y: bounds.size.height * progress))
        } else {
            let hHalf = bounds.width * 0.5
            let dropletWidth: CGFloat = 50.0
            let summit = bounds.height * progress
            
            path.addCurveToPoint(CGPoint(x: hHalf, y: summit), controlPoint1: CGPoint(x: hHalf, y: bounds.height), controlPoint2: CGPoint(x: hHalf + dropletWidth * 0.6, y: summit))
            path.addCurveToPoint(CGPoint(x: 0.0, y: bounds.height), controlPoint1: CGPoint(x: hHalf - dropletWidth * 0.6, y: summit), controlPoint2: CGPoint(x: hHalf, y: bounds.height))
        }
        
        return path.CGPath
    }
    
}
