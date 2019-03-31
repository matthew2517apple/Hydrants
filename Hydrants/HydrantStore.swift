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
    
    var myHydrantUpdates: [HydrantUpdate] = []
    var myImageStore: ImageStore
    
    let hydrantArchiveURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let firstDocDirectory = documentsDirectory.first!
        return firstDocDirectory.appendingPathComponent("hydrants.archive")
    }()
    
    init() {
        myImageStore = ImageStore()
        
        do {
            let data = try Data(contentsOf: hydrantArchiveURL)
            let archivedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [HydrantUpdate]
            myHydrantUpdates = archivedItems!
        } catch {
            print("Error unarchiving: \(error)")
        }
    }
    
    func archiveChanges() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: myHydrantUpdates, requiringSecureCoding: false)
            try data.write(to: hydrantArchiveURL)
            print("Archived items to: \(hydrantArchiveURL)")
        } catch {
            print("Error archiving items: \(error)")
        }
    }
    
    func addHydrantUpdate(newUpdate: HydrantUpdate, newImage: UIImage) {
        myHydrantUpdates.append(newUpdate)
        myImageStore.setImage(newImage, forKey: newUpdate.imageKey)
        archiveChanges()
    }
    
    func getImage(key: String) -> UIImage? {
        return myImageStore.image(forKey: key)
    }
}
