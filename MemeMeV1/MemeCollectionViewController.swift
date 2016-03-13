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
    
    
    var memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    var allMemes = Meme.allMemes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("allMemes CollectionViewController", allMemes)
        print("memes", memes)
        //let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //memes = applicationDelegate.memes
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Data is being reloaded")
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("memes count: ", memes.count)
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        cell.textTop.text = meme.textTop
        cell.textBottom.text =  meme.textBottom
        //let imageView = UIImageView(image: meme.image)
        cell.image.image = meme.image
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        detailVC.meme = self.memes[indexPath.row]
        
        navigationController!.pushViewController(detailVC, animated: true)
        
    }
}