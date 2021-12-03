//
//  IntroViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Firebase

class IntroViewController: UIViewController {
    
    
    let logoImage: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "job_crunch")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.alpha = 0
        
        return logo

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(logoImage)
        
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        
        animate()
        
    }
    
    func animate(){
        
        UIView.animate(withDuration: 3, animations: {
            
            self.logoImage.alpha = 1
            
        }) { (true) in
            
            self.perform(#selector(self.openHome), with: nil, afterDelay: 0.7)
            
        }
        
    }
    
    @objc func openHome(){
        
        if let user = Auth.auth().currentUser {
            
            let userRef = Database.database().reference().child("users").child(user.uid).child("info")
            
            userRef.observe(.value, with: {(snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    if let userimage = dict["location"] as? String {
                        
                    
                        let homeVC = HomeViewController()
                        
                        homeVC.modalPresentationStyle = .fullScreen
                        
                        self.present(homeVC, animated: true, completion: nil)
                        
                    }else {
                        
                        let pVC = PickLocationViewController()
                        
                        pVC.modalPresentationStyle = .fullScreen
                        
                        self.present(pVC, animated: true, completion: nil)
                        
                    }
                    
                }
                
            })
            
            /*let homeVC = HomeViewController()
            
            homeVC.modalPresentationStyle = .fullScreen
            
            present(homeVC, animated: true, completion: nil)*/
            
        }else {
            
            let vC = SignUpViewController()
            
            vC.modalPresentationStyle = .fullScreen
            
            present(vC, animated: true, completion: nil)
            
        }
        
    }

}
