//
//  GoogleMapsEvents.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 9/9/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

extension MapVC: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastlocation: CLLocation = locations.last else {
            print("Can't get user last location!")
            return
        }
        self.currentLocation = lastlocation
        print("Location: \(lastlocation)")
        
        let camera = GMSCameraPosition.camera(
            withLatitude: lastlocation.coordinate.latitude,
            longitude: lastlocation.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
