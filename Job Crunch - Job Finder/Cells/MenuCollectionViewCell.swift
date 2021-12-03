//
//  MenuCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//


import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    let menuIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        
        
        return img
        
    }()
    
    let title: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = NSTextAlignment.left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Avenir-Light", size: 14)
        lbl.alpha = 1
        lbl.backgroundColor = .clear
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 5
        
        return lbl
        
    }()
    
    let subtitle: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = NSTextAlignment.left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Avenir-Light", size: 20)
        lbl.alpha = 1
        lbl.backgroundColor = .clear
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 5
        
        return lbl
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(title)
        addSubview(subtitle)
        
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16).isActive = true
        subtitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        subtitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 35/255, alpha: 1)
        
        
    }
    
    override var isHighlighted: Bool {
        
        didSet {
            
            
        }
        
    }
    
    override var isSelected: Bool {
        
        didSet {
            
            self.backgroundColor = isSelected ? UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1) : UIColor(red: 33/255, green: 33/255, blue: 35/255, alpha: 1)
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UITextField {
func setIcon(_ image: UIImage) {
   
}
}
