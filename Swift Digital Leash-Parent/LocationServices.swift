//
//  LocationManager.swift
//  Swift Digital Leash-Parent
//
//  Created by Chris on 1/12/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServices: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        
        //        if CLLocationManager.authorizationStatus() == .NotDetermined {
        //            locationManager.requestWhenInUseAuthorization()
        //        }
        
        
        //        self.locationManager.distanceFilter = 500
        //        self.locationManager.delegate = self
        
        //self.locationManager.requestLocation()
        
        //CLLocationManager.significantLocationChangeMonitoringAvailable()
        
        //self.locationManager .startMonitoringSignificantLocationChanges()
    }
    
    
    
    //    func configureDesiredAccuracy(trackingRadius: Int) -> CLLocationAccuracy {
    //
    //        //        switch radius {
    //        //        case 1..<100:
    //        //            return kCLLocationAccuracyBest
    //        //        case 100..<1000:
    //        //            return kCLLocationAccuracyNearestTenMeters
    //        //        case 1000..<10000:
    //        //            return kCLLocationAccuracyHundredMeters
    //        //        default:
    //        //            return kCLLocationAccuracyKilometer
    //        //        }
    //
    //    }
    
    func checkAuthorizationStatus(errorHandler: () -> Void) {
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .AuthorizedWhenInUse:
            locationManager.delegate = self
            locationManager.distanceFilter = 500
        case .Denied, .Restricted:
            errorHandler()
        default:
            print(CLLocationManager.authorizationStatus())
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("did change auth status")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location changed: \(locations)")
        currentLocation = locations[0]
        //        delegate.sendUserDetails
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("did fail with error: \(error.localizedDescription)")
    }
    
}

// TODO: trigger sendUserDetails