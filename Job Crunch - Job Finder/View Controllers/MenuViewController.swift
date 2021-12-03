//
//  MenuViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var homeViewController: HomeViewController?
    
    var titles = [NSLocalizedString("Jobs", comment: ""), NSLocalizedString("User Info", comment: ""), NSLocalizedString("Messages", comment: ""), NSLocalizedString("Post", comment: ""), NSLocalizedString("Applications", comment: "")]
    var subtitles = [NSLocalizedString("Home", comment: ""), NSLocalizedString("Profile", comment: ""), NSLocalizedString("Chats", comment: ""), NSLocalizedString("New Job", comment: ""), NSLocalizedString("Candidates", comment: "")]
    
    let menuLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Menu", comment: "")
        
        lbl.textColor = .white
        
        
        lbl.font = UIFont(name:"Copperplate", size: 23.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    
    lazy var closeBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .white
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        btn.addTarget(self, action: #selector(closeF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    
    lazy var menuCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        // Do any additional setup after loading the view.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func setup(){
        
        view.addSubview(menuLbl)
        view.addSubview(closeBtn)
        view.addSubview(menuCV)
        
        menuCV.delegate = self
        menuCV.dataSource = self
        
        menuLbl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        menuLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        menuLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        menuLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        
        closeBtn.centerYAnchor.constraint(equalTo: menuLbl.centerYAnchor, constant: 0).isActive = true
        closeBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        menuCV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        menuCV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        menuCV.widthAnchor.constraint(equalToConstant: 320).isActive = true
        menuCV.topAnchor.constraint(equalTo: menuLbl.bottomAnchor, constant: 12).isActive = true
        
    }
    
    @objc func closeF(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if collectionView == menuCV {
            
            return 1
            
        }else {
            
            return 1
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == menuCV {
            
            return titles.count
            
        } else {
            
            return 1
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuId", for: indexPath) as! MenuCollectionViewCell
                   
        cell.title.text = titles[indexPath.row]
        
        cell.subtitle.text = subtitles[indexPath.row]
        
        if indexPath.row == 0 {
            
            cell.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
            
        }else {
            
            cell.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 35/255, alpha: 1)
            
        }
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 21
        
                   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == menuCV {
        

            let size = CGSize(width:155, height: 115)
            
            return size
            
        }else {
            
            let size = CGSize(width: view.frame.width / 5, height: view.frame.width / 5)
            
            return size
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        
        dismiss(animated: true, completion: nil)
        
        if row == 0 {
            
            
        }else if row == 1 {
            
            homeViewController?.openProfile()
            
        }else if row == 2 {
            
            homeViewController?.openMessages()
            
        }else if row == 3 {
            
            homeViewController?.openPostJob()
            
        }else if row == 4 {
            
            homeViewController?.openCandidates()
            
        }
        
    }

}
