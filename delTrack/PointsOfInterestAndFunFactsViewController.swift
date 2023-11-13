//
//  PointsOfInterestAndFunFactsViewController.swift
//  delTrack
//
//  Created by Maxwell Schiffer on 11/10/23.
//

import Foundation
import UIKit

class PointsOfInterestAndFunFactsViewController : UITableViewController {
    
    
    let sections = ["pointsofinterest" : 0, "funfacts" : 1]
    
    let pointsOfInterest = ["U City Library" : ["Church of Scientology", "Point 2"],
                            "Leland Avenue" : ["Fitz's", "Point 2"],
                            "City Limit" : ["Peacock Diner", "Point 2"],
                            "The Pageant" : ["Magic Mini Golf", "Point 2"],
                            "Delmar Loop MetroLink" : ["St. Louis Artworks", "Point 2"],
                            "Hamilton Ave" : ["Krab Kingz Seafood", "Point 2"],
                            "Delmar and Debaliviere" : ["St. Louis Fire Department Engine House No. 30", "Point 2"],
                            "Crossroads School" : ["Crossroads College Preparatory School", "Point 2"],
                            "Forest Park/Debaliviere MetroLink" : ["Ocean Grill STL", "Point 2"],
                            "Missouri History Museum/Forest Park" : ["Boathouse at Forest Park", "Point 2"]]
    
    let funFacts = ["U City Library" : ["The Delmar Loop was named for a streetcar turnaround that used to be near where this stop is", "Fact 2"],
                    "Leland Avenue" : ["Near this stop is a statue of Chuck Berry, the \"Father of Rock and Roll\"", "Fact 2"],
                    "City Limit" : ["Many Washington University in St. Louis students live right by this stop in the Lofts", "Fact 2"],
                    "The Pageant" : ["The Pageant was named after a movie theater that once stood three blocks away", "Fact 2"],
                    "Delmar Loop MetroLink" : ["The MetroLink can be taken all the way to the St. Louis Airport", "Fact 2"],
                    "Hamilton Ave" : ["The Trolley Cars are parked in a facility near this stop", "Fact 2"],
                    "Delmar and Debaliviere" : ["The Skinker-Debaliviere neighborhood was designated a local historict district by the city of St. Louis in 1978", "Fact 2"],
                    "Crossroads School" : ["The Crossroads School was founded in 1974 by Arthur and Carol Lieber", "Fact 2"],
                    "Forest Park/Debaliviere MetroLink" : ["The MetroLink opened July 31, 1993", "Fact 2"],
                    "Missouri History Museum/Forest Park" : ["Forest Park first opened in 1876", "Fact 2"]]
    
    var currStation : String?
    
    override func viewDidLoad() {
        //TODO: Put the real current station here once the pusing of this VC is figured out with a segue
        let header = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        header.text = currStation
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 30.0)
        tableView.tableHeaderView = header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currStation != nil){
            if(section == sections["pointsofinterest"]){
                return pointsOfInterest[currStation!]!.count
            }else if(section == sections["funfacts"]){
                return funFacts[currStation!]!.count
            }
        }
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if indexPath.section == sections["pointsofinterest"] {
            cell.textLabel?.text = pointsOfInterest[currStation!]![indexPath.row]
        }else if indexPath.section == sections["funfacts"]{
            cell.textLabel?.text = funFacts[currStation!]![indexPath.row]
        }else{
            cell.textLabel?.text = "There was an error"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == sections["pointsofinterest"]){
            return "Points of Interest"
        }
        if(section == sections["funfacts"]){
            return "Fun Facts"
        }
        return "There was an error with this header"
    }
    
    
    

    
}
