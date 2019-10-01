//
//  JSONGeoModelData.swift
//  DarwinDigital
//
//  Created by Ilija Mihajlovic on 9/13/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation
import MapKit

class JSONGeoModelData: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    let index: Int?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String, index: Int? = nil) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
        self.index = index
        super.init()
    
       
    }
    
}

