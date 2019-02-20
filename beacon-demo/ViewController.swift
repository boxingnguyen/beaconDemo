//
//  ViewController.swift
//  beacon-demo
//
//  Created by Quyen Anh on 11/22/18.
//  Copyright © 2018 Quyen Anh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
//    3b3574cf-8594-4529-ae0c-95d445c2445f
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "3b3574cf-8594-4529-ae0c-95d445c2445f")! as UUID, identifier: "ibeacon")
    let colors = [
        456: UIColor.blue,
        99: UIColor.green
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
    }

//    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//        let knownBeacons = beacons.filter { $0.proximity != CLProximity.unknown }
//            if (knownBeacons.count > 0) {
//                let closestBeacon = knownBeacons[0] as CLBeacon
//                self.view.backgroundColor = self.colors[Int(truncating: closestBeacon.minor)]
//            }
//    }
    
    func rangeBeacons() {
        let uuid = UUID(uuidString: "3b3574cf-8594-4529-ae0c-95d445c2445f")!
        let major:CLBeaconMajorValue = 123
        let minor:CLBeaconMinorValue = 456
        let identifier = "ibeacon"
//        let region = CLBeaconRegion(proximityUUID: <#T##UUID#>, identifier: <#T##String#>)
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
        locationManager.startRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // User has authorized the appplication - range those beacons!
            rangeBeacons()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let discoveredBeaconProximity = beacons.first?.proximity else { print("Couldn't find the beacon!"); return}
        let backgroundColor:UIColor = {
            switch discoveredBeaconProximity {
            case .immediate: return UIColor.green
            case .near: return UIColor.orange
            case .far: return UIColor.red
            case .unknown:return UIColor.black
            }
        }()
        
        view.backgroundColor = backgroundColor 
    }
}

/*
 home 
 */
