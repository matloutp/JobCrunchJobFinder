//
//  CandidatesCollectionViewCell.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/20.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit

class CandidatesCollectionViewCell: UICollectionViewCell {
    
    var candidateVC: CandidatesViewController?
    
    let background: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 12
        
        return vw
    }()
    
    let jobTitleValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Product Designer"
        lbl.font = .systemFont(ofSize: 19)
        
        return lbl
    }()
    
    let candidateName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "John Cavell"
        lbl.font = .boldSystemFont(ofSize: 21)
        
        return lbl
    }()
    
    let profileImageView: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "professional_woman")
        
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 25
    
        return img
    }()
    
    lazy var messageBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "paper-plane")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(messageF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var deleteBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(deleteF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(background)
        addSubview(profileImageView)
        addSubview(candidateName)
        addSubview(deleteBtn)
        addSubview(messageBtn)
        addSubview(jobTitleValue)
        
        
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        candidateName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        candidateName.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 0).isActive = true
        candidateName.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        candidateName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        deleteBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        deleteBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        deleteBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deleteBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        messageBtn.rightAnchor.constraint(equalTo: deleteBtn.leftAnchor, constant: -8).isActive = true
        messageBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        messageBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        messageBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        jobTitleValue.rightAnchor.constraint(equalTo: messageBtn.leftAnchor, constant: -12).isActive = true
        jobTitleValue.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0).isActive = true
        jobTitleValue.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        jobTitleValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        
    }
    
    @objc func messageF(){
        
        candidateVC?.messageCandidateF(cell: self)
        
    }
    
    @objc func deleteF(){
        
        candidateVC?.deleteCandidateF(cell: self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
