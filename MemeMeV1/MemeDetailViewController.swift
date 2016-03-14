//
//  MemeDetailViewController.swift
//  MemeMeV1
//
//  Created by Jacqueline Sloves on 3/11/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var textTop: UILabel!
    @IBOutlet weak var textBottom: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let labelTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -4.0
        ]
        let attribTopText = NSMutableAttributedString(string: self.meme.textTop, attributes: labelTextAttributes)
        let attribBottomText =  NSMutableAttributedString(string: self.meme.textBottom, attributes: labelTextAttributes)
        
        self.textTop?.attributedText = attribTopText
        self.textBottom?.attributedText =  attribBottomText
        self.image.image = self.meme.image
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }

    @IBAction func editMeme(sender: UIBarButtonItem!) {
    
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let editMemeVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        //TODO: fix crash
        editMemeVC.textFieldTop.text = meme.textTop
        editMemeVC.textFieldBottom.text = meme.textBottom
        editMemeVC.imagePickerView.image = meme.image
        editMemeVC.editingMeme = true
        
        self.navigationController?.presentViewController(editMemeVC, animated: true, completion: nil)
    }
    
}
