//
//  ApplicationsViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/20.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import MobileCoreServices

class ApplicationsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIDocumentPickerDelegate {
    
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

    let applicationsLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Your Applications", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = UIFont(name:"Copperplate", size: 27.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    lazy var applicationsCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.register(ApplicationsCollectionViewCell.self, forCellWithReuseIdentifier: "ApplicationsId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        
        view.addSubview(backBtn)
        
        view.addSubview(applicationsLbl)
        
        view.addSubview(applicationsCV)
        
        applicationsCV.delegate = self
        applicationsCV.dataSource = self
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        
        applicationsLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        applicationsLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        applicationsLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        applicationsLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
        
        applicationsCV.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        applicationsCV.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 12).isActive = true
        applicationsCV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        applicationsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
         // you get from the urls parameter the urls from the files selected
    }
    
    var documentPicker: UIDocumentPickerViewController!
    
    @objc func pickPDF(){
        
        let types: [String] = [kUTTypePDF as String]
        documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
               
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        documentPicker.dismiss(animated: true, completion: nil)
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplicationsId", for: indexPath) as! ApplicationsCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 34, height: 175)
        
        return size
    }

}
