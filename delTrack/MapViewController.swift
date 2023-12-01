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
    func locationFunction() -> Array<Any>{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
//        double CurrentTime = CACurrentMediaTime();
        let ct = CACurrentMediaTime().truncatingRemainder(dividingBy: 1)
//        print(ct)
//        var seconds = Double(seconds_whole) + ct
//        let seconds_double = Double(seconds) + ct
        print("asd")
        print(seconds)
        
        let stop_time = 30
//        let stop_time_double = Double(stop_time)
        
        print(minutes)
//        print(type(of: minutes))
        print(seconds)
        
        let universityCityLibraryLatitude = 38.65645984858235
        let universityCityLibraryLongitude = -90.30939421438708

        let lelandLatitude = 38.65605564618364
        let lelandLongitude = -90.30623521554129

        let cityLimitLatitude = 38.655651910833804
        let cityLimitLongitude = -90.30211149360002

        let thePatentLatitude = 38.65523190023507
        let thePatentLongitude = -90.29781572206996

        let delmarMetrolinkLatitude = 38.65490577353374
        let delmarMetrolinkLongitude = -90.29433934663338

        let hamiltonAvenueLatitude = 38.654494153272225
        let hamiltonAvenueLongitude = -90.28992378668875

        let cornerLatitude = 38.653930979731
        let cornerLongitude = -90.28433903658895
        
        let delmarAndDebalivereLatitude = 38.65365433867583
        let delmarAndDebalivereLongitude = -90.2843154654276

        let crossroadsCollegePrepLatitude = 38.6517550975623
        let crossroadsCollegePrepLongitude = -90.28463086479292

        let forestParkDebaliviereMetrolinkLatitude = 38.64845356617568
        let forestParkDebaliviereMetrolinkLongitude = -90.28524578097503

        let missouriHistoryMuseumLatitude = 38.64459084809981
        let missouriHistoryMuseumLongitude = -90.28553694655461
        
        var location = [0.0,0.0]
        
        
        
        if ((minutes < 20 && minutes >= 10) || (minutes == 20 && seconds <= stop_time)){
            //at start
            location = [universityCityLibraryLatitude, universityCityLibraryLongitude]
        }
        if (minutes == 20 && seconds > stop_time){
//            latitude = lelandLatitude + (universityCityLibraryLatitude-lelandLatitude)*seconds/60
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-21)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            print(seconds_ratio)
            location = [universityCityLibraryLatitude + (lelandLatitude-universityCityLibraryLatitude)*Double(seconds-stop_time)*Double(seconds_ratio), universityCityLibraryLongitude + (lelandLongitude-universityCityLibraryLongitude)*Double(seconds-stop_time)*Double(seconds_ratio)]
        }
        if (minutes == 21 && seconds <= stop_time){
            location = [lelandLatitude,lelandLongitude]
            
        }
        
        if ((minutes == 21 && seconds > stop_time) || minutes == 22){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-21)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            print(seconds_ratio)
            location = [lelandLatitude + (cityLimitLatitude-lelandLatitude)*Double(seconds_ratio), lelandLongitude + (cityLimitLongitude-lelandLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 23 && seconds <= stop_time){
            location = [cityLimitLatitude,cityLimitLongitude]
        }
        if ((minutes == 23 && seconds > stop_time) || minutes == 24){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-23)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            print(seconds_ratio)
            location = [cityLimitLatitude + (thePatentLatitude-cityLimitLatitude)*Double(seconds_ratio), cityLimitLongitude + (thePatentLongitude-cityLimitLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 25 && seconds <= stop_time){
            location = [thePatentLatitude,thePatentLongitude]
        }
        if ((minutes == 25 && seconds > stop_time) || minutes == 26){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-25)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [thePatentLatitude + (delmarMetrolinkLatitude-thePatentLatitude)*Double(seconds_ratio), thePatentLongitude + (delmarMetrolinkLongitude-thePatentLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 27 && seconds <= stop_time){
            location = [delmarMetrolinkLatitude,delmarMetrolinkLongitude]
        }
        if ((minutes == 27 && seconds > stop_time) || minutes == 28 || minutes == 29){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-27)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(180-stop_time)
            location = [delmarMetrolinkLatitude + (hamiltonAvenueLatitude-delmarMetrolinkLatitude)*Double(seconds_ratio), delmarMetrolinkLongitude + (hamiltonAvenueLongitude-delmarMetrolinkLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 30 && seconds <= stop_time){
            location = [hamiltonAvenueLatitude,hamiltonAvenueLongitude]
        }
        
        if ((minutes == 30 && seconds > stop_time) || minutes == 31 || (minutes == 32 && seconds < 40)){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-30)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(160-stop_time)
            location = [hamiltonAvenueLatitude + (cornerLatitude-hamiltonAvenueLatitude)*Double(seconds_ratio), hamiltonAvenueLongitude + (cornerLongitude-hamiltonAvenueLongitude)*Double(seconds_ratio)]
        }
        if ((minutes == 32 && seconds >= 40)){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-32)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(20-stop_time)
            location = [cornerLatitude + (delmarAndDebalivereLatitude-cornerLatitude)*Double(seconds_ratio), cornerLongitude + (delmarAndDebalivereLongitude-cornerLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 33 && seconds <= stop_time){
            location = [delmarAndDebalivereLatitude,delmarAndDebalivereLongitude]
        }
        if ((minutes == 33 && seconds > stop_time)){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-33)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(60-stop_time)
            location = [delmarAndDebalivereLatitude + (crossroadsCollegePrepLatitude-delmarAndDebalivereLatitude)*Double(seconds_ratio), delmarAndDebalivereLongitude + (crossroadsCollegePrepLongitude-delmarAndDebalivereLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 34 && seconds <= stop_time){
            location = [crossroadsCollegePrepLatitude,crossroadsCollegePrepLongitude]
        }
        if ((minutes == 34 && seconds > stop_time) || minutes == 35){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-34)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [crossroadsCollegePrepLatitude + (forestParkDebaliviereMetrolinkLatitude-crossroadsCollegePrepLatitude)*Double(seconds_ratio), crossroadsCollegePrepLongitude + (forestParkDebaliviereMetrolinkLongitude-crossroadsCollegePrepLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 36 && seconds <= stop_time){
            location = [forestParkDebaliviereMetrolinkLatitude,crossroadsCollegePrepLongitude]
        }
        if ((minutes == 36 && seconds > stop_time) || minutes == 37 || minutes == 38 || minutes == 39){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-36)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(240-stop_time)
            var curve_adjustment_enter = 0.0
            if (seconds_delay >= Double(120-stop_time)){
                curve_adjustment_enter = 0.0007789382754*sin(acos(seconds_delay / -60.0 + 1)) * pow(sin(acos(seconds_delay / -60.0 + 1)/2),1.5)
            }
//            print(curve_adjustment)
            location = [forestParkDebaliviereMetrolinkLatitude + (missouriHistoryMuseumLatitude-forestParkDebaliviereMetrolinkLatitude)*Double(seconds_ratio), crossroadsCollegePrepLongitude + (missouriHistoryMuseumLongitude-crossroadsCollegePrepLongitude)*Double(seconds_ratio)+curve_adjustment_enter]
        }
        if ((minutes >= 40 && minutes <= 49) || (minutes == 50 && seconds > stop_time)){
            location = [missouriHistoryMuseumLatitude,missouriHistoryMuseumLongitude]
        }
        if ((minutes == 50 && seconds > stop_time) || minutes == 51 || minutes == 52){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-50)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(180-stop_time)
            var curve_adjustment_enter = 0.0
            print(seconds_delay)
            if (seconds_delay >= Double(120-stop_time)){
                curve_adjustment_enter = 0.0007789382754*sin(acos(seconds_delay / 60.0 - 1)) * pow(sin(acos(seconds_delay / 60.0 - 1)/2),1.5)
            }
            else{
                curve_adjustment_enter = 0.0
            }
            print(curve_adjustment_enter)
            location = [missouriHistoryMuseumLatitude + (forestParkDebaliviereMetrolinkLatitude-missouriHistoryMuseumLatitude)*Double(seconds_ratio), missouriHistoryMuseumLongitude + (forestParkDebaliviereMetrolinkLongitude-missouriHistoryMuseumLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 53 && seconds <= stop_time){
            location = [forestParkDebaliviereMetrolinkLatitude,forestParkDebaliviereMetrolinkLongitude]
        }
        if ((minutes == 53 && seconds > stop_time) || minutes == 54){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-53)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [forestParkDebaliviereMetrolinkLatitude + (crossroadsCollegePrepLatitude-forestParkDebaliviereMetrolinkLatitude)*Double(seconds_ratio), forestParkDebaliviereMetrolinkLongitude + (crossroadsCollegePrepLongitude-forestParkDebaliviereMetrolinkLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 55 && seconds <= stop_time){
            location = [crossroadsCollegePrepLatitude,crossroadsCollegePrepLongitude]
        }
        if ((minutes == 55 && seconds > stop_time)){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-55)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(60-stop_time)
            location = [crossroadsCollegePrepLatitude + (delmarAndDebalivereLatitude-crossroadsCollegePrepLatitude)*Double(seconds_ratio), crossroadsCollegePrepLongitude + (delmarAndDebalivereLongitude-crossroadsCollegePrepLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 56 && seconds <= stop_time){
            location = [delmarAndDebalivereLatitude,delmarAndDebalivereLongitude]
        }
        if ((minutes == 56 && seconds > stop_time && seconds <= (stop_time + 20))){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-56)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(20)
//            print("hi")
//            print(seconds_delay)
//            print(seconds_ratio)
            location = [delmarAndDebalivereLatitude + (hamiltonAvenueLatitude-delmarAndDebalivereLatitude)*Double(seconds_ratio), delmarAndDebalivereLongitude + (hamiltonAvenueLongitude-delmarAndDebalivereLongitude)*Double(seconds_ratio)]
        }
        if ((minutes == 56 && seconds > (stop_time+20)) || minutes == 57 || minutes == 58 || minutes == 59){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-56)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(220-stop_time)
//            print("hi")
//            print(seconds_delay)
//            print(seconds_ratio)
            location = [delmarAndDebalivereLatitude + (hamiltonAvenueLatitude-delmarAndDebalivereLatitude)*Double(seconds_ratio), delmarAndDebalivereLongitude + (hamiltonAvenueLongitude-delmarAndDebalivereLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 0 && seconds <= stop_time){
            location = [hamiltonAvenueLatitude,hamiltonAvenueLongitude]
        }
        if ((minutes == 0 && seconds > stop_time) || minutes == 1){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [hamiltonAvenueLatitude + (delmarMetrolinkLatitude-hamiltonAvenueLatitude)*Double(seconds_ratio), hamiltonAvenueLongitude + (delmarMetrolinkLongitude-hamiltonAvenueLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 2 && seconds <= stop_time){
            location = [delmarMetrolinkLatitude,delmarMetrolinkLongitude]
        }
        if ((minutes == 2 && seconds > stop_time) || minutes == 3){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-2)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [delmarMetrolinkLatitude + (thePatentLatitude-delmarMetrolinkLatitude)*Double(seconds_ratio), delmarMetrolinkLongitude + (thePatentLongitude-delmarMetrolinkLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 4 && seconds <= stop_time){
            location = [thePatentLatitude,thePatentLatitude]
        }
        if ((minutes == 4 && seconds > stop_time) || minutes == 5){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-4)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [thePatentLatitude + (cityLimitLatitude-thePatentLatitude)*Double(seconds_ratio), thePatentLongitude + (cityLimitLongitude-thePatentLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 6 && seconds <= stop_time){
            location = [cityLimitLatitude,cityLimitLongitude]
        }
        if ((minutes == 6 && seconds > stop_time) || minutes == 7){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-6)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [cityLimitLatitude + (lelandLatitude-cityLimitLatitude)*Double(seconds_ratio), cityLimitLongitude + (lelandLongitude-cityLimitLongitude)*Double(seconds_ratio)]
        }
        if (minutes == 8 && seconds <= stop_time){
            location = [lelandLatitude,lelandLongitude]
        }
        if ((minutes == 8 && seconds > stop_time) || minutes == 9){
            let seconds_late = Double(seconds)+ct-Double(stop_time)
            let seconds_delay = Double(Double((minutes-8)*60)+seconds_late)
            let seconds_ratio = seconds_delay/Double(120-stop_time)
            location = [lelandLatitude + (universityCityLibraryLatitude-lelandLatitude)*Double(seconds_ratio), lelandLongitude + (universityCityLibraryLongitude-lelandLongitude)*Double(seconds_ratio)]
        }
        
        if(hour > 7 && hour < 11){
            location = []
        }
//        print(seconds_ratio)
        print(location)
        return location
    }
}

