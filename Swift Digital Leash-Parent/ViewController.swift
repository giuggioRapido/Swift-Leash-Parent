//
//  ViewController.swift
//  Swift Digital Leash-Parent
//
//  Created by Chris on 1/12/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var radiusField: UITextField!
    
    var defaultFrame: CGRect = CGRectMake(0, 0, 0, 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.defaultFrame = self.view.frame
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func submit(sender: AnyObject) {
        
    }
    
    
    
    
    // MARK: Keyboard management
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame = CGRectMake(0, 0 - keyboardSize.height, self.view.frame.size.width, self.view.frame.size.height)
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.frame = self.defaultFrame
        })
    }
}

// MARK: UITextFieldDelegate extension
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        return true
    }
    
}


