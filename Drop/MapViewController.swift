//
//  MapViewController.swift
//  Drop
//
//  Created by Mike Mallow on 4/23/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {


    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        
        let publix = CLLocationCoordinate2DMake(33.8103, -84.4154)
        
        let pAnnotation = MKPointAnnotation()
        pAnnotation.coordinate = publix
        pAnnotation.title = "Report #: 745"
        pAnnotation.subtitle = "Type: Bottle   Condition: Potable"
        
        let stream = CLLocationCoordinate2DMake(33.8147, -84.4844)
        
        let sAnnotation = MKPointAnnotation()
        sAnnotation.coordinate = stream
        sAnnotation.title = "Report #: 634"
        sAnnotation.subtitle = "Type: Steam   Condition: Treatable-clear"
        
        map.addAnnotation(pAnnotation)
        map.addAnnotation(sAnnotation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: location delegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.2, 0.2))
        
        self.map.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors " + error.localizedDescription)
    }
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
