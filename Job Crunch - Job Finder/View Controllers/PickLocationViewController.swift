//
//  PickLocationViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/21.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class PickLocationViewController: UIViewController {
    
    let startLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Let's Start"
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = .boldSystemFont(ofSize: 32)
        
        lbl.layer.zPosition = 3
        
        return lbl
        
    }()
    
    let locationImage: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "location_icon")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        
        logo.layer.zPosition = 2
        
        return logo

    }()
    
    lazy var startBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Start", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(startF), for: .touchUpInside)
        
        //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let chooseLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.text = "Choose where on earth you are located for more relevant job searches"
        
        lbl.numberOfLines = 3
        
        lbl.font = .systemFont(ofSize: 21)
        
        return lbl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(startLbl)
        view.addSubview(locationImage)
        view.addSubview(chooseLbl)
        view.addSubview(startBtn)
        
        startLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        startLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        startLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        
        locationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -94).isActive = true
        locationImage.heightAnchor.constraint(equalToConstant: view.frame.width / 2.3).isActive = true
        locationImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2.3).isActive = true
        
        chooseLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseLbl.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 32).isActive = true
        chooseLbl.heightAnchor.constraint(equalToConstant: 90).isActive = true
        chooseLbl.widthAnchor.constraint(equalToConstant: view.frame.width / 1.2).isActive = true
        
        startBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        startBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        startBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        
    }
    
    @objc func startF(){
        
        let lVC = UINavigationController(rootViewController: LocationViewController())
        lVC.modalPresentationStyle = .fullScreen
        
        present(lVC, animated: true, completion: nil)
        
    }

}
