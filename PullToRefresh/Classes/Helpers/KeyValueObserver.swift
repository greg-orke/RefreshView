//
//  KeyValueObserver.swift
//  PullToRefresh
//
//  Created by Gregor Kerstein on 21/05/16.
//  Copyright © 2016 Gregor Kerstein. All rights reserved.
//

import UIKit

class KeyValueObserver: NSObject {
    
    typealias Callback = () -> Void
    
    private static var context = 0
    
    private weak var object: NSObject?
    private let keyPath: String
    private let callback: Callback
    
    init(object: NSObject, keyPath: String, callback: Callback) {
        self.keyPath = keyPath
        self.callback = callback
        
        super.init()
        
        object.addObserver(self, forKeyPath: keyPath, options: [], context: &KeyValueObserver.context)
    }
    
    deinit {
        object?.removeObserver(self, forKeyPath: keyPath)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &KeyValueObserver.context {
            callback()
        }
    }
    
}
