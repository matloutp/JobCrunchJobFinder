//
//  SalaryCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class SalaryCollectionViewCell: UICollectionViewCell {
    
    let background: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 12
        vw.layer.borderWidth = 2
        vw.layer.borderColor = UIColor.black.cgColor
        
        return vw
    }()
    
    let salaryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("$ 5k - 10k", comment: "")
        
        lbl.textColor = .black
        
        lbl.font = .systemFont(ofSize: 21)
        
        lbl.textAlignment = NSTextAlignment.center
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    
    func setup(){
        
        addSubview(background)
        addSubview(salaryLbl)
        
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        salaryLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        salaryLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        salaryLbl.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        salaryLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
