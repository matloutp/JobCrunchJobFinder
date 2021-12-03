//
//  CompanyProfileViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/19.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Firebase

class CompanyProfileViewController: UIViewController {
    
    var key: String!
    
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
    

    let companyLogo: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "microsoft")
        
        return img
    }()
    
    let companyName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Microsoft Inc."
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .boldSystemFont(ofSize: 21)
        
        return lbl
    }()
    
    let companyAddress: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "1600 Amphitheatre Parkway, Mountain View"
        lbl.numberOfLines = 2
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .systemFont(ofSize: 16)
        
        return lbl
    }()
    
    let aboutLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "About"
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.font = .boldSystemFont(ofSize: 21)
        
        return lbl
    }()
    
    let aboutValueLbl: UITextView = {
        
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = false
        lbl.text = "About"
        lbl.textAlignment = NSTextAlignment.left
        lbl.backgroundColor = .clear
        lbl.font = .systemFont(ofSize: 21)
        
        return lbl
    }()
    
    lazy var jobsBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Jobs", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(jobsF), for: .touchUpInside)
        
        //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(backBtn)
        
        view.addSubview(companyLogo)
        view.addSubview(companyName)
        view.addSubview(companyAddress)
        view.addSubview(aboutLbl)
        view.addSubview(aboutValueLbl)
        
        view.addSubview(jobsBtn)
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        
        companyLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        companyLogo.heightAnchor.constraint(equalToConstant: 135).isActive = true
        companyLogo.widthAnchor.constraint(equalToConstant: 135).isActive = true
        companyLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 95).isActive = true
        
        companyName.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        companyName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        companyName.widthAnchor.constraint(equalToConstant: 135).isActive = true
        companyName.topAnchor.constraint(equalTo: companyLogo.bottomAnchor, constant: 12).isActive = true
        
        companyAddress.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        companyAddress.heightAnchor.constraint(equalToConstant: 35).isActive = true
        companyAddress.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        companyAddress.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 12).isActive = true
        
        aboutLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
        aboutLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        aboutLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        aboutLbl.topAnchor.constraint(equalTo: companyAddress.bottomAnchor, constant: 12).isActive = true
        
        aboutValueLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
        aboutValueLbl.bottomAnchor.constraint(equalTo: jobsBtn.topAnchor, constant: -24).isActive = true
        aboutValueLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36).isActive = true
        aboutValueLbl.topAnchor.constraint(equalTo: aboutLbl.bottomAnchor, constant: 12).isActive = true
        
        jobsBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        jobsBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        jobsBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        jobsBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        
        fetchCompanyInfo()
        
    }
    
    var employerKey: String!
    var uniqueId: String!
    
    var userName: String!
    var userEmail: String!
    
    var userProfileImageUrl: String!
    
    var userCV: String!
    
    @objc func fetchCompanyInfo(){
        
        let userRef = Database.database().reference().child("users").child(key).child("info")
        
        userRef.observe(.value, with: {(snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject] {
                
                if let userCV = dict["userCV"] as? String {
                    
                    self.userCV = userCV
                    
                }
                
                if let email = dict["email"] as? String {
                    
                    self.userEmail = email
                    
                }
                
                if let position = dict["profession"] as? String {
                    
                    //self.userPositionLbl.text = position
                    
                }
                
                if let about = dict["about"] as? String {
                    
                    self.aboutValueLbl.text = about
                    
                }
                
                if let name = dict["fullName"] as? String {
                    
                    self.userName = name
                    self.companyName.text = name
                    
                }
                
                if let image = dict["profileImageUrl"] as? String {
                    
                    self.userProfileImageUrl = image
                    self.companyLogo.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "job_crunch"))
                    
                }
                
                if let location = dict["location"] as? String {
                    
                    self.companyAddress.text = location
                    
                }
                
                
            }
            
        })
    }
    
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func jobsF(){
        
        let jobsVC = CompanyJobsViewController()
        jobsVC.modalPresentationStyle = .fullScreen
        jobsVC.key = key
        
        present(jobsVC, animated: true, completion: nil)
        
    }

}
