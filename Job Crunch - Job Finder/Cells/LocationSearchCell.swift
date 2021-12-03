//
//  LocationSearchCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/21.
//  Copyright © 2020 Thapelo. All rights reserved.
//


import UIKit

class LocationSearchCell: UICollectionViewCell {
    
    let background: UIView = {
              
              let vw = UIView()
              vw.translatesAutoresizingMaskIntoConstraints = false
              vw.backgroundColor = .white
              
              
              return vw
              
          }()
          
          let searchValue: UILabel = {
              
              let lbl = UILabel()
              lbl.translatesAutoresizingMaskIntoConstraints = false
              lbl.text = "PlayStation 4"
              lbl.textColor = .black
              lbl.backgroundColor = .white
              lbl.font = UIFont(name: "Avenir-Medium", size: 18)
              
              return lbl
              
          }()
       
       let searchValueTwo: UILabel = {
           
           let lbl = UILabel()
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.text = "PlayStation 4"
           lbl.textColor = .black
           lbl.backgroundColor = .white
           lbl.font = UIFont(name: "Avenir-Medium", size: 18)
           
           return lbl
           
       }()
          
          let line: UIView = {
              
              let lne = UIView()
              lne.translatesAutoresizingMaskIntoConstraints = false
              lne.backgroundColor = .lightGray
              
              return lne
              
          }()
          
          
          override init(frame: CGRect) {
              super.init(frame: frame)
              
              setup()
              
          }
          
          required init?(coder aDecoder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
          
          func setup(){
              
              addSubview(background)
              addSubview(line)
              addSubview(searchValue)
           addSubview(searchValueTwo)
              
              background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
              background.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
              background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
              background.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
              
              line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
              line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
              line.heightAnchor.constraint(equalToConstant: 1).isActive = true
              line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
              
              searchValue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
              searchValue.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
              searchValue.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
           searchValue.heightAnchor.constraint(equalToConstant: 30).isActive = true
           
           searchValueTwo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
              searchValueTwo.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
              searchValueTwo.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
           searchValueTwo.bottomAnchor.constraint(equalTo: line.topAnchor).isActive = true
              
          }
          
}

