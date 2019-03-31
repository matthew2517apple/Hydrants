//
//  HydrantUpdate.swift
//  Hydrants
//
//  Created by MJC-iCloud on 3/30/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation
import MapKit

class HydrantUpdate: NSObject, NSCoding {
    
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(coordinate.latitude, forKey: "coordinate-latitude")
        aCoder.encode(coordinate.longitude, forKey: "coordinate-longitude")
        aCoder.encode(imageKey, forKey: "imageKey")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(comment, forKey: "comment")
    }
    
    required init?(coder aDecoder: NSCoder) {
        let latitude = aDecoder.decodeDouble(forKey: "coordinate-latitude")
        let longitude = aDecoder.decodeDouble(forKey: "coordinate-longitude")
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        imageKey = aDecoder.decodeObject(forKey: "imageKey") as! String
        date = aDecoder.decodeObject(forKey: "date") as! Date
        comment = aDecoder.decodeObject(forKey: "comment") as? String
        
    }
}
