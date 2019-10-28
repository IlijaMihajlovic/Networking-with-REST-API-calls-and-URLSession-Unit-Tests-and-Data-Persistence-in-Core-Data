//
//  MapController.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 9/12/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit
import MapKit

final class MapController: UIViewController {
    
    fileprivate var mapView: MKMapView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        checkJSONDataGeoDataForPossibleErrors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(true, animated: animated)
     }
    
    //MARK: - Custom Functions
    fileprivate func checkJSONDataGeoDataForPossibleErrors() {
        guard let urlString = URL(string: urlToApi) else { return }
        
        Networking.shared.fetchJSON(url: urlString) {(result) in
            
            switch result {
            case .success(let jsonData):
                jsonData.forEach({ (data) in
                  
                    guard let Latitude = Double(data.address.geo.lat) else { return }
                    guard let Longitude = Double(data.address.geo.lng) else { return }
                    
                    let location = CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude)
                    let pin = JSONGeoModelData(title: data.username, coordinate: location, subtitle: data.address.city)
                    
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(pin)
                    }
                    
                })
                
            case .failure(let err):
                print("Failed:", err)
            }
        }
    }
    
   fileprivate func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        view.addSubview(mapView)
        mapView.frame = view.frame
    
}

}








