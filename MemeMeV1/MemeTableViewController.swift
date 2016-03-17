//
//  MemeTableViewController.swift
//  MemeMeV1
//
//  Created by Jacqueline Sloves on 3/11/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes : [Meme]! {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate =  object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView!.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = (meme.textTop + " ... " + meme.textBottom)
        cell.imageView?.image = meme.image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        detailVC.meme = self.memes[indexPath.row]
        
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
}
