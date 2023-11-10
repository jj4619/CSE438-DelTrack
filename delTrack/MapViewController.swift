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
        let startCoordinate = CLLocationCoordinate2D(latitude: 38.656439, longitude: -90.309591)
        let middleCoordinate = CLLocationCoordinate2D(latitude: 38.655447, longitude: -90.300027)
                let endCoordinate = CLLocationCoordinate2D(latitude: 38.644670, longitude: -90.285348)

                let library = MKPointAnnotation()
                library.coordinate = startCoordinate
                library.title = "University City Library"
                mapView.addAnnotation(library)
        
                let directionsRequest = MKDirections.Request()
                directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate))
                directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: middleCoordinate))
                directionsRequest.transportType = .automobile
                var directions = MKDirections(request: directionsRequest)
                directions.calculate { (response, error) in
                    if let route = response?.routes.first {
                        self.mapView.addOverlay(route.polyline, level: .aboveRoads)

                    }
                
                }
       // Researched at: https://stackoverflow.com/questions/23104337/ios-mkdirections-for-multiple-destinations-and-a-single-source
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: middleCoordinate))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoordinate))
        directionsRequest.transportType = .automobile
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
}

