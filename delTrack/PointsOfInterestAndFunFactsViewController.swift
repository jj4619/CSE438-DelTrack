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
    
    
    let pointsOfInterest = ["U City Library" : ["Church of Scientology", "Seoul Taco", "U-City Grill"],
                            "Leland Avenue" : ["Fitz's", "Blueberry Hill", "Vintage Vinyl"],
                            "City Limit" : ["Peacock Diner", "Three Kings Public House", "American Falafel"],
                            "The Pageant" : ["Magic Mini Golf", "Trolley Cafe", "Delmar Hall"],
                            "Delmar Loop MetroLink" : ["St. Louis Artworks", "Vails Brothers Shrimp, Chicken, and Fish", "Prime 55 Restaurant & Lounge"],
                            "Hamilton Ave" : ["Krab Kingz Seafood", "Palomino Lounge", "Streetstylez Boutique"],
                            "Delmar and Debaliviere" : ["Deli Divine", "Swiish Cigar Lounge", "Eklectic Design"],
                            "Crossroads School" : ["Crossroads College Preparatory School", "Kingsbury Square Park", "St. Louis Fire Department Engine House No. 30"],
                            "Forest Park/Debaliviere MetroLink" : ["Ocean Grill STL", "Taco Love", "Shakespeare Company-St Louis"],
                            "Missouri History Museum/Forest Park" : ["Boathouse at Forest Park", "The Muny", "Saint Louis Art Museum"]]
    
    
    //2 fun facts
    let funFacts = ["U City Library" : ["The Delmar Loop has its name from an old streetcar turnaround ", "The two lion statues were made by George Julian Zolnay"],
                    "Leland Avenue" : ["Near this stop is a statue of Chuck Berry, the \"Father of Rock and Roll\"", "Fitz's Root Beer is made according to an original recipe from 1947"],
                    "City Limit" : ["Many WashU students live right by this stop in the Lofts", "According to the pub, the Three Kings are Kong, Elvis, and Henry VIII"],
                    "The Pageant" : ["The Pageant was named after an old movie theater three blocks away", "The Moonrise Hotel is home to the award winning Eclipse Restaurant"],
                    "Delmar Loop MetroLink" : ["The MetroLink can be taken all the way to the St. Louis Airport", "Festive lights are strung throughout the loop for the holiday season"],
                    "Hamilton Ave" : ["The Trolley Cars are parked in a facility near this stop", "St. Louis was founded by French fur traders in 1764"],
                    "Delmar and Debaliviere" : ["This neighborhood was designated a local historict district in 1978", "St. Louis was the starting point of the Lewis and Clark Expedition in 1804"],
                    "Crossroads School" : ["The Crossroads School was founded in 1974 by Arthur and Carol Lieber", "St. Louis was the first U.S. city to host the modern Olympics"],
                    "Forest Park/Debaliviere MetroLink" : ["The MetroLink opened July 31, 1993", "St. Louis was the fourth largest city in the U.S. in the 1800s"],
                    "Missouri History Museum/Forest Park" : ["Forest Park first opened in 1876", "Forest Park hosted the World's Fair in 1904"]]
    
    var currStation : String?
    
    override func viewDidLoad() {
        //TODO: Put the real current station here once the pusing of this VC is figured out with a segue
        let header = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        header.isEditable = false
        header.text = currStation
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 23.0)
        tableView.tableHeaderView = header
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currStation != nil){
            print(currStation!)
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
        let text = UITextView()
        text.adjustsFontForContentSizeCategory = true
        text.font = UIFont(name: "Avenir", size: 11.5)
        if indexPath.section == sections["pointsofinterest"] {
            text.text = pointsOfInterest[currStation!]![indexPath.row]
        }else if indexPath.section == sections["funfacts"]{
            text.text = funFacts[currStation!]![indexPath.row]
        }else{
            text.text = "There was an error"
        }
        text.sizeToFit()
        text.layoutIfNeeded()
        cell.addSubview(text)
        cell.selectionStyle = .none
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
