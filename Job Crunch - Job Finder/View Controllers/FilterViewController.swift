//
//  FilterViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Loaf

class FilterViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedJobType = "Full time"

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
    
    let filterLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Filter", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = UIFont(name:"Copperplate", size: 27.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    let locationValueBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .black
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 8
        
        return vw
    }()
    
    let locationLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Location", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = .systemFont(ofSize: 26)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    
    let locationValueLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Near Me", comment: "")
        
        lbl.textColor = .white
        
        
        lbl.font = .systemFont(ofSize: 21)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    
    lazy var changeLocationBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        
        
        btn.setTitle("change", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
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
    
    let positionTypeLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Job Type", comment: "")
        
        lbl.textColor = .black
        
        lbl.font = .systemFont(ofSize: 21)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    
    lazy var fullTimeValueBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .black//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        
        btn.setTitle("Full time", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        btn.addTarget(self, action: #selector(fullTimeF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var partTimeValueBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        
        btn.setTitle("Part time", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        btn.addTarget(self, action: #selector(partTimeF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var remoteValueBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        
        btn.setTitle("Remote", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        btn.addTarget(self, action: #selector(remoteF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let salaryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Salary", comment: "")
        
        lbl.textColor = .black
        
        lbl.font = .systemFont(ofSize: 21)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    lazy var salaryCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(SalaryCollectionViewCell.self, forCellWithReuseIdentifier: "SalaryId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()
    
    lazy var defaultBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Search by Filter", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(searchFilterF), for: .touchUpInside)
        
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
        view.addSubview(filterLbl)
        
        
        /*view.addSubview(locationLbl)
        view.addSubview(locationValueBackground)
        view.addSubview(locationValueLbl)
        view.addSubview(changeLocationBtn)*/
        
        view.addSubview(positionTypeLbl)
        
        view.addSubview(partTimeValueBtn)
        view.addSubview(remoteValueBtn)
        view.addSubview(fullTimeValueBtn)
        
        //view.addSubview(salaryLbl)
        
        //view.addSubview(salaryCV)
        
        view.addSubview(defaultBtn)
        
        salaryCV.delegate = self
        salaryCV.dataSource = self
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        
        filterLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        filterLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        filterLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        filterLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
        
        /*locationLbl.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        locationLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        locationLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        locationLbl.topAnchor.constraint(equalTo: filterLbl.bottomAnchor, constant: 24).isActive = true
        
        locationValueBackground.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        locationValueBackground.heightAnchor.constraint(equalToConstant: 45).isActive = true
        locationValueBackground.widthAnchor.constraint(equalToConstant: 175).isActive = true
        locationValueBackground.topAnchor.constraint(equalTo: locationLbl.bottomAnchor, constant: 24).isActive = true
        
        locationValueLbl.leftAnchor.constraint(equalTo: locationValueBackground.leftAnchor, constant: 12).isActive = true
        locationValueLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        locationValueLbl.rightAnchor.constraint(equalTo: locationValueBackground.rightAnchor, constant:  -12).isActive = true
        locationValueLbl.centerYAnchor.constraint(equalTo: locationValueBackground.centerYAnchor, constant: 0).isActive = true
        
        changeLocationBtn.leftAnchor.constraint(equalTo: locationValueBackground.rightAnchor, constant: 12).isActive = true
        changeLocationBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        changeLocationBtn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        changeLocationBtn.centerYAnchor.constraint(equalTo: locationValueBackground.centerYAnchor, constant: 0).isActive = true*/
        
        positionTypeLbl.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        positionTypeLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        positionTypeLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        positionTypeLbl.topAnchor.constraint(equalTo: filterLbl.bottomAnchor, constant: 24).isActive = true
        
        partTimeValueBtn.widthAnchor.constraint(equalToConstant: (view.frame.width / 3) - 24).isActive = true
        partTimeValueBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        partTimeValueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        partTimeValueBtn.topAnchor.constraint(equalTo: positionTypeLbl.bottomAnchor, constant: 24).isActive = true
        
        remoteValueBtn.widthAnchor.constraint(equalToConstant: (view.frame.width / 3) - 24).isActive = true
        remoteValueBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        remoteValueBtn.leftAnchor.constraint(equalTo: partTimeValueBtn.rightAnchor, constant: 12).isActive = true
        remoteValueBtn.topAnchor.constraint(equalTo: positionTypeLbl.bottomAnchor, constant: 24).isActive = true
        
        fullTimeValueBtn.widthAnchor.constraint(equalToConstant: (view.frame.width / 3) - 24).isActive = true
        fullTimeValueBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        fullTimeValueBtn.rightAnchor.constraint(equalTo: partTimeValueBtn.leftAnchor, constant: -12).isActive = true
        fullTimeValueBtn.topAnchor.constraint(equalTo: positionTypeLbl.bottomAnchor, constant: 24).isActive = true
        
        /*salaryLbl.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        salaryLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        salaryLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        salaryLbl.topAnchor.constraint(equalTo: partTimeValueBtn.bottomAnchor, constant: 24).isActive = true
        
        salaryCV.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        salaryCV.heightAnchor.constraint(equalToConstant: 55).isActive = true
        salaryCV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        salaryCV.topAnchor.constraint(equalTo: salaryLbl.bottomAnchor, constant: 12).isActive = true*/
        
        defaultBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        defaultBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        defaultBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        defaultBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        
        
        
    }
    
    var filters = [String]()
    
    @objc func searchFilterF(){
        
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.filters = filters
        homeVC.jobType = selectedJobType
        
        present(homeVC, animated: true, completion: nil)
        
    }
    
    
    @objc func fullTimeF(){
        
        selectedJobType = "Full Time"
        filters = ["Full Time"]
        
        fullTimeValueBtn.backgroundColor = .black
        fullTimeValueBtn.setTitleColor(.white, for: .normal)
        
        partTimeValueBtn.backgroundColor = .clear
        partTimeValueBtn.setTitleColor(.black, for: .normal)
        
        remoteValueBtn.backgroundColor = .clear
        remoteValueBtn.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func partTimeF(){
        
        selectedJobType = "Part Time"
        filters = ["Part Time"]
        
        fullTimeValueBtn.backgroundColor = .clear
        fullTimeValueBtn.setTitleColor(.black, for: .normal)
        
        partTimeValueBtn.backgroundColor = .black
        partTimeValueBtn.setTitleColor(.white, for: .normal)
        
        remoteValueBtn.backgroundColor = .clear
        remoteValueBtn.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func remoteF(){
        
        selectedJobType = "Remote"
        filters = ["Remote"]
        
        fullTimeValueBtn.backgroundColor = .clear
        fullTimeValueBtn.setTitleColor(.black, for: .normal)
        
        partTimeValueBtn.backgroundColor = .clear
        partTimeValueBtn.setTitleColor(.black, for: .normal)
        
        remoteValueBtn.backgroundColor = .black
        remoteValueBtn.setTitleColor(.white, for: .normal)
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SalaryId", for: indexPath) as! SalaryCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 155, height: 35)
        
        return size
        
    }
    
    
}
