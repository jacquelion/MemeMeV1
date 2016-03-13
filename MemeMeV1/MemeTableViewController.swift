//
//  MemeTableViewController.swift
//  MemeMeV1
//
//  Created by Jacqueline Sloves on 3/11/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes : [Meme]!
    var allMemes = Meme.allMemes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("allMemes TableiewController", allMemes)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView!.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allMemes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        let meme = self.allMemes[indexPath.row]
        
        cell.textLabel?.text = meme.textTop
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC =
        self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailVC.meme = self.allMemes[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
}
