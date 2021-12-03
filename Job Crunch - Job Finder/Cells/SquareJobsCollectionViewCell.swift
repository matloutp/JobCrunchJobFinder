//
//  SquareJobsCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class SquareJobsCollectionViewCell: UICollectionViewCell {
    
    var homeVC: HomeViewController?
    
    let background: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .black
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    lazy var logoBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 12
        btn.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        
        let img = UIImage(named: "uber")//?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        btn.addTarget(self, action: #selector(logoCompanyInfoF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let positionTypeView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 8
        
        vw.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        
        return vw
        
    }()
    
    let positionTypeLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.text = "Full time"
        
        lbl.textAlignment = NSTextAlignment.center
        
        return lbl
    }()
    
    let jobTitleLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.text = "UI/UX Designer"
        
        lbl.font = .systemFont(ofSize: 19)
        
        return lbl
    }()
    
    let jobSalaryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.text = "$ 3500 p/m"
        
        lbl.font = .systemFont(ofSize: 27)
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(background)
        addSubview(logoBtn)
        addSubview(positionTypeView)
        positionTypeView.addSubview(positionTypeLbl)
        
        addSubview(jobTitleLbl)
        addSubview(jobSalaryLbl)
        
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        logoBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        logoBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        logoBtn.widthAnchor.constraint(equalToConstant: 55).isActive = true
        logoBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        
        positionTypeView.leftAnchor.constraint(equalTo: logoBtn.rightAnchor, constant: 24).isActive = true
        positionTypeView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        positionTypeView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        positionTypeView.centerYAnchor.constraint(equalTo: logoBtn.centerYAnchor, constant: 0).isActive = true
        
        positionTypeLbl.leftAnchor.constraint(equalTo: positionTypeView.leftAnchor, constant: 0).isActive = true
        positionTypeLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        positionTypeLbl.rightAnchor.constraint(equalTo: positionTypeView.rightAnchor, constant: 0).isActive = true
        positionTypeLbl.centerYAnchor.constraint(equalTo: positionTypeView.centerYAnchor, constant: 0).isActive = true
        
        jobTitleLbl.leftAnchor.constraint(equalTo: logoBtn.leftAnchor, constant: 0).isActive = true
        jobTitleLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        jobTitleLbl.rightAnchor.constraint(equalTo: positionTypeView.rightAnchor, constant: 0).isActive = true
        jobTitleLbl.topAnchor.constraint(equalTo: logoBtn.bottomAnchor, constant: 32).isActive = true
        
        jobSalaryLbl.leftAnchor.constraint(equalTo: logoBtn.leftAnchor, constant: 0).isActive = true
        jobSalaryLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        jobSalaryLbl.rightAnchor.constraint(equalTo: positionTypeView.rightAnchor, constant: 0).isActive = true
        jobSalaryLbl.topAnchor.constraint(equalTo: jobTitleLbl.bottomAnchor, constant: 12).isActive = true
        
    }
    
    @objc func logoCompanyInfoF(){
        
        homeVC?.openSquareCompanyInfo(cell: self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
    
}
