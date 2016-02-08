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
    let locationServices = LocationServices()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        usernameField.delegate = self
        radiusField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        locationServices.checkAuthorizationStatus(handleDeniedAuthorizationStatus)
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
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse:
            locationServices.locationManager.requestLocation()
        default:
            locationServices.checkAuthorizationStatus(handleDeniedAuthorizationStatus)
        }
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
    
    func sendUserData() {
        
        let URL = NSURL(string: "http://protected-wildwood-8664.herokuapp.com/users")
        let request = NSMutableURLRequest(URL: URL!)
        //        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //        let session = NSURLSession.sharedSession()
        
        let userDetails: [String: String] = ["username":usernameField.text!,"latitude":"\(locationServices.currentLocation!.coordinate.latitude)", "longitude":"\(locationServices.currentLocation!.coordinate.longitude)", "radius":radiusField.text!]
        print(userDetails)
        
        let dictToSend = ["utf8": "✓", "authenticity_token":"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", "user":userDetails, "commit":"Create User", "action":"update", "controller":"users"]
        
        if NSJSONSerialization.isValidJSONObject(dictToSend) {
            do {
                let JSONData = try NSJSONSerialization.dataWithJSONObject(dictToSend, options: NSJSONWritingOptions.PrettyPrinted)
                
                request.HTTPMethod = "POST"
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
                request.HTTPBody = JSONData
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                    if error != nil{
                        print("Error -> \(error)")
                        return
                    } else {
                        print("success?")
                    }
                }
                
                task.resume()
                
                
            } catch {
                print("There was a problem serializing:\(error)")
            }
            
        } else {
            print("Invalid JSON object")
            
        }
        
    }
    
    func handleDeniedAuthorizationStatus() {
        let alert = UIAlertController.init(
            title: "Swift Leash is not authorized to use your location.",
            message: "Please change the app's permissions in your Settings.",
            preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
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
    
    @IBAction func textFieldChanged(sender: AnyObject) {
        /// Set up Bools to keep track of whether the text fields are empty or not and the current state of button
        let radiusFieldContainsText = self.radiusField.text != ""
        let usernameFieldContainsText = self.usernameField.text != ""
        let bothFieldsContainText = radiusFieldContainsText && usernameFieldContainsText
        let curentSubmitButtonState: Bool = self.submitButton.enabled
        
        /// submitButton.enabled should always equal to bothFieldsContainText.
        /// We animate the submit state change only when necessary
        if curentSubmitButtonState != bothFieldsContainText {
            UIView.transitionWithView (
                self.submitButton,
                duration: 0.3,
                options: UIViewAnimationOptions.TransitionCrossDissolve,
                animations: { () -> Void in
                    self.submitButton.enabled = bothFieldsContainText },
                completion: nil)
        }
    }
}

