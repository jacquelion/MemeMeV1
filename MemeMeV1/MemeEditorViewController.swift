//
//  MemeEditorViewController.swift
//  MemeMeV1
//
//  Created by Jacqueline Sloves on 3/4/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var buttonCamera: UIBarButtonItem!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var buttonShareMeme: UIBarButtonItem!
    @IBOutlet weak var buttonCancel: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var editingMeme = false
    var topTextField: String!
    var bottomTextField: String!
    var image: UIImage!
    
    let imagePicker = UIImagePickerController()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -4.0
    ]
    
    func textFieldSetup(textField: UITextField!){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        buttonCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        buttonShareMeme.enabled = false
        
        //set top text field attributes
        textFieldTop.placeholder = "TOP"
        textFieldSetup(textFieldTop)
        
        //set bottom text field attributes
        textFieldBottom.placeholder = "BOTTOM"
        textFieldSetup(textFieldBottom)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //Subscribe to keyboard notifications to allow the view to raise when necessary
        subscribeToKeyboardNotifications()
        
        tabBarController?.tabBar.hidden = true;
        
        if (editingMeme == true) {
            textFieldTop.text = self.topTextField
            textFieldBottom.text = self.bottomTextField
            imagePickerView.image = self.image
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //Insert Code re Editing
        textField.backgroundColor = UIColor.whiteColor()

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //Insert Code after Text Field is Done editing
        textField.backgroundColor = UIColor.clearColor()
        buttonShareMeme.enabled = true

    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if textFieldTop.isFirstResponder() { return }
        if textFieldBottom.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: Image Picker (via PhotoLibrary or Camera)
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .ScaleAspectFit
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: NavBar Controller
    
    @IBAction func cancelAddMeme(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
        tabBarController?.tabBar.hidden = false

    }
    
    //MARK: Save Meme
    
    func save() {
        let meme = Meme(textTop: textFieldTop.text!, textBottom: textFieldBottom.text!, image: imagePickerView.image!, memedImage: generateMemedImage())
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        textFieldBottom.text = ""
        textFieldTop.text = ""
        imagePickerView.image = nil
    }
    
    func generateMemedImage() -> UIImage {
        navigationController?.navigationBarHidden = true
        navigationController?.toolbarHidden = true
        tabBarController?.tabBar.hidden = true
        toolbar.hidden = true
    
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        print(self.view.frame)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
        toolbar.hidden = false

        return memedImage
    }
    
    //MARK: Share Meme
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        let myMeme = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [myMeme], applicationActivities: [])
        
        vc.completionWithItemsHandler = {
                activity, completed, items, error in
            if completed {
                self.save()
                self.navigationController!.popViewControllerAnimated(true)
            }
        }
        presentViewController(vc, animated: true, completion: nil)
    }
}


