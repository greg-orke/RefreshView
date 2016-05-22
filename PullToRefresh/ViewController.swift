//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Gregor Kerstein on 21/05/16.
//  Copyright © 2016 Gregor Kerstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshView: RefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshView = RefreshView(scrollView: tableView)
    }
    
    // MARK: -
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        cell.textLabel?.text = "Item \(indexPath.row)"
        
        return cell
    }
    
}
