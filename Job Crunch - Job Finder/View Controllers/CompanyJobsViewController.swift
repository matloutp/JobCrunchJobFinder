//
//  CompanyJobsViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/19.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class CompanyJobsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate {
    
    var key: String!
    
    var squareJobTitles = [String]()
    var squareJobKeys = [String]()
    var squareJobSalaries = [String]()
    var squareJobTypes = [String]()
    var squareJobLogos = [String]()

    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(backF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let jobsByLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Jobs by Microsoft", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = UIFont(name:"Copperplate", size: 21.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    lazy var squareJobsCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(SquareJobsCollectionViewCell.self, forCellWithReuseIdentifier: "SquareJobsId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
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
    
    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(backBtn)
        view.addSubview(jobsByLbl)
        view.addSubview(squareJobsCV)
        view.addSubview(loadingLoader)
        
        squareJobsCV.delegate = self
        squareJobsCV.dataSource = self
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        
        jobsByLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        jobsByLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobsByLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        jobsByLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
        
        squareJobsCV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        squareJobsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        squareJobsCV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        squareJobsCV.topAnchor.constraint(equalTo: jobsByLbl.bottomAnchor, constant: 12).isActive = true
        
        loadingLoader.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loadingLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 45).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        getUserInfo()
        
    }
    
    var uniqueId: String!
    
    var userName: String!
    var userEmail: String!
    
    var userProfileImageUrl: String!
    
    var userCV: String!
    
    @objc func getUserInfo(){
        
        let userRef = Database.database().reference().child("users").child(key).child("info")
        
        userRef.observe(.value, with: {(snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject] {
                
                if let companyName = dict["fullName"] as? String {
                    
                    self.jobsByLbl.text = "Jobs by " + companyName
                }
                
                if let image = dict["profileImageUrl"] as? String {
                    
                    self.userProfileImageUrl = image
                    
                }
                
                self.fetchCompanyJobs()
                
                
            }
            
        })
    }
    
    var globalCount: Int!
    
    var currentColor = UIColor.black
    
    @objc func fetchCompanyJobs(){
        
        let jobsRef = Database.database().reference().child("jobs").queryOrdered(byChild: "userId").queryEqual(toValue: key)
        
        jobsRef.observeSingleEvent(of: .value, with: { snapshot in

            let count = Int(snapshot.childrenCount)
            
            self.globalCount = count
            
            jobsRef.observe(.childAdded) { (snapshotKey) in
                
                let key = snapshotKey.key
                
                self.squareJobKeys.append(key)
                
                let itemReview = Database.database().reference().child("jobs").child(key)
                
                itemReview.observe(.value, with: {(snapshot) in
                    
                    if let dict = snapshot.value as? [String: AnyObject] {
                        
                        
                        if let jobTitle = dict["jobTitle"] as? String {
                            
                            self.squareJobTitles.append(jobTitle)
                            
                            
                            self.attemptReloadofTable()
                            self.loadingLoader.stopAnimating()
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
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return squareJobTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SquareJobsId", for: indexPath) as! SquareJobsCollectionViewCell
        
        cell.jobTitleLbl.text = squareJobTitles[indexPath.row]
        
        cell.logoBtn.imageView!.sd_setImage(with: URL(string: userProfileImageUrl), placeholderImage: UIImage(named: "job_crunch"))
        
        cell.logoBtn.imageView!.sd_setImage(with: URL(string: userProfileImageUrl)) { (image, error, cachType, url) in
            
            cell.logoBtn.setImage(image, for: .normal)
            
            
        }
        
        cell.background.layer.cornerRadius = 24
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let aVC = AboutJobViewController()
        aVC.modalPresentationStyle = .fullScreen
        aVC.key = squareJobKeys[indexPath.row]
        
        present(aVC, animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 24, height: 195)
        
        
        return size
        
    }

}
