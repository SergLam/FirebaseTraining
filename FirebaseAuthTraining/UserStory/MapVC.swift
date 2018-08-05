//
//  MapVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/5/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.hideNavBar(false)
    }
    
    func configureUI(){
        self.hideNavBar(true)
        configureMap()
    }
    
    func configureMap(){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.zoomGestures = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
}

