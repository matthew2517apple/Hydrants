//
//  HydrantStore.swift
//  Hydrants
//
//  Created by MJC-iCloud on 3/30/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation
import MapKit

class HydrantStore {
    
    var myHdrantUpdates: [HydrantUpdate] = []
    var myImageStore: ImageStore
    
    init() {
        myImageStore = ImageStore()
    }
    
    func addHydrantUpdate(newUpdate: HydrantUpdate, newImage: UIImage) {
        myHdrantUpdates.append(newUpdate)
        myImageStore.setImage(newImage, forKey: newUpdate.imageKey)
    }
    
    func getImage(key: String) -> UIImage? {
        return myImageStore.image(forKey: key)
    }
}
