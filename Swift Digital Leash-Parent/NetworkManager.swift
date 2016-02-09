//
//  NetworkManager.swift
//  Swift Digital Leash-Parent
//
//  Created by Chris on 1/13/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import Foundation

class NetworkManager {
    
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

    
}