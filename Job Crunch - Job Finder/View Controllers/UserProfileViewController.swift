//
//  UserProfileViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/19.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Firebase
import PDFReader

class UserProfileViewController: UIViewController {
    
    var key: String!
    
    let topRightWave: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "top_right_wave-2")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    
    lazy var menuBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .white
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(viewCVF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let profileLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Profile", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = UIFont(name:"Copperplate", size: 27.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    let ringView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 185
        vw.layer.borderWidth = 6
        vw.layer.borderColor = UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1).cgColor
        
        return vw
    }()
    
    let profileImageView: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 175
        img.image = UIImage(named: "professional_woman")
        /*img.layer.borderWidth = 6
        img.layer.borderColor = UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1).cgColor*/
        
        return img
    }()
    
    let userNameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        lbl.text = "Lilly Lessi"
        
        lbl.font = .boldSystemFont(ofSize: 36)
        
        return lbl
    }()
    
    let userPositionLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .gray
        
        lbl.text = "UI/UX Designer"
        
        lbl.font = .systemFont(ofSize: 21)
        
        return lbl
    }()
    
    let rightWave: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "right_wave")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var bottomBackBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "back-arrow")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .white
        
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
    
    let locationIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        
        img.tintColor = UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        return img
    }()
    
    let userLocationLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black
        
        lbl.text = "NY, United States"
        
        lbl.font = .systemFont(ofSize: 19)
        
        return lbl
    }()
    
    let fewWordsLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .lightGray//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        lbl.text = "Few Words"
        
        lbl.font = .boldSystemFont(ofSize: 37)
        
        return lbl
    }()
    
    let aboutMeLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        lbl.text = "About Me"
        
        lbl.font = .boldSystemFont(ofSize: 19)
        
        return lbl
    }()
    
    let underliner: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        return vw
    }()
    
    let aboutUserValue: UITextView = {
        
        let txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isUserInteractionEnabled = false
        txt.textColor = .gray
        txt.backgroundColor = .clear
        
        txt.font = .systemFont(ofSize: 19)
        
        txt.text = "Lorem "
        
        return txt
    }()
    
    lazy var messageBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 32
        btn.backgroundColor = UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Message", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(messageF), for: .touchUpInside)
        
        btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
        
        view.addSubview(topRightWave)
        view.addSubview(menuBtn)
        //view.addSubview(profileLbl)
        
        view.addSubview(rightWave)
        view.addSubview(bottomBackBtn)
        
        view.addSubview(ringView)
        view.addSubview(profileImageView)
        view.addSubview(userNameLbl)
        view.addSubview(userPositionLbl)
        view.addSubview(locationIcon)
        view.addSubview(userLocationLbl)
        
        view.addSubview(fewWordsLbl)
        view.addSubview(aboutMeLbl)
        view.addSubview(underliner)
        
        view.addSubview(messageBtn)
        
        view.addSubview(aboutUserValue)
        
        topRightWave.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        topRightWave.heightAnchor.constraint(equalToConstant: 165).isActive = true
        topRightWave.widthAnchor.constraint(equalToConstant: 165).isActive = true
        topRightWave.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        menuBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        menuBtn.widthAnchor.constraint(equalToConstant: 55).isActive = true
        menuBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
        /*profileLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        profileLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        profileLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        profileLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true*/
        
        rightWave.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        rightWave.heightAnchor.constraint(equalToConstant: 125).isActive = true
        rightWave.widthAnchor.constraint(equalToConstant: 125).isActive = true
        rightWave.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 25).isActive = true
        
        bottomBackBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        bottomBackBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        bottomBackBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        bottomBackBtn.centerYAnchor.constraint(equalTo: rightWave.centerYAnchor, constant: 0).isActive = true
        
        ringView.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -95).isActive = true
        ringView.heightAnchor.constraint(equalToConstant: 370).isActive = true
        ringView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        ringView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 95).isActive = true
        
        profileImageView.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -85).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 85).isActive = true
        
        userNameLbl.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        userNameLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        userNameLbl.widthAnchor.constraint(equalToConstant: 350).isActive = true
        userNameLbl.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        
        userPositionLbl.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        userPositionLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        userPositionLbl.widthAnchor.constraint(equalToConstant: 350).isActive = true
        userPositionLbl.topAnchor.constraint(equalTo: userNameLbl.bottomAnchor, constant: 12).isActive = true
        
        locationIcon.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        locationIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        locationIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        locationIcon.topAnchor.constraint(equalTo: userPositionLbl.bottomAnchor, constant: 24).isActive = true
        
        userLocationLbl.leftAnchor.constraint(equalTo: locationIcon.rightAnchor, constant: 8).isActive = true
        userLocationLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        userLocationLbl.widthAnchor.constraint(equalToConstant: 350).isActive = true
        userLocationLbl.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor, constant: 0).isActive = true
        
        fewWordsLbl.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        fewWordsLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        fewWordsLbl.widthAnchor.constraint(equalToConstant: 195).isActive = true
        fewWordsLbl.topAnchor.constraint(equalTo: userLocationLbl.bottomAnchor, constant: 24).isActive = true
        
        aboutMeLbl.leftAnchor.constraint(equalTo: fewWordsLbl.rightAnchor, constant: 8).isActive = true
        aboutMeLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        aboutMeLbl.widthAnchor.constraint(equalToConstant: 95).isActive = true
        aboutMeLbl.bottomAnchor.constraint(equalTo: fewWordsLbl.bottomAnchor, constant: -2).isActive = true
        
        underliner.leftAnchor.constraint(equalTo: fewWordsLbl.rightAnchor, constant: 8).isActive = true
        underliner.heightAnchor.constraint(equalToConstant: 3).isActive = true
        underliner.widthAnchor.constraint(equalToConstant: 95).isActive = true
        underliner.bottomAnchor.constraint(equalTo: aboutMeLbl.bottomAnchor, constant: 0).isActive = true
        
        messageBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        messageBtn.heightAnchor.constraint(equalToConstant: 85).isActive = true
        messageBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        messageBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        aboutUserValue.leftAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: 0).isActive = true
        aboutUserValue.topAnchor.constraint(equalTo: underliner.bottomAnchor, constant: 12).isActive = true
        aboutUserValue.rightAnchor.constraint(equalTo: bottomBackBtn.leftAnchor, constant: -12).isActive = true
        aboutUserValue.bottomAnchor.constraint(equalTo: messageBtn.topAnchor, constant: -12).isActive = true
        
        getUserInfo()
        
    }
    
    var employerKey: String!
    var uniqueId: String!
    
    var userName: String!
    var userEmail: String!
    
    var userProfileImageUrl: String!
    
    var userCV: String!
    
    @objc func getUserInfo(){
        
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
                    
                    self.userPositionLbl.text = position
                    
                }
                
                if let about = dict["about"] as? String {
                    
                    self.aboutUserValue.text = about
                    
                }
                
                if let name = dict["fullName"] as? String {
                    
                    self.userName = name
                    self.userNameLbl.text = name
                    
                }
                
                if let image = dict["profileImageUrl"] as? String {
                    
                    self.userProfileImageUrl = image
                    self.profileImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "job_crunch"))
                    
                }
                
                if let location = dict["location"] as? String {
                    
                    self.userLocationLbl.text = location
                    
                }
                
                
            }
            
        })
    }
    
    var setUser = User()
    
    @objc func messageF(){
        
        let ref = Database.database().reference().child("users").child(key).child("info")
        
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
    
    @objc func viewCVF(){
        
        let remotePDFDocumentURLPath = userCV
        let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath!)!
        let document = PDFDocument(url: remotePDFDocumentURL)!
        
        let pdfController = PDFViewController.createNew(with: document, title: "Candidate CV/Resume")
        pdfController.backgroundColor = .white
        
        let readerController = UINavigationController(rootViewController: pdfController)
        
        present(readerController, animated: true, completion: nil)
        
        
        
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
