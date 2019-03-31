//
//  ViewController.swift
//  Hydrants
//
//  Created by MJC-iCloud on 3/30/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet var hydrantMap: MKMapView!
    
    var myHydrantStore: HydrantStore?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        hydrantMap!.delegate = self
    }

    @IBAction func addHydrantUpdate(_ sender: Any) {
        centerMapOnUserLocation()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            hydrantMap.showsUserLocation = true
            locationManager!.startUpdatingLocation()
        } else {
            print("Location not permitted for app - TODO show dialog to user.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error)")
    }
    
    func centerMapOnUserLocation() {
        if let location = locationManager!.location {
            hydrantMap.setCenter(location.coordinate, animated: true)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
            hydrantMap.setRegion(region, animated: true)
        } else {
            print("No location available")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerMapOnUserLocation()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        
        let alertController = UIAlertController(title: "Enter Comments", message: nil, preferredStyle: .alert)
        
        alertController.addTextField {
            textField in textField.placeholder = "Add optional comment"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let comment = alertController.textFields!.first!.text
            let hydrantUpdate = HydrantUpdate(coordinate: (self.locationManager?.location?.coordinate)!, comment: comment)
            self.myHydrantStore!.addHydrantUpdate(newUpdate: hydrantUpdate, newImage: image)
            let annotation = HydrantAnnotation(hydrant: hydrantUpdate)
            annotation.coordinate = hydrantUpdate.coordinate
            self.hydrantMap.addAnnotation(annotation)
            
            self.centerMapOnUserLocation()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

