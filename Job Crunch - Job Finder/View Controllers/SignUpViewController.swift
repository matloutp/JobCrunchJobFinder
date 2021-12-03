//
//  SignUpViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/21.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import Firebase

class SignUpViewController: UIViewController, UITextViewDelegate {

    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 430)
    
    let signUpLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Sign Up"
        
        lbl.font = .boldSystemFont(ofSize: 32)
        
        lbl.layer.zPosition = 3
        
        return lbl
        
    }()
    
    
    let topImageTheme: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        
        logo.layer.zPosition = 2
        
        return logo

    }()
    
    let fullName: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Full Name"
        
        let img = UIImage(named: "userProfile")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        txt.leftView = iconContainer
        txt.leftViewMode = .always
        
        return txt
        
    }()
    
    let email: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Email"
        
        let img = UIImage(named: "userMail")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        txt.leftView = iconContainer
        txt.leftViewMode = .always
        
        return txt
        
    }()
    
    let profession: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Profession, e.g: Lawyer"
        
        let img = UIImage(named: "userProfession")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        txt.leftView = iconContainer
        txt.leftViewMode = .always
        
        return txt
        
    }()
    
    let about: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "A short description about you"
        
        let img = UIImage(named: "userAbout")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        txt.leftView = iconContainer
        txt.leftViewMode = .always
        
        return txt
        
    }()
    
    let password: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Password"
        
        let img = UIImage(named: "userPassword")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        txt.leftView = iconContainer
        txt.leftViewMode = .always
        
        return txt
        
    }()
    
    lazy var createBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .black
        btn.setTitle("CREATE ACCOUNT", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.addTarget(self, action: #selector(loginRegister), for: .touchUpInside)
        
        
        return btn
    }()
    
    lazy var switchBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.setTitle("Already have an account ? Sign In", for: .normal)
        
        btn.setTitleColor(.lightGray, for: .normal)
        
        btn.addTarget(self, action: #selector(switchF), for: .touchUpInside)
        
        
        return btn
    }()
    
    let termsAndConditionsLbl: UITextView = {
        
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our ")
        let secondString = NSMutableAttributedString(string: "terms and conditions and ")
        secondString.addAttribute(.link, value: "https://www.garlictechnologies.co.za/terms.html", range: NSRange(location: 0, length: 20))
        
        let thirdString = NSMutableAttributedString(string: "privacy policy.")
        thirdString.addAttribute(.link, value: "https://www.garlictechnologies.co.za/privacy.html", range: NSRange(location: 0, length: 14))
        
        attributedString.append(secondString)
        attributedString.append(thirdString)
        

        lbl.attributedText = attributedString
        
        lbl.textAlignment = NSTextAlignment.center
        
        return lbl
    }()
    
    let loadingLoader: UIActivityIndicatorView = {
        
        let img = UIActivityIndicatorView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .black
        img.color = .white
        img.startAnimating()
        img.alpha = 0
        
        
        return img
        
    }()

    lazy var topScrollView: UIScrollView = {
        
        let sV = UIScrollView(frame: .zero)
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.backgroundColor = .clear
        sV.contentSize = contentSize
        sV.frame = self.view.bounds
        sV.layer.zPosition = 1
        
        
        return sV
        
    }()
    
    let loginContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .clear
        
        return vw
    }()
    
    lazy var scrollViewContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.frame.size = contentSize
        return vw
    }()
    
    lazy var candidateBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Candidate", for: .normal)
        
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        
        btn.addTarget(self, action: #selector(candidateF), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var employeeBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Employer", for: .normal)
        
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        
        btn.addTarget(self, action: #selector(employeeF), for: .touchUpInside)
        
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    func setup(){
        
        view.backgroundColor = .white
        view.addSubview(topScrollView)
        topScrollView.addSubview(loginContainer)
        
        loginContainer.addSubview(signUpLbl)
        loginContainer.addSubview(topImageTheme)
        loginContainer.addSubview(candidateBtn)
        loginContainer.addSubview(employeeBtn)
        
        loginContainer.addSubview(fullName)
        loginContainer.addSubview(email)
        loginContainer.addSubview(profession)
        loginContainer.addSubview(about)
        loginContainer.addSubview(password)
        loginContainer.addSubview(createBtn)
        loginContainer.addSubview(switchBtn)
        loginContainer.addSubview(termsAndConditionsLbl)
        
        loginContainer.addSubview(loadingLoader)
        
        topScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topScrollView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        topScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        //scrollViewContainer.centerXAnchor.constraint(equalTo: topScrollView.centerXAnchor).isActive = true
        //scrollViewContainer.centerYAnchor.constraint(equalTo: topScrollView.centerYAnchor).isActive = true
        
        loginContainer.centerXAnchor.constraint(equalTo: topScrollView.centerXAnchor).isActive = true
        loginContainer.heightAnchor.constraint(equalToConstant: view.frame.height + 180).isActive = true
        loginContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        bottomConstraint = loginContainer.centerYAnchor.constraint(equalTo: topScrollView.centerYAnchor, constant: 50)
        bottomConstraint?.isActive = true
        
        
        signUpLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 24).isActive = true
        signUpLbl.centerYAnchor.constraint(equalTo: loginContainer.centerYAnchor, constant:  -60).isActive = true
        signUpLbl.widthAnchor.constraint(equalTo: loginContainer.widthAnchor, constant: 24).isActive = true
        signUpLbl.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        topImageTheme.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        topImageTheme.topAnchor.constraint(equalTo: loginContainer.topAnchor).isActive = true
        topImageTheme.bottomAnchor.constraint(equalTo: signUpLbl.topAnchor).isActive = true
        topImageTheme.widthAnchor.constraint(equalToConstant: view.frame.width / 2.3).isActive = true
        
        candidateBtn.rightAnchor.constraint(equalTo: loginContainer.centerXAnchor, constant: -8).isActive = true
        candidateBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        candidateBtn.bottomAnchor.constraint(equalTo: signUpLbl.topAnchor, constant: -12).isActive = true
        candidateBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2.2).isActive = true
        
        employeeBtn.leftAnchor.constraint(equalTo: loginContainer.centerXAnchor, constant: 8).isActive = true
        employeeBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        employeeBtn.bottomAnchor.constraint(equalTo: signUpLbl.topAnchor, constant: -12).isActive = true
        employeeBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2.2).isActive = true
        
        fullName.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        fullName.topAnchor.constraint(equalTo: signUpLbl.bottomAnchor).isActive = true
        fullName.heightAnchor.constraint(equalToConstant: 45).isActive = true
        fullName.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        email.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        email.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 12).isActive = true
        email.heightAnchor.constraint(equalToConstant: 45).isActive = true
        email.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        profession.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        profession.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 12).isActive = true
        profession.heightAnchor.constraint(equalToConstant: 45).isActive = true
        profession.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        about.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        about.topAnchor.constraint(equalTo: profession.bottomAnchor, constant: 12).isActive = true
        about.heightAnchor.constraint(equalToConstant: 45).isActive = true
        about.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        password.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        password.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 12).isActive = true
        password.heightAnchor.constraint(equalToConstant: 45).isActive = true
        password.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        createBtn.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        createBtn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 12).isActive = true
        createBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
        createBtn.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        
        switchBtn.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        switchBtn.topAnchor.constraint(equalTo: createBtn.bottomAnchor, constant: 12).isActive = true
        switchBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        switchBtn.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        
        termsAndConditionsLbl.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        termsAndConditionsLbl.topAnchor.constraint(equalTo: switchBtn.bottomAnchor, constant: 12).isActive = true
        termsAndConditionsLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        termsAndConditionsLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        
        loadingLoader.centerXAnchor.constraint(equalTo: createBtn.centerXAnchor).isActive = true
        loadingLoader.centerYAnchor.constraint(equalTo: createBtn.centerYAnchor).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 35).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        termsAndConditionsLbl.delegate = self
        
    }
    
    var isCandidate = true
    
    @objc func candidateF(){
        
        isCandidate = true
        
        candidateBtn.backgroundColor = .black
        candidateBtn.setTitleColor(.white, for: .normal)
        
        employeeBtn.backgroundColor = .white
        employeeBtn.setTitleColor(.black, for: .normal)
        
        fullName.placeholder = "Full Name"
        
        let img = UIImage(named: "userProfile")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        fullName.leftView = iconContainer
        
        //
        
        profession.placeholder = "Profession, e.g: Lawyer"
        
        let img2 = UIImage(named: "userProfession")
        
        let iconView2 = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView2.image = img2!
        
        let iconContainer2: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer2.addSubview(iconView2)
        
        profession.leftView = iconContainer2
        
        about.placeholder = "A short description about you"
        
    }
    
    @objc func employeeF(){
        
        isCandidate = false
        
        candidateBtn.backgroundColor = .white
        candidateBtn.setTitleColor(.black, for: .normal)
        
        employeeBtn.backgroundColor = .black
        employeeBtn.setTitleColor(.white, for: .normal)
        
        fullName.placeholder = "Company Name"
        
        let img = UIImage(named: "companyProfile")
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView.image = img!
        
        let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer.addSubview(iconView)
        
        fullName.leftView = iconContainer
        
        //
        
        
        profession.placeholder = "Line of Business, e.g: Software Dev"
        
        let img2 = UIImage(named: "companyType")
        
        let iconView2 = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        
        iconView2.image = img2!
        
        let iconContainer2: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        
        iconContainer2.addSubview(iconView2)
        
        profession.leftView = iconContainer2
        
        about.placeholder = "A short description about your company"
        
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        
        return false
        
    }
    
    var register = true
    
    @objc func loginRegister(){
        
        if register == true {
            
            signUpF()
            
        }else {
            
            signInF()
            
        }
        
    }
    
    var uniqueId: String!
    
    @objc func signUpF(){
        
        loadingLoader.alpha = 1
        
        createBtn.setTitle("", for: .normal)
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            
            
            if error != nil {
                
                print(error)
                let alert = UIAlertController(title: "Registration Failed", message: "User already exists or password is too short.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                self.loadingLoader.alpha = 0
                
                self.createBtn.setTitle("CREATE ACCOUNT", for: .normal)
            
            }else {
                
                if Auth.auth().currentUser != nil {
                    
                    let user = Auth.auth().currentUser
                    
                    if let user = user {
                        
                        self.uniqueId = user.uid
                        
                        let itemReviewRef = Database.database().reference().child("users").child(self.uniqueId).child("info")
                        
                        var values = [String: String]()
                        
                        if self.isCandidate == true {
                            
                            values = ["userId": self.uniqueId, "profession": self.profession.text!.lowercased(), "email": self.email.text!, "fullName": self.fullName.text!, "phone": "unknown", "status": "live", "role": "candidate", "about": self.about.text!]
                            
                        }else {
                            
                            values = ["userId": self.uniqueId, "profession": self.profession.text!.lowercased(), "email": self.email.text!, "fullName": self.fullName.text!, "phone": "unknown", "status": "live", "role": "employee", "about": self.about.text!]
                            
                        }
                        
                        
                        
                        itemReviewRef.updateChildValues(values) {(error, reference) in
                            
                            if error != nil {
                                
                                let alert = UIAlertController(title: "Error", message: "There was a problem while trying to create your account. Please try again.", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                                self.present(alert, animated: true, completion: nil)
                                
                                self.loadingLoader.alpha = 0
                                self.createBtn.setTitle("CREATE ACCOUNT", for: .normal)
                                
                            }else {
                                
                                let profileVC = PickLocationViewController()
                                
                                profileVC.modalPresentationStyle = .fullScreen
                                
                                self.present(profileVC, animated: true, completion: nil)
                                
                            }
                        
                        }
                    
                    }
                
                }
            
            }
            
        }
        
        
    }
    
    
    @objc func signInF(){
        
        loadingLoader.alpha = 1
        
        createBtn.setTitle("", for: .normal)
        
        Auth.auth().signIn(withEmail: fullName.text!, password: email.text!) { authResult, error in
        
        if error == nil {
            
            //self.dismiss(animated: true, completion: nil)
            
            let profileVC = HomeViewController()
            
            profileVC.modalPresentationStyle = .fullScreen
            
            self.present(profileVC, animated: true, completion: nil)
            
            
        }else {
            
            let alert = UIAlertController(title: "Login Failed", message: "The was a problem while trying to log you in. Please make sure you entered the correct credentials.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            self.loadingLoader.alpha = 0
            self.createBtn.setTitle("Login", for: .normal)
        
        }
            
        }
        
        
    }
    
    @objc func switchF(){
        
        if register == true {
            
            createBtn.setTitle("LOGIN", for: .normal)
            
            switchBtn.setTitle("Don't have an account ? Sign Up", for: .normal)
            
            password.isHidden = true
            profession.isHidden = true
            about.isHidden = true
            
            let img = UIImage(named: "userMail")
            let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
            iconView.image = img!
            let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
            
            iconContainer.addSubview(iconView)
            
            fullName.leftView = iconContainer
            
            fullName.placeholder = "Email"
            
            let imgE = UIImage(named: "userPassword")
            let iconViewE = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
            iconViewE.image = imgE!
            let iconContainerE: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
            
            iconContainerE.addSubview(iconViewE)
            
            email.leftView = iconContainerE
            
            
            email.placeholder = "Password"
            
            
            
            register = false
        }else {
            
            createBtn.setTitle("CREATE ACCOUNT", for: .normal)
            
            switchBtn.setTitle("Already have an account ? Sign In", for: .normal)
            
            password.isHidden = false
            profession.isHidden = false
            about.isHidden = false
            
            let img = UIImage(named: "userProfile")
            let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
            iconView.image = img!
            let iconContainer: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
            
            iconContainer.addSubview(iconView)
            
            fullName.leftView = iconContainer
            
            fullName.placeholder = "Full Name"
            
            let imgE = UIImage(named: "userMail")
            let iconViewE = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
            iconViewE.image = imgE!
            let iconContainerE: UIView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
            
            iconContainerE.addSubview(iconViewE)
            
            email.placeholder = "Email"
            
            register = true
        }
        
    }


}
