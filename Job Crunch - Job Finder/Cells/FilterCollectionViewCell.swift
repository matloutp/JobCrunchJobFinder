//
//  FilterCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    let background: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    lazy var removeFilterBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        btn.addTarget(self, action: #selector(removeFilterF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let filterValueLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.text = "New York"
        
        lbl.textAlignment = NSTextAlignment.center
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(background)
        addSubview(removeFilterBtn)
        addSubview(filterValueLbl)
        
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        removeFilterBtn.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -12).isActive = true
        removeFilterBtn.heightAnchor.constraint(equalToConstant: 15).isActive = true
        removeFilterBtn.widthAnchor.constraint(equalToConstant: 15).isActive = true
        removeFilterBtn.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: 0).isActive = true
        
        filterValueLbl.rightAnchor.constraint(equalTo: removeFilterBtn.leftAnchor, constant: -12).isActive = true
        filterValueLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        filterValueLbl.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 12).isActive = true
        filterValueLbl.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
    
    @objc func removeFilterF(){
        
        
    }
    
}
