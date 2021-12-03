//
//  CandidatesViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/20.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class CandidatesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate {
    
    var candidateKeys = [String]()
    var candidateNames = [String]()
    var candidateProfileImages = [String]()
    var candidateJobTitles = [String]()
    
    var applicationIds = [String]()
    
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
       
       let manageCandidatesLbl: UILabel = {
           
           let lbl = UILabel()
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.text = NSLocalizedString("Manage Candidates", comment: "")
           
           lbl.textColor = .black
           
           
           lbl.font = UIFont(name:"Copperplate", size: 27.0)
           
           lbl.textAlignment = NSTextAlignment.left
           
           return lbl
       }()
    
    lazy var candidatesCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(CandidatesCollectionViewCell.self, forCellWithReuseIdentifier: "CandidatesId")
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
        view.addSubview(manageCandidatesLbl)
        
        view.addSubview(candidatesCV)
        view.addSubview(loadingLoader)
        
        candidatesCV.delegate = self
        candidatesCV.dataSource = self
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        
        manageCandidatesLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        manageCandidatesLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        manageCandidatesLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        manageCandidatesLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
        
        candidatesCV.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        candidatesCV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        candidatesCV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        candidatesCV.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 12).isActive = true
        
        loadingLoader.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loadingLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 45).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        getUserInfo()
        
    }
    
    var uniqueId: String!
    
    @objc func getUserInfo(){
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            self.uniqueId = user.uid
            
            fetchCandidates()
            
        }
    }
    
    
    
    var globalCount: Int!
    
    var currentColor = UIColor.black
    
    @objc func fetchCandidates(){
        
        let candidatesRef = Database.database().reference().child("users").child(uniqueId).child("candidates")
        
        candidatesRef.observeSingleEvent(of: .value, with: { snapshot in

            let count = Int(snapshot.childrenCount)
            
            self.globalCount = count
            
            candidatesRef.observe(.childAdded) { (snapshotKey) in
                
                let key = snapshotKey.key
                
                let itemReview = Database.database().reference().child("users").child(self.uniqueId).child("candidates").child(key)
                
                itemReview.observe(.value, with: {(snapshot) in
                    
                    if let dict = snapshot.value as? [String: AnyObject] {
                        
                        
                        if let candidateKey = dict["candidateId"] as? String {
                            
                            self.candidateKeys.append(candidateKey)
                            
                        }
                        
                        if let candidateImage = dict["profileImageUrl"] as? String {
                            
                            self.candidateProfileImages.append(candidateImage)
                            
                        }
                        
                        if let candidateJobTitle = dict["jobTitle"] as? String {
                            
                            self.candidateJobTitles.append(candidateJobTitle)
                            
                        }
                        
                        if let candidateName = dict["candidateName"] as? String {
                            
                            self.candidateNames.append(candidateName)
                            
                            self.attemptReloadofTable()
                            self.loadingLoader.stopAnimating()
                        }
                        
                        if let applicationId = dict["applicationKey"] as? String {
                            
                            self.applicationIds.append(applicationId)
                            
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
            
            self.candidatesCV.reloadData()
        }
        
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return candidateNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CandidatesId", for: indexPath) as! CandidatesCollectionViewCell
        
        cell.candidateVC = self
        
        cell.candidateName.text = candidateNames[indexPath.row]
        cell.jobTitleValue.text = candidateJobTitles[indexPath.row]
        
        let userProfile = candidateProfileImages[indexPath.row]
        
        cell.profileImageView.sd_setImage(with: URL(string: userProfile), placeholderImage: UIImage(named: "job_crunch"))
        
        return cell
        
    }
    
    @objc func messageCandidateF(cell: UICollectionViewCell){
        
        let indexP = candidatesCV.indexPath(for: cell)!
        
        let cell = cell as! CandidatesCollectionViewCell
        
        let chatParnterId = candidateKeys[indexP.row]
        
        let ref = Database.database().reference().child("users").child(chatParnterId).child("info")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject] {
                
                self.setUser.setValuesForKeys(dict)
                
                let layout = UICollectionViewFlowLayout()
                
                let rVC = ChatLogController(collectionViewLayout: layout)
                rVC.user = self.setUser
                
                let chatLogController = UINavigationController(rootViewController: rVC)//
                //chatLogController.user = self.setUser
                
                chatLogController.modalPresentationStyle = .fullScreen
                
                self.present(chatLogController, animated: true, completion: nil)
                
            }
            
        }, withCancel: nil)
        
        
    }
    
    @objc func deleteCandidateF(cell: UICollectionViewCell){
        
        let indexP = candidatesCV.indexPath(for: cell)!
        
        let cell = cell as! CandidatesCollectionViewCell
        
        Database.database().reference().child("users").child(uniqueId).child("candidates").child(applicationIds[indexP.row]).removeValue()
        
        applicationIds.remove(at: indexP.row)
        candidateJobTitles.remove(at: indexP.row)
        candidateProfileImages.remove(at: indexP.row)
        candidateKeys.remove(at: indexP.row)
        candidateNames.remove(at: indexP.row)
        
        candidatesCV.reloadData()
        
        
        
    }
    
    var user: User!
    var setUser = User()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userProVC = UserProfileViewController()
        userProVC.modalPresentationStyle = .fullScreen
        userProVC.key = candidateKeys[indexPath.row]
        
        present(userProVC, animated: true, completion: nil)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 32, height: 75)
        
        return size
    }

}
