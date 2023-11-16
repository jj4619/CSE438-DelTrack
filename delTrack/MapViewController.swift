//
//  MapViewController.swift
//  delTrack
//
//  Created by Michael Wexler on 11/9/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        let centerCoordinate = CLLocationCoordinate2D(latitude: 38.655526, longitude: -90.298798)
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        let startCoordinate = CLLocationCoordinate2D(latitude: 38.65645984858235, longitude: -90.30939421438708)
        let middleCoordinate = CLLocationCoordinate2D(latitude: 38.653928, longitude: -90.284663)
        let endCoordinate = CLLocationCoordinate2D(latitude: 38.64459084809981, longitude: -90.28553694655461)
        
        let library = MKPointAnnotation()
        library.coordinate = startCoordinate
        library.title = "U City Library"
        mapView.addAnnotation(library)
        
        let leland = MKPointAnnotation()
        leland.coordinate = CLLocationCoordinate2D(latitude: 38.65605564618364, longitude: -90.30623521554129)
        leland.title = "Leland Avenue"
        mapView.addAnnotation(leland)
        
        let cityLimit = MKPointAnnotation()
        cityLimit.coordinate = CLLocationCoordinate2D(latitude: 38.655651910833804, longitude: -90.30211149360002)
        cityLimit.title = "City Limit"
        mapView.addAnnotation(cityLimit)
        
        let pagent = MKPointAnnotation()
        pagent.coordinate = CLLocationCoordinate2D(latitude: 38.65523190023507, longitude: -90.29781572206996)
        pagent.title = "The Pageant"
        mapView.addAnnotation(pagent)
        
        let delmarMetrolink = MKPointAnnotation()
        delmarMetrolink.coordinate = CLLocationCoordinate2D(latitude: 38.65490577353374, longitude: -90.29433934663338)
        delmarMetrolink.title = "Delmar Loop MetroLink"
        mapView.addAnnotation(delmarMetrolink)
        
        let hamilton = MKPointAnnotation()
        hamilton.coordinate = CLLocationCoordinate2D(latitude: 38.654494153272225, longitude: -90.28992378668875)
        hamilton.title = "Hamilton Ave"
        mapView.addAnnotation(hamilton)
        
        let debalivere = MKPointAnnotation()
        debalivere.coordinate = CLLocationCoordinate2D(latitude: 38.65365433867583, longitude: -90.2843154654276)
        debalivere.title = "Delmar and Debaliviere"
        mapView.addAnnotation(debalivere)
        
        let crossroads = MKPointAnnotation()
        crossroads.coordinate = CLLocationCoordinate2D(latitude: 38.6517550975623, longitude: -90.28463086479292)
        crossroads.title = "Crossroads School"
        mapView.addAnnotation(crossroads)
        
        let forestParkMetrolink = MKPointAnnotation()
        forestParkMetrolink.coordinate = CLLocationCoordinate2D(latitude: 38.64845356617568, longitude: -90.28524578097503)
        forestParkMetrolink.title = "Forest Park/Debaliviere MetroLink"
        mapView.addAnnotation(forestParkMetrolink)
        
        let historyMuseum = MKPointAnnotation()
        historyMuseum.coordinate = endCoordinate
        historyMuseum.title = "Missouri History Museum/Forest Park"
        mapView.addAnnotation(historyMuseum)
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: middleCoordinate))
        directionsRequest.transportType = .walking
        var directions = MKDirections(request: directionsRequest)
        directions.calculate { (response, error) in
        if let route = response?.routes.first {
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
            
        }
       // Researched at: https://stackoverflow.com/questions/23104337/ios-mkdirections-for-multiple-destinations-and-a-single-source
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: middleCoordinate))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoordinate))
        directionsRequest.transportType = .walking
        directions = MKDirections(request: directionsRequest)
        directions.calculate { (response, error) in
            let route = response?.routes.first
            self.mapView.addOverlay(route!.polyline, level: .aboveRoads)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(overlay: polyline)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    
    //source: https://stackoverflow.com/questions/51591670/how-to-identify-when-a-annotation-is-pressed-which-one-it-is
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let PIVC =  PointsOfInterestAndFunFactsViewController()
        PIVC.currStation = view.annotation?.title ?? "U City Library"
        navigationController?.pushViewController(PIVC, animated: true)
    }
}

