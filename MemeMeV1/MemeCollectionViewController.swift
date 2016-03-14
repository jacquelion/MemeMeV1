//
//  MemeCollectionViewController.swift
//  MemeMeV1
//
//  Created by Jacqueline Sloves on 3/11/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController : UICollectionViewController {
    
    
    var memes: [Meme]! {
            let object = UIApplication.sharedApplication().delegate
            let appDelegate =  object as! AppDelegate
            return appDelegate.memes
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        
        let labelTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 10)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        let attribTopText = NSAttributedString(string: meme.textTop, attributes: labelTextAttributes)
        let attribBottomText =  NSAttributedString(string: meme.textBottom, attributes: labelTextAttributes) 
        
        cell.textTop?.attributedText = attribTopText
        cell.textBottom?.attributedText =  attribBottomText
        cell.image.image = meme.image

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        detailVC.meme = self.memes[indexPath.row]
        
        navigationController!.pushViewController(detailVC, animated: true)
        
    }
}