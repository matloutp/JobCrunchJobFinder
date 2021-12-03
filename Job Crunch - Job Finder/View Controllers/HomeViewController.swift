//
//  HomeViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import SPLarkController
import BubbleTransition
import Firebase
import NVActivityIndicatorView
import Loaf

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate {
    
    var isCandidate = true
    
    var filters = [String]()
    
    var jobType = ""
    
    var toSearch = ""
    
    var squareCompanyKeys = [String]()
    
    var squareJobTitles = [String]()
    var squareJobKeys = [String]()
    var squareJobTypes = [String]()
    var squareJobProfileImageUrls = [String]()
    var squareJobSalaries = [String]()
    
    var recentCompanyKeys = [String]()
    
    var recentJobTitles = [String]()
    var recentJobKeys = [String]()
    var recentJobTypes = [String]()
    var recentJobProfileImageUrls = [String]()
    var recentJobSalaries = [String]()
    var recentJobCompanyNames = [String]()
    
    var backgroundColors = [UIColor]()
    
    lazy var menuBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        btn.addTarget(self, action: #selector(menuF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var filterBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "filter")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(filterF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var searchBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(searchF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let searchedAndFilterView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        
        return vw
        
    }()
    
    let searchedJobValueLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        //lbl.text = "Designer \nJobs"
        lbl.text = "Find the World’s most \nAmazing Jobs"
        lbl.numberOfLines = 2
        
        lbl.font = .systemFont(ofSize: 45)
        
        return lbl
    }()
    
    lazy var filterCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()
    
    let forYouLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "For you"
        
        lbl.font = .boldSystemFont(ofSize: 21)
        
        lbl.textColor = .black
        
        return lbl
    }()
    
    lazy var squareJobsCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(SquareJobsCollectionViewCell.self, forCellWithReuseIdentifier: "SquareJobsId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()
    
    let recentlyLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Recently Posted"
        
        lbl.font = .boldSystemFont(ofSize: 21)
        
        lbl.textColor = .black
        
        return lbl
    }()
    
    lazy var recentlyPostedCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(RecentlyPostedCollectionViewCell.self, forCellWithReuseIdentifier: "RecentlyPostedId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()
    
    let welcomeLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.numberOfLines = 2
        
        

        let normalText = "Find the World’s most \n"
        let normalAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35)]
        let normalString = NSMutableAttributedString(string:normalText, attributes: normalAttrs)
        
        let boldText = "Amazing Job"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        normalString.append(attributedString)
        
        lbl.attributedText = normalString
        
        
        return lbl
    }()

    var loadingLoader: NVActivityIndicatorView = {
        
        let loader = NVActivityIndicatorView(frame: .zero)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.type = .ballScaleMultiple
        loader.tintColor = .black//UIColor.init(red: 255/255, green: 1/255, blue: 73/255, alpha: 1)
        loader.color = .black//UIColor.init(red: 255/255, green: 1/255, blue: 73/255, alpha: 1)
        
        loader.startAnimating()
        
        return loader
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    var heightAnchor: NSLayoutConstraint!
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(menuBtn)
        view.addSubview(filterBtn)
        view.addSubview(searchBtn)
        view.addSubview(forYouLbl)
        
        view.addSubview(searchedAndFilterView)
        searchedAndFilterView.addSubview(searchedJobValueLbl)
        searchedAndFilterView.addSubview(filterCV)
        
        view.addSubview(welcomeLbl)
        view.addSubview(squareJobsCV)
        
        view.addSubview(recentlyLbl)
        view.addSubview(recentlyPostedCV)
        
        view.addSubview(loadingLoader)
        
        filterCV.delegate = self
        filterCV.dataSource = self
        
        squareJobsCV.delegate = self
        squareJobsCV.dataSource = self
        
        recentlyPostedCV.delegate = self
        recentlyPostedCV.dataSource = self
        
        menuBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        menuBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        menuBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        
        filterBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        filterBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        filterBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        filterBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        
        searchBtn.rightAnchor.constraint(equalTo: filterBtn.leftAnchor, constant: -24).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        searchBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        
        searchedAndFilterView.rightAnchor.constraint(equalTo: filterBtn.rightAnchor, constant: 0).isActive = true
        heightAnchor = searchedAndFilterView.heightAnchor.constraint(equalToConstant: 135) //225
        heightAnchor.isActive = true
        searchedAndFilterView.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        searchedAndFilterView.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 24).isActive = true
        
        searchedAndFilterView.isHidden = true
        
        searchedJobValueLbl.rightAnchor.constraint(equalTo: searchedAndFilterView.rightAnchor, constant: 0).isActive = true
        searchedJobValueLbl.heightAnchor.constraint(equalToConstant: 145).isActive = true
        searchedJobValueLbl.leftAnchor.constraint(equalTo: searchedAndFilterView.leftAnchor, constant: 0).isActive = true
        searchedJobValueLbl.topAnchor.constraint(equalTo: searchedAndFilterView.topAnchor, constant: 0).isActive = true
        
        filterCV.rightAnchor.constraint(equalTo: searchedAndFilterView.rightAnchor, constant: 0).isActive = true
        filterCV.heightAnchor.constraint(equalToConstant: 65).isActive = true
        filterCV.leftAnchor.constraint(equalTo: searchedAndFilterView.leftAnchor, constant: 0).isActive = true
        filterCV.bottomAnchor.constraint(equalTo: searchedAndFilterView.bottomAnchor, constant: 0).isActive = true
        
        welcomeLbl.rightAnchor.constraint(equalTo: filterBtn.rightAnchor, constant: 0).isActive = true
        welcomeLbl.heightAnchor.constraint(equalToConstant: 145).isActive = true
        welcomeLbl.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        welcomeLbl.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 24).isActive = true
        
        forYouLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        forYouLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        forYouLbl.widthAnchor.constraint(equalToConstant: 75).isActive = true
        forYouLbl.topAnchor.constraint(equalTo: searchedAndFilterView.bottomAnchor, constant: 12).isActive = true
        
        squareJobsCV.rightAnchor.constraint(equalTo: searchedAndFilterView.rightAnchor, constant: 0).isActive = true
        squareJobsCV.heightAnchor.constraint(equalToConstant: 225).isActive = true
        squareJobsCV.leftAnchor.constraint(equalTo: searchedAndFilterView.leftAnchor, constant: 0).isActive = true
        squareJobsCV.topAnchor.constraint(equalTo: forYouLbl.bottomAnchor, constant: 12).isActive = true
        
        recentlyLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        recentlyLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        recentlyLbl.widthAnchor.constraint(equalToConstant: 225).isActive = true
        recentlyLbl.topAnchor.constraint(equalTo: squareJobsCV.bottomAnchor, constant: 32).isActive = true
        
        recentlyPostedCV.rightAnchor.constraint(equalTo: searchedAndFilterView.rightAnchor, constant: 0).isActive = true
        recentlyPostedCV.heightAnchor.constraint(equalToConstant: 325).isActive = true
        recentlyPostedCV.leftAnchor.constraint(equalTo: searchedAndFilterView.leftAnchor, constant: 0).isActive = true
        recentlyPostedCV.topAnchor.constraint(equalTo: recentlyLbl.bottomAnchor, constant: 12).isActive = true
        
        loadingLoader.centerYAnchor.constraint(equalTo: squareJobsCV.centerYAnchor, constant: 0).isActive = true
        loadingLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 45).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        if toSearch != "" {
            
            heightAnchor.constant = 225
            welcomeLbl.isHidden = true
            searchedJobValueLbl.text = toSearch
            searchedAndFilterView.isHidden = false
            
            callFirebaseSearch(toSearch: toSearch)
            callFirebaseRecentSearch(toSearch: toSearch)
            
        } else {

            fetchForYouJobs()
            fetchRecentJobs()
        }
        
        if jobType != "" {
            
            heightAnchor.constant = 225
            welcomeLbl.isHidden = true
            searchedJobValueLbl.text = toSearch
            searchedAndFilterView.isHidden = false
            
        }
        
        
        getUserInfo()
    }
    
    var uniqueId: String!
    
    @objc func getUserInfo(){
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            self.uniqueId = user.uid
            
            let userRef = Database.database().reference().child("users").child(self.uniqueId).child("info")
            
            userRef.observe(.value, with: {(snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    if let role = dict["role"] as? String {
                        
                        if role == "employee" {
                            
                            self.isCandidate = false
                            
                        }else {
                            
                            self.isCandidate = true
                            
                        }
                        
                    }
                    
                    
                }
                
            })
            
        }
    }
    
    
    ///
    var searchKeyResults = [String]()
    var recentSearchKeyResults = [String]()
    var toSearchBy = "jobTitle"
    

    func callFirebaseSearch(toSearch: String){
        
        let topProducts = Database.database().reference().child("jobs").queryOrdered(byChild: toSearchBy).queryStarting(atValue: toSearch).queryEnding(atValue: toSearch+"\u{f8ff}")//.queryLimited(toLast: 7)
        
        topProducts.observe(.childAdded) { (snapshotKey) in
            
            let key = snapshotKey.key
         
         var shouldAdd = false
         
         if self.searchKeyResults.contains(key) == false {
             
             shouldAdd = true
             
             self.searchKeyResults.append(key)
             
         }
         
            let itemReview = Database.database().reference().child("jobs").child(key)
            
            itemReview.observe(.value, with: {(snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    if self.jobType != "" {
                        
                        if let jT = dict["jobType"] as? String {
                            
                            if self.jobType == jT {
                                
                                //add
                                
                                if let jobTitle = dict["jobTitle"] as? String {
                                    
                                    
                                    
                                    self.squareJobTitles.append(jobTitle)
                                    
                                    if self.currentColor == UIColor.black {
                                        
                                        self.backgroundColors.append(.black)
                                        
                                        self.currentColor = UIColor.white
                                        
                                    }else {
                                        
                                        self.backgroundColors.append(.white)
                                        
                                        self.currentColor = UIColor.black
                                        
                                    }
                                    
                                }
                                
                                if let companyKey = dict["userId"] as? String {
                                    
                                    self.squareCompanyKeys.append(companyKey)
                                }
                                
                                if let jobType = dict["jobType"] as? String {
                                    
                                    self.squareJobTypes.append(jobType)
                                }
                                
                                if let jobSalary = dict["maxSalary"] as? String {
                                    
                                    self.squareJobSalaries.append(jobSalary)
                                }
                                
                                if let jobImage = dict["profileImageUrl"] as? String {
                                    
                                    self.squareJobProfileImageUrls.append(jobImage)
                                }
                                
                            }
                            
                        }
                        
                    }else {
                        
                        if let jobTitle = dict["jobTitle"] as? String {
                            
                            
                            
                            self.squareJobTitles.append(jobTitle)
                            
                            if self.currentColor == UIColor.black {
                                
                                self.backgroundColors.append(.black)
                                
                                self.currentColor = UIColor.white
                                
                            }else {
                                
                                self.backgroundColors.append(.white)
                                
                                self.currentColor = UIColor.black
                                
                            }
                            
                        }
                        
                        if let companyKey = dict["userId"] as? String {
                            
                            self.squareCompanyKeys.append(companyKey)
                        }
                        
                        if let jobType = dict["jobType"] as? String {
                            
                            self.squareJobTypes.append(jobType)
                        }
                        
                        if let jobSalary = dict["maxSalary"] as? String {
                            
                            self.squareJobSalaries.append(jobSalary)
                        }
                        
                        if let jobImage = dict["profileImageUrl"] as? String {
                            
                            self.squareJobProfileImageUrls.append(jobImage)
                        }
                        
                    }
                    
                    
                    
                }
                
            })
            

            self.attemptReloadofTable()
            self.loadingLoader.stopAnimating()
            
        }
        
    }
    
    func callFirebaseRecentSearch(toSearch: String){
        
        let topProducts = Database.database().reference().child("jobs").queryOrdered(byChild: toSearchBy).queryStarting(atValue: toSearch).queryEnding(atValue: toSearch+"\u{f8ff}")//.queryLimited(toLast: 75)
        
        topProducts.observe(.childAdded) { (snapshotKey) in
            
            let key = snapshotKey.key
            
            var shouldAdd = false
            
            if self.recentSearchKeyResults.contains(key) == false {
                
                shouldAdd = true
                
                self.recentSearchKeyResults.append(key)
            
            }
         
            let itemReview = Database.database().reference().child("jobs").child(key)
            
            itemReview.observe(.value, with: {(snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    if self.jobType != "" {
                        
                        if let jT = dict["jobType"] as? String {
                            
                            if self.jobType == jT {
                                
                                if let jobTitle = dict["jobTitle"] as? String {
                                    
                                    self.recentJobTitles.append(jobTitle)
                                    
                                    
                                    
                                    self.attemptReloadofRecentTable()
                                }
                                
                                if let companyKey = dict["userId"] as? String {
                                    
                                    self.recentCompanyKeys.append(companyKey)
                                }
                                
                                if let jobType = dict["jobType"] as? String {
                                    
                                    self.recentJobTypes.append(jobType)
                                }
                                
                                if let jobSalary = dict["maxSalary"] as? String {
                                    
                                    self.recentJobSalaries.append(jobSalary)
                                }
                                
                                if let jobImage = dict["profileImageUrl"] as? String {
                                    
                                    self.recentJobProfileImageUrls.append(jobImage)
                                }
                                
                                if let companyName = dict["employerName"] as? String {
                                    
                                    self.recentJobCompanyNames.append(companyName)
                                }
                            
                            }
                        
                        }
                        
                    }else {
                        
                        if let jobTitle = dict["jobTitle"] as? String {
                            
                            self.recentJobTitles.append(jobTitle)
                            
                            
                            
                            self.attemptReloadofRecentTable()
                        }
                        
                        if let companyKey = dict["userId"] as? String {
                            
                            self.recentCompanyKeys.append(companyKey)
                        }
                        
                        if let jobType = dict["jobType"] as? String {
                            
                            self.recentJobTypes.append(jobType)
                        }
                        
                        if let jobSalary = dict["maxSalary"] as? String {
                            
                            self.recentJobSalaries.append(jobSalary)
                        }
                        
                        if let jobImage = dict["profileImageUrl"] as? String {
                            
                            self.recentJobProfileImageUrls.append(jobImage)
                        }
                        
                        if let companyName = dict["employerName"] as? String {
                            
                            self.recentJobCompanyNames.append(companyName)
                        }
                        
                    }
                    
                    
                }
                
            })
            

            self.attemptReloadofRecentTable()
            self.loadingLoader.stopAnimating()
            
        }
        
    }
    ///
    
    var globalCount: Int!
    
    var currentColor = UIColor.black
    
    @objc func fetchForYouJobs(){
        
        let jobsRef = Database.database().reference().child("jobs").queryLimited(toLast: 7)
        
        jobsRef.observeSingleEvent(of: .value, with: { snapshot in

            let count = Int(snapshot.childrenCount)
            
            self.globalCount = count
            
            jobsRef.observe(.childAdded) { (snapshotKey) in
                
                let key = snapshotKey.key
                
                self.squareJobKeys.append(key)
                
                let itemReview = Database.database().reference().child("jobs").child(key)//.queryLimited(toLast: 7)
                
                itemReview.observe(.value, with: {(snapshot) in
                    
                    if let dict = snapshot.value as? [String: AnyObject] {
                        
                        
                        if self.jobType != "" {
                            
                            if let jT = dict["jobType"] as? String {
                                
                                if self.jobType == jT {
                                    
                                    //add
                                    
                                    if let jobTitle = dict["jobTitle"] as? String {
                                        
                                        
                                        self.squareJobTitles.append(jobTitle)
                                        
                                        if self.currentColor == UIColor.black {
                                            
                                            self.backgroundColors.append(.black)
                                            
                                            self.currentColor = UIColor.white
                                            
                                        }else {
                                            
                                            self.backgroundColors.append(.white)
                                            
                                            self.currentColor = UIColor.black
                                            
                                        }
                                        
                                        self.attemptReloadofTable()
                                        self.loadingLoader.stopAnimating()
                                        
                                    }
                                    
                                    if let companyKey = dict["userId"] as? String {
                                        
                                        self.squareCompanyKeys.append(companyKey)
                                    }
                                    
                                    if let jobType = dict["jobType"] as? String {
                                        
                                        self.squareJobTypes.append(jobType)
                                    }
                                    
                                    if let jobSalary = dict["maxSalary"] as? String {
                                        
                                        self.squareJobSalaries.append(jobSalary)
                                    }
                                    
                                    if let jobImage = dict["profileImageUrl"] as? String {
                                        
                                        self.squareJobProfileImageUrls.append(jobImage)
                                    }
                                    
                                }
                                
                            }
                            
                        }else {
                            
                            if let jobTitle = dict["jobTitle"] as? String {
                                
                                self.squareJobTitles.append(jobTitle)
                                
                                if self.currentColor == UIColor.black {
                                    
                                    self.backgroundColors.append(.black)
                                    
                                    self.currentColor = UIColor.white
                                    
                                }else {
                                    
                                    self.backgroundColors.append(.white)
                                    
                                    self.currentColor = UIColor.black
                                    
                                }
                                
                                self.attemptReloadofTable()
                                self.loadingLoader.stopAnimating()
                            }
                            
                            if let companyKey = dict["userId"] as? String {
                                
                                self.squareCompanyKeys.append(companyKey)
                            }
                            
                            if let jobType = dict["jobType"] as? String {
                                
                                self.squareJobTypes.append(jobType)
                            }
                            
                            if let jobSalary = dict["maxSalary"] as? String {
                                
                                self.squareJobSalaries.append(jobSalary)
                            }
                            
                            if let jobImage = dict["profileImageUrl"] as? String {
                                
                                self.squareJobProfileImageUrls.append(jobImage)
                            }
                            
                        }
                         
                        
                    }
                    
                })
                
            }
            
            
        })
    }
    
    var timer: Timer?
    
    @objc func attemptReloadofTable(){
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadTable), userInfo: nil, repeats: false)
        
    }
    
    @objc func reloadTable(){
        
        DispatchQueue.main.async {
            
            self.squareJobsCV.reloadData()
        }
        
    }
    
    @objc func fetchRecentJobs(){
        
        let jobsRef = Database.database().reference().child("jobs").queryLimited(toLast: 75)
        
        jobsRef.observeSingleEvent(of: .value, with: { snapshot in

            let count = Int(snapshot.childrenCount)
            
            self.globalCount = count
            
            jobsRef.observe(.childAdded) { (snapshotKey) in
                
                let key = snapshotKey.key
                
                self.recentJobKeys.append(key)
                
                let itemReview = Database.database().reference().child("jobs").child(key).queryLimited(toLast: 75)
                
                itemReview.observe(.value, with: {(snapshot) in
                    
                    if let dict = snapshot.value as? [String: AnyObject] {
                        
                        if self.jobType != "" {
                            
                            if let jT = dict["jobType"] as? String {
                                
                                if self.jobType == jT {
                                    
                                    if let jobTitle = dict["jobTitle"] as? String {
                                        
                                        self.recentJobTitles.append(jobTitle)
                                        
                                        
                                        
                                        self.attemptReloadofRecentTable()
                                    }
                                    
                                    if let companyKey = dict["userId"] as? String {
                                        
                                        self.recentCompanyKeys.append(companyKey)
                                    }
                                    
                                    if let jobType = dict["jobType"] as? String {
                                        
                                        self.recentJobTypes.append(jobType)
                                    }
                                    
                                    if let jobSalary = dict["maxSalary"] as? String {
                                        
                                        self.recentJobSalaries.append(jobSalary)
                                    }
                                    
                                    if let jobImage = dict["profileImageUrl"] as? String {
                                        
                                        self.recentJobProfileImageUrls.append(jobImage)
                                    }
                                    
                                    if let companyName = dict["employerName"] as? String {
                                        
                                        self.recentJobCompanyNames.append(companyName)
                                    }
                                
                                }
                            
                            }
                            
                        }else {
                            
                            if let jobTitle = dict["jobTitle"] as? String {
                                
                                self.recentJobTitles.append(jobTitle)
                                
                                
                                
                                self.attemptReloadofRecentTable()
                            }
                            
                            if let companyKey = dict["userId"] as? String {
                                
                                self.recentCompanyKeys.append(companyKey)
                            }
                            
                            if let jobType = dict["jobType"] as? String {
                                
                                self.recentJobTypes.append(jobType)
                            }
                            
                            if let jobSalary = dict["maxSalary"] as? String {
                                
                                self.recentJobSalaries.append(jobSalary)
                            }
                            
                            if let jobImage = dict["profileImageUrl"] as? String {
                                
                                self.recentJobProfileImageUrls.append(jobImage)
                            }
                            
                            if let companyName = dict["employerName"] as? String {
                                
                                self.recentJobCompanyNames.append(companyName)
                            }
                            
                        }
                        
                    }
                    
                })
               
                
            }
            
            
        })
    }
    
    var recentTimer: Timer?
    
    @objc func attemptReloadofRecentTable(){
        
        self.recentTimer?.invalidate()
        self.recentTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadRecentTable), userInfo: nil, repeats: false)
        
    }
    
    @objc func reloadRecentTable(){
        
        DispatchQueue.main.async {
            
            self.recentlyPostedCV.reloadData()
        }
        
    }
    
    @objc func menuF(){
        
        let controller = MenuViewController()
        controller.homeViewController = self
        let transitionDelegate = SPLarkTransitioningDelegate()
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        
        transitionDelegate.customHeight = 550
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    let transition = BubbleTransition()
    let interactiveTransition = BubbleInteractiveTransition()
    
    @objc func searchF(){
        
        let searchVC = SearchViewController()
        
        searchVC.transitioningDelegate = self
        searchVC.modalPresentationStyle = .custom
        searchVC.modalPresentationCapturesStatusBarAppearance = true
        searchVC.interactiveTransition = interactiveTransition
        interactiveTransition.attach(to: searchVC)
        
        present(searchVC, animated: true, completion: nil)
        
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      transition.transitionMode = .present
      transition.startingPoint = searchBtn.center
      transition.bubbleColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
      return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      transition.transitionMode = .dismiss
      transition.startingPoint = searchBtn.center
      transition.bubbleColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
      return transition
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
      return interactiveTransition
    }
    
    @objc func filterF(){
        
        let vw = FilterViewController()
        vw.modalPresentationStyle = .fullScreen
        
        present(vw, animated: true, completion: nil)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == squareJobsCV {
            
            return squareJobTitles.count
            
        }else if collectionView == recentlyPostedCV {
            
            return recentJobTitles.count
            
        }else {
            
            return filters.count
            
        }
        
        
    }
    
    var nextBackgroundColor = UIColor.black
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == squareJobsCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareJobsId", for: indexPath) as! SquareJobsCollectionViewCell
            
            cell.homeVC = self
            
            cell.jobTitleLbl.text = squareJobTitles[indexPath.row]
            
            cell.background.backgroundColor = backgroundColors[indexPath.row]
            
            if backgroundColors[indexPath.row] == UIColor.black {
                
                cell.jobTitleLbl.textColor = .white
                cell.jobSalaryLbl.textColor = .white
                cell.logoBtn.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
                cell.positionTypeView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
                cell.positionTypeLbl.textColor = .white
                
                
                
            }else {
                
                cell.jobTitleLbl.textColor = .black
                cell.jobSalaryLbl.textColor = .black
                cell.logoBtn.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
                cell.positionTypeView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
                cell.positionTypeLbl.textColor = .black
                
            }
            
            cell.positionTypeLbl.text = squareJobTypes[indexPath.row]
            cell.jobSalaryLbl.text =  "$ \(squareJobSalaries[indexPath.row]) p/m"
            
            cell.logoBtn.imageView!.sd_setImage(with: URL(string: squareJobProfileImageUrls[indexPath.row])) { (image, error, cachType, url) in
                
                cell.logoBtn.setImage(image, for: .normal)
                
            }
            
            return cell
            
        }else if collectionView == recentlyPostedCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyPostedId", for: indexPath) as! RecentlyPostedCollectionViewCell
            
            cell.homeVC = self
            
            cell.jobTitleLbl.text = recentJobTitles[indexPath.row]
            
            cell.jobCompanyNameLbl.text = recentJobCompanyNames[indexPath.row]
            cell.jobSalaryLbl.text = "$ \(recentJobSalaries[indexPath.row]) p/m"
            
            cell.logoBtn.imageView!.sd_setImage(with: URL(string: recentJobProfileImageUrls[indexPath.row])) { (image, error, cachType, url) in
                
                cell.logoBtn.setImage(image, for: .normal)
                
                
            }
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterId", for: indexPath) as! FilterCollectionViewCell
            
            cell.filterValueLbl.text = filters[indexPath.row]
            
            return cell
            
        }
        
        
    }
    
    @objc func openSquareCompanyInfo(cell: UICollectionViewCell){
        
        let indexP = squareJobsCV.indexPath(for: cell)!
        
        let companyVC = CompanyProfileViewController()
        companyVC.modalPresentationStyle = .fullScreen
        companyVC.key = squareCompanyKeys[indexP.row]
        
        present(companyVC, animated: true, completion: nil)
        
        
    }
    
    @objc func openRecentCompanyInfo(cell: UICollectionViewCell){
        
        let indexP = recentlyPostedCV.indexPath(for: cell)!
        
        let companyVC = CompanyProfileViewController()
        companyVC.modalPresentationStyle = .fullScreen
        companyVC.key = recentCompanyKeys[indexP.row]
        
        present(companyVC, animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == squareJobsCV {
            
            let aVC = AboutJobViewController()
            aVC.modalPresentationStyle = .fullScreen
            aVC.key = squareJobKeys[indexPath.row]
            
            present(aVC, animated: true, completion: nil)
            
        }else if collectionView == recentlyPostedCV {
            
            let aVC = AboutJobViewController()
            aVC.modalPresentationStyle = .fullScreen
            aVC.key = recentJobKeys[indexPath.row]
            
            present(aVC, animated: true, completion: nil)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == squareJobsCV {
            
            let size = CGSize(width: (view.frame.width / 2) + 15, height: (view.frame.width / 2) + 15)
            
            
            return size
            
        }else if collectionView == recentlyPostedCV {
            
            let size = CGSize(width: view.frame.width - 64, height: 75)
            
            return size
            
        }else {
            
            let size = CGSize(width: 155, height: 45)
            
            return size
            
        }
        
        
    }

    @objc func openProfile(){
        
        let profileVC = UserProfileViewController()
        profileVC.modalPresentationStyle = .fullScreen
        profileVC.key = self.uniqueId
        
        present(profileVC, animated: true, completion: nil)
    }
    
    @objc func openCandidates(){
        
        
        
        if isCandidate == false {
            
            let candidatesVC = CandidatesViewController()
            candidatesVC.modalPresentationStyle = .fullScreen
            
            present(candidatesVC, animated: true, completion: nil)
            
        }else {
            
            Loaf("Only employers have access", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
            
        }
        
    }
    
    @objc func openMessages(){
        
        let chatVC = UINavigationController(rootViewController: ChatsTableViewController())
        chatVC.modalPresentationStyle = .fullScreen
        
        present(chatVC, animated: true, completion: nil)
        
    }
    
    @objc func openPostJob(){
        
        if isCandidate == false {
            
            let postVC = PostAJobViewController()
            postVC.modalPresentationStyle = .fullScreen
            
            present(postVC, animated: true, completion: nil)
            
        }else {
            
            Loaf("Only employers can post jobs", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
            
        }
        
        
        
    }
    
    
}
