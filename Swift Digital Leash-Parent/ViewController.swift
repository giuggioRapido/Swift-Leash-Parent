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
    
    // MARK: - Properties -
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var radiusField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var submitButton: UIButton!
    weak var activeField: UITextField?
    var usernameFieldContainsText: Bool = false
    var radiusFieldContainsText: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        radiusField.delegate = self
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("textFieldDidChange:"), name: "UITextFieldTextDidChangeNotification", object: nil)
        
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func submit(sender: AnyObject) {
        
    }
    
    // MARK: - Keyboard management
    func keyboardWillShow(notification: NSNotification) {
        
        if let activeField = self.activeField, keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            if (!CGRectContainsPoint(aRect, activeField.frame.origin)) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let contentInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
}


// MARK: - UITextFieldDelegate and related methods -
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(notification: NSNotification) {
        
        let bothFieldsContainText: Bool = self.radiusField.text != "" && self.usernameField.text != ""
        
        func updateSubmitButtonState() {
            let curentState: Bool = self.submitButton.enabled
            if curentState != bothFieldsContainText {
                UIView.transitionWithView(
                    self.submitButton,
                    duration: 0.3,
                    options: UIViewAnimationOptions.TransitionCrossDissolve,
                    animations: { () -> Void in
                        self.submitButton.enabled = bothFieldsContainText },
                    completion: nil)
            }
        }
        
        updateSubmitButtonState()
    }
    
    
}



