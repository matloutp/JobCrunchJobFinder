//
//  LocationTableViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/21.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import Loaf

class LocationTableViewController: UITableViewController {
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    
    var lats = [CLLocationDegrees]()
    var longs = [CLLocationDegrees]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        getUserInfo()
        
    }
    
    var uniqueId: String!
    
    @objc func getUserInfo(){
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            self.uniqueId = user.uid
            
        }
    }

    func parseAddress(selectedItem:MKPlacemark) -> String {
          // put a space between "4" and "Melrose Place"
          let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
          // put a comma between street and city/state
          let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
          // put a space between "Washington" and "DC"
          let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
          let addressLine = String(
              format:"%@%@%@%@%@%@%@",
              // street number
              selectedItem.subThoroughfare ?? "",
              firstSpace,
              // street name
              selectedItem.thoroughfare ?? "",
              comma,
              // city
              selectedItem.locality ?? "",
              secondSpace,
              // state
            selectedItem.country ?? ""
          )
          return addressLine
      }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: "cell")

        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        print(parseAddress(selectedItem: selectedItem))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vC = PickProfileImageViewController()
        
        /*vC.locationLbl.text = matchingItems[indexPath.row].name
        vC.callWeather(lat: matchingItems[indexPath.row].placemark.coordinate.latitude, long: matchingItems[indexPath.row].placemark.coordinate.longitude)*/
        
        vC.modalPresentationStyle = .fullScreen
        
        UserDefaults.standard.set(matchingItems[indexPath.row].placemark.name! + parseAddress(selectedItem: matchingItems[indexPath.row].placemark), forKey: "savedLocation")
        
        print(parseAddress(selectedItem: matchingItems[indexPath.row].placemark))
        
        let itemReviewRef = Database.database().reference().child("users").child(self.uniqueId)
        
        let values = ["location": parseAddress(selectedItem: matchingItems[indexPath.row].placemark), "profileImageUrl": "https://firebasestorage.googleapis.com/v0/b/job-crunch.appspot.com/o/jc%20logoss%2FNew%20Project%20-%202020-11-24T160934.059.png?alt=media&token=3dfc973b-fa27-4160-9e20-6bf4fdd8b7f7"]
        
        itemReviewRef.updateChildValues(values) {(error, reference) in
            
            if error != nil {
                
                
                Loaf("Error saving location. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
            
            }else {
                
                let vC = HomeViewController()
                vC.modalPresentationStyle = .fullScreen
                
                self.present(vC, animated: true, completion: nil)
            
            }
        
        }
        
        //present(vC, animated: true, completion: nil)
    }
    
  

}

extension LocationTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
          request.naturalLanguageQuery = searchBarText
          request.region = mapView.region
          let search = MKLocalSearch(request: request)
        search.start { response, _ in
              guard let response = response else {
                  return
              }
              self.matchingItems = response.mapItems
              self.tableView.reloadData()
          }
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
          request.naturalLanguageQuery = searchBarText
          request.region = mapView.region
          let search = MKLocalSearch(request: request)
        search.start { response, _ in
              guard let response = response else {
                  return
              }
              self.matchingItems = response.mapItems
              self.tableView.reloadData()
          }
    }
    
    
}
