//
//  RefreshView.swift
//  PullToRefresh
//
//  Created by Gregor Kerstein on 21/05/16.
//  Copyright © 2016 Gregor Kerstein. All rights reserved.
//

import UIKit

class RefreshView: UIView {
    
    enum State {
        case UnderThreshold
        case OverThreshold
        case Refreshing
    }
    
    override class func layerClass() -> AnyClass {
        return RefreshViewWaveLayer.self
    }
    
    private var contentOffsetObserver: KeyValueObserver!
    
    private weak var scrollView: UIScrollView?
    
    private var state: State = .UnderThreshold
    
    private var refreshLayer: RefreshViewLayer {
        return self.layer as! RefreshViewLayer
    }
    
    private let dropletLayer = RefreshViewDropletLayer()
    
    init(scrollView: UIScrollView) {
        let height: CGFloat = 120
        self.scrollView = scrollView
        
        super.init(frame: CGRect(x: 0, y: -height, width: scrollView.frame.width, height: height))
        
        autoresizingMask = .FlexibleWidth
        
        scrollView.addSubview(self)
        
        refreshLayer.fillColor = UIColor(red: 120.0/255.0, green: 125.0/255.0, blue: 161.0/255.0, alpha: 1.0).CGColor
        
        dropletLayer.fillColor = UIColor.whiteColor().CGColor
        dropletLayer.masksToBounds = true
        layer.addSublayer(dropletLayer)
        
        contentOffsetObserver = KeyValueObserver(object: scrollView, keyPath: "contentOffset", callback: contentOffsetChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dropletLayer.frame = bounds
        dropletLayer.setNeedsDisplay()
    }
    
    func reset() {
        state = .UnderThreshold
        refreshLayer.progress = 0
        refreshLayer.setNeedsDisplay()
        dropletLayer.progress = 0
        dropletLayer.setNeedsDisplay()
        
        if let scrollView = self.scrollView {
            UIView.animateWithDuration(0.2) {
                scrollView.contentOffset.y = 0.0
                scrollView.contentInset.top -= self.bounds.height
            }
        }
    }
    
    // MARK: -
    
    func contentOffsetChanged() {
        guard let scrollView = self.scrollView else {
            return
        }
        
        let progress = ((scrollView.contentOffset.y + scrollView.contentInset.top) / frame.height) * -1
        
        if !scrollView.dragging && progress > 1.0 && state != .Refreshing {
            state = .Refreshing
            
            UIView.animateWithDuration(0.2, animations: {
                scrollView.contentOffset.y = self.bounds.height + scrollView.contentInset.top
                scrollView.contentInset.top += self.bounds.height
            })
            
            refreshLayer.progress = 1.0
            let refresh = CABasicAnimation(keyPath: "progress")
            refresh.fromValue = progress
            refresh.toValue = 0.6
            refresh.duration = 0.3
            refresh.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            refreshLayer.addAnimation(refresh, forKey: nil)
            
            let refreshWave = CAKeyframeAnimation(keyPath: "progress")
            refreshWave.beginTime = CACurrentMediaTime() + refresh.duration
            refreshWave.values = [0.6, 0.8, 0.9, 1.0, 1.1, 1.0, 0.97, 1.0, 1.03, 1.0]
            refreshWave.duration = 1.0
            refreshLayer.addAnimation(refreshWave, forKey: nil)
            
            dropletLayer.progress = 1.0
            let droplet = CABasicAnimation(keyPath: "progress")
            droplet.beginTime = CACurrentMediaTime() + 0.15
            droplet.fromValue = 0.1
            droplet.toValue = 1.0
            droplet.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            droplet.duration = 0.4
            dropletLayer.addAnimation(droplet, forKey: nil)
            
            
            
            
            
            // TODO: temporary, reset after 3 seconds
            NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(reset), userInfo: nil, repeats: false)
            
            
            
            
        } else if state != .Refreshing {
            refreshLayer.progress = progress > 1.0 ? progress : 1.0
            refreshLayer.setNeedsDisplay()
        }
    }
    
}
