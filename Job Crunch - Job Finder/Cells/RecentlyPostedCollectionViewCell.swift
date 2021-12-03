//
//  RecentlyPostedCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class RecentlyPostedCollectionViewCell: UICollectionViewCell {
    
    var homeVC: HomeViewController?
    
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
        lbl.textColor = .gray
        lbl.text = "$ 3500 p/m"
        
        lbl.textAlignment = NSTextAlignment.right
        
        lbl.font = .systemFont(ofSize: 16)
        
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
        
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        logoBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        logoBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logoBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        jobTitleLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -120).isActive = true
        jobTitleLbl.topAnchor.constraint(equalTo: logoBtn.topAnchor).isActive = true
        jobTitleLbl.leftAnchor.constraint(equalTo: logoBtn.rightAnchor, constant: 12).isActive = true
        jobTitleLbl.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        jobSalaryLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        jobSalaryLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        jobSalaryLbl.widthAnchor.constraint(equalToConstant: 125).isActive = true
        jobSalaryLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        jobCompanyNameLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        jobCompanyNameLbl.topAnchor.constraint(equalTo: jobTitleLbl.bottomAnchor).isActive = true
        jobCompanyNameLbl.leftAnchor.constraint(equalTo: logoBtn.rightAnchor, constant: 12).isActive = true
        jobCompanyNameLbl.bottomAnchor.constraint(equalTo: logoBtn.bottomAnchor).isActive = true
          
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
    
    @objc func logoCompanyInfoF(){
        
        homeVC?.openRecentCompanyInfo(cell: self)
        
    }
    
}
