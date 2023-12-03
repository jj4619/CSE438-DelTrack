//
//  ViewController.swift
//  delTrack
//
//  Created by  Harish Gundluru on 11/5/23.
//

import UIKit
import CoreLocation
import MapKit


class LocationListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var locationList: UITableView!
    
    var currentUserLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    func setupTableView() {
        locationList.dataSource = self
        locationList.delegate = self
        
        locationList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    var data: [(String, CLLocationCoordinate2D)] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in cell for row at")
        let stopLocation = data[indexPath.row].1
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        print(data[indexPath.row].0)
        let distance = distanceFromUser(location: stopLocation, userLocation: self.currentUserLocation)
        let distanceInMiles = convertMetersToMiles(distance)
        cell.textLabel!.text = "\(data[indexPath.row].0) ---  distance: \(distanceInMiles) miles"
        cell.textLabel!.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for cells
        return 100 // Set the cell height to 100 points (adjust as needed)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = data[indexPath.row].0
        let PIVC =  PointsOfInterestAndFunFactsViewController()
        PIVC.currStation = name
        navigationController?.pushViewController(PIVC, animated: true)
        }
    
    func distanceFromUser(location: CLLocationCoordinate2D, userLocation: CLLocationCoordinate2D) -> CLLocationDistance{
        let stop = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let user = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let distance = stop.distance(from: user)
        
        return distance
    }
    
    func convertMetersToMiles(_ meters: Double) -> String {
        let metersInMile: Double = 1609.34
        let miles = meters / metersInMile
        return String(format: "%.3f", miles)
    }

    override func viewDidLoad() {
        
        print("here")
        // In your second view controller
        let startCoordinate = CLLocationCoordinate2D(latitude: 38.65645984858235, longitude: -90.30939421438708)

        let endCoordinate = CLLocationCoordinate2D(latitude: 38.64459084809981, longitude: -90.28553694655461)
        
        let library = ("U City Library", startCoordinate)
        data.append(library)
        
        let leland = ("Leland Avenue", CLLocationCoordinate2D(latitude: 38.65605564618364, longitude: -90.30623521554129))
        
        data.append(leland)
        
        let cityLimit = ("City Limit", CLLocationCoordinate2D(latitude: 38.655651910833804, longitude: -90.30211149360002))
        
        data.append(cityLimit)

        
        let pagent = ("The Pageant", CLLocationCoordinate2D(latitude: 38.65523190023507, longitude: -90.29781572206996))
        
        data.append(pagent)

        
        let delmarMetrolink = ("Delmar Loop MetroLink", CLLocationCoordinate2D(latitude: 38.65490577353374, longitude: -90.29433934663338))
        
        data.append(delmarMetrolink)

        
        let hamilton = ("Hamilton Ave", CLLocationCoordinate2D(latitude: 38.654494153272225, longitude: -90.28992378668875))
        
        data.append(hamilton)

        
        let debalivere = ("Delmar and Debalivier", CLLocationCoordinate2D(latitude: 38.65365433867583, longitude: -90.2843154654276))
        
        data.append(debalivere)

        
        
        let crossroads = ("Crossroads School", CLLocationCoordinate2D(latitude: 38.6517550975623, longitude: -90.28463086479292))
        
        data.append(crossroads)

        
        let forestParkMetrolink = ("Forest Park/Debaliviere MetroLink", CLLocationCoordinate2D(latitude: 38.64845356617568, longitude: -90.28524578097503))
        
        data.append(forestParkMetrolink)

        
        let historyMuseum = ("Missouri History Museum / Forest Park", endCoordinate)
            
        data.append(historyMuseum)
        
        setupTableView()
        if let storedLocation = UserDefaults.standard.array(forKey: "currentLoc") as? [Double], storedLocation.count == 2 {
            let latitude = storedLocation[0]
            let longitude = storedLocation[1]
      
            self.currentUserLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            locationList.reloadData()

        } else {
           
        }
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let storedLocation = UserDefaults.standard.array(forKey: "currentLoc") as? [Double], storedLocation.count == 2 {
            let latitude = storedLocation[0]
            let longitude = storedLocation[1]
      
            self.currentUserLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            locationList.reloadData()

        } else {
           
        }
    }

}

