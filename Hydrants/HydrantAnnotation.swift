//
//  HydrantAnnotation.swift
//  Hydrants
//
//  Created by MJC-iCloud on 3/30/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation
import MapKit

class HydrantAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    let hydrant: HydrantUpdate
    
    // Computed property:
    var title: String? {
        return "\(dateFormatter.string(from: hydrant.date)). \(hydrant.comment ?? "")"
    }
    
    init(hydrant: HydrantUpdate) {
        self.coordinate = hydrant.coordinate
        self.hydrant = hydrant
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}
