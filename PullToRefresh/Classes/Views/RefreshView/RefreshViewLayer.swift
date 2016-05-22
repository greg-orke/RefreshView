//
//  RefreshViewLayer.swift
//  PullToRefresh
//
//  Created by Gregor Kerstein on 22/05/16.
//  Copyright © 2016 Gregor Kerstein. All rights reserved.
//

import UIKit

class RefreshViewLayer: CAShapeLayer {
    
    var progress: CGFloat = 0.0
    
    override class func needsDisplayForKey(key: String) -> Bool {
        if key == "progress" {
            return true
        }
        
        return super.needsDisplayForKey(key)
    }
    
    override init(layer: AnyObject) {
        let otherLayer = layer as! RefreshViewLayer
        self.progress = otherLayer.progress
        
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.contentsScale = UIScreen.mainScreen().scale
    }
    
    override func actionForKey(event: String) -> CAAction? {
        if event == "progress" {
            let animation = CABasicAnimation(keyPath: event)
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.fromValue = presentationLayer()!.progress
            return animation
        }
        
        return super.actionForKey(event)
    }
    
    override func display() {
        let progress = presentationLayer()?.progress ?? self.progress
        path = pathForProgress(progress)
    }
    
    func pathForProgress(progress: CGFloat) -> CGPath {
        return CGPathCreateWithRect(bounds, nil)
    }
    
}
