//
//  Meme.swift
//  MemeMeV1
//
//  Created by Jacqueline Sloves on 3/10/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var textTop : String
    var textBottom : String
    var image : UIImage
    var memedImage : UIImage

    init(textTop: String, textBottom: String, image: UIImage, memedImage: UIImage) {
        self.textTop = textTop
        self.textBottom = textBottom
        self.image = image
        self.memedImage = memedImage
    }
    
}

extension Meme {

    static var allMemes: [Meme] {
        var memeArray = [Meme]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memeArray += appDelegate.memes
        return memeArray
    }

}


