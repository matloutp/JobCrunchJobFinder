//
//  ApplicationsCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/20.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class ApplicationsCollectionViewCell: UICollectionViewCell {
    
    let background: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    lazy var logoBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        
        let img = UIImage(named: "airbnb")//?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        btn.addTarget(self, action: #selector(logoCompanyInfoF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let jobTitleLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.text = "UI/UX Designer"
        
        lbl.font = .boldSystemFont(ofSize: 18)
        
        return lbl
    }()
    
    let jobSalaryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.text = "$ 3500 p/m"
        
        
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .systemFont(ofSize: 21)
        
        return lbl
    }()
    
    let jobCompanyNameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .gray
        lbl.text = "Airbnb Inc"
        
        lbl.font = .systemFont(ofSize: 16)
        
        return lbl
    }()
    
    let deliveredLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 12
        
        lbl.textAlignment = NSTextAlignment.center
        lbl.text = "Delivered"
        
        lbl.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(background)
        
        addSubview(logoBtn)
        
        addSubview(jobTitleLbl)
        addSubview(jobSalaryLbl)
        addSubview(jobCompanyNameLbl)
        addSubview(deliveredLbl)
        
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        logoBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        logoBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logoBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        
        jobTitleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        jobTitleLbl.topAnchor.constraint(equalTo: logoBtn.topAnchor).isActive = true
        jobTitleLbl.leftAnchor.constraint(equalTo: logoBtn.rightAnchor, constant: 12).isActive = true
        jobTitleLbl.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        
        jobCompanyNameLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        jobCompanyNameLbl.topAnchor.constraint(equalTo: jobTitleLbl.bottomAnchor).isActive = true
        jobCompanyNameLbl.leftAnchor.constraint(equalTo: logoBtn.rightAnchor, constant: 12).isActive = true
        jobCompanyNameLbl.bottomAnchor.constraint(equalTo: logoBtn.bottomAnchor).isActive = true
        
        deliveredLbl.leftAnchor.constraint(equalTo: logoBtn.leftAnchor, constant: 0).isActive = true
        deliveredLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true
        deliveredLbl.widthAnchor.constraint(equalToConstant: 175).isActive = true
        deliveredLbl.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        
        jobSalaryLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        jobSalaryLbl.centerYAnchor.constraint(equalTo: deliveredLbl.centerYAnchor).isActive = true
        jobSalaryLbl.leftAnchor.constraint(equalTo: deliveredLbl.rightAnchor, constant: 12).isActive = true
        jobSalaryLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logoCompanyInfoF(){
        
        
    }
    
}
