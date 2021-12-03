//
//  LocationViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/21.
//  Copyright © 2020 Thapelo. All rights reserved.
//


import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, MKMapViewDelegate {
    
    var searchResults = [String]()
    var searchResultsTwo = [String]()
    
    var resultSearchController:UISearchController? = nil
    
    let searchContainer: UIView = {
           
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = UIColor.init(red: 37/255, green: 118/255, blue: 188/255, alpha: 1)
           
           
           
           return view
       }()
       
       let searchValue: UITextField = {
           
           let textField = UITextField()
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.placeholder = "  Search Location"
           textField.backgroundColor = .white
           textField.layer.masksToBounds = true
           textField.layer.cornerRadius = 8
           
                  
           
           
           return textField
           
       }()
       
       let logoImage: UIImageView = {
           
           let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.image = UIImage(named: "logo")
           
           
           
           return img
       }()
       
    
    lazy var searchCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LocationSearchCell.self, forCellWithReuseIdentifier: "SearchId")
        cv.backgroundColor = .clear
        cv.alpha = 0
        
        
        return cv
        
        
    }()
    
    lazy var map: MKMapView = {
        
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        
        return map
    }()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // view.addSubview(searchContainer)
        //      searchContainer.addSubview(searchValue)
       //       searchContainer.addSubview(logoImage)
        view.addSubview(searchCV)
        view.addSubview(map)
        
        searchCV.dataSource = self
               searchCV.delegate = self
        
        map.delegate = self
        map.showsUserLocation = true
        
        //let layout = UICollectionViewLayout()
        
        let locationSearchTable = LocationTableViewController()
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backF))
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = map
        

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        map.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        map.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
                  let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                     let region = MKCoordinateRegion(center: location.coordinate, span: span)
                     map.setRegion(region, animated: true)
                 }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error:: \(error)")
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = searchCV.dequeueReusableCell(withReuseIdentifier: "SearchId", for: indexPath) as! LocationSearchCell
        
        cell.searchValue.text = searchResults[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 6, height: 35)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
}


