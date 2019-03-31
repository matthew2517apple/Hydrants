//
//  HydrantUpdate.swift
//  Hydrants
//
//  Created by MJC-iCloud on 3/30/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation
import MapKit

class HydrantUpdate {
    
    let coordinate: CLLocationCoordinate2D
    let imageKey: String
    let date: Date
    var comment: String?
    
    init(coordinate: CLLocationCoordinate2D, comment: String?) {
        self.coordinate = coordinate
        self.imageKey = UUID().uuidString
        self.date = Date()
        self.comment = comment
    }
}
