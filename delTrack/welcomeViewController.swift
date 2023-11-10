//
//  welcomeViewController.swift
//  delTrack
//
//  Created by  Monish Kumar on 11/8/23.
// reference Todd Sproull's In Class Demo

import UIKit
import CoreLocation

class welcomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func getStartedAction(_ sender: Any) {
        performSegue(withIdentifier: "mainApp", sender: self)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let someLocation = locations[0]
        print("A single location is \(someLocation)")
        
        let howRecent = someLocation.timestamp.timeIntervalSinceNow
        
        if (howRecent < -10) { return }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set([someLocation.coordinate.latitude, someLocation.coordinate.longitude], forKey: "currentLoc")
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
