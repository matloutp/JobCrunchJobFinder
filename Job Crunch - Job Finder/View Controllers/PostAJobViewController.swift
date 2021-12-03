//
//  PostAJobViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/19.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import iOSDropDown
import SkyFloatingLabelTextField
import Firebase
import Loaf

class PostAJobViewController: UIViewController {
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 430)
    
    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear
        
        let img = UIImage(named: "left-arrow")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(backF), for: .touchUpInside)
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let jobSubmissionLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Job Submission Form", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = UIFont(name:"Copperplate", size: 21.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()
    
    let jobTitleValue: SkyFloatingLabelTextField = {
        
        let txt = SkyFloatingLabelTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Job Title"
        txt.title = "Job Title"
        
        return txt
    }()
    
    let jobTypeValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Select job type"
        
        return lbl
    }()
    
    let jobLocationValue: SkyFloatingLabelTextField = {
        
        let txt = SkyFloatingLabelTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Location"
        txt.title = "Location"
        
        return txt
    }()
    
    let salaryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Salary (p/m)"
        
        return lbl
        
    }()
    
    let minSalaryValue: SkyFloatingLabelTextField = {
        
        let txt = SkyFloatingLabelTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Min Salary"
        txt.title = "Min Salary"
        
        return txt
    }()
    
    let maxSalaryValue: SkyFloatingLabelTextField = {
        
        let txt = SkyFloatingLabelTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Max Salry"
        txt.title = "Max Salary"
        
        return txt
    }()
    
    let tagsLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Tags (optional)"
        
        return lbl
        
    }()
    
    let tagsValue: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "separate each tag by a comma, e.g: designer, creative"
        
        return txt
    }()
    
    let jobDescriptionValue: SkyFloatingLabelTextField = {
        
        let txt = SkyFloatingLabelTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Job Description"
        txt.title = "Job Description"
        
        return txt
    }()
    
    let jobResponsibilitiesValue: SkyFloatingLabelTextField = {
        
        let txt = SkyFloatingLabelTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Job Responsibilities"
        txt.title = "Job Responsibilities"
        
        return txt
    }()
    
    lazy var postJobBtn: UIButton = {
           
           let btn = UIButton()
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.layer.masksToBounds = false
           btn.layer.cornerRadius = 21
           btn.backgroundColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
           
           btn.setTitle("Post Job", for: .normal)
           
           btn.setTitleColor(.white, for: .normal)
           
           btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
           
           btn.addTarget(self, action: #selector(postJobF), for: .touchUpInside)
           
           //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
           
           /*btn.layer.shadowOffset = .zero
           btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
           btn.layer.shadowRadius = 10
           btn.layer.shadowOpacity = 0.5
           btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
           
           btn.layer.zPosition = 2
           
           return btn
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
        
        
        
        return vw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseArticleDropDown
        ]
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(topScrollView)
        topScrollView.addSubview(loginContainer)
        
        loginContainer.addSubview(backBtn)
        loginContainer.addSubview(jobSubmissionLbl)
        loginContainer.addSubview(jobTitleValue)
        loginContainer.addSubview(jobLocationValue)
        loginContainer.addSubview(salaryLbl)
        loginContainer.addSubview(minSalaryValue)
        loginContainer.addSubview(maxSalaryValue)
        loginContainer.addSubview(tagsLbl)
        loginContainer.addSubview(tagsValue)
        loginContainer.addSubview(jobDescriptionValue)
        loginContainer.addSubview(jobResponsibilitiesValue)
        loginContainer.addSubview(postJobBtn)
        //view.addSubview(jobTypeValue)
        
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
        
        backBtn.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: loginContainer.topAnchor, constant: 45).isActive = true
        
        jobSubmissionLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        jobSubmissionLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobSubmissionLbl.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -12).isActive = true
        jobSubmissionLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
        
        jobTitleValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        jobTitleValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobTitleValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        jobTitleValue.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 12).isActive = true
        
        jobTitleValue.selectedTitleColor = .black
        jobLocationValue.selectedTitleColor = .black
        minSalaryValue.selectedTitleColor = .black
        maxSalaryValue.selectedTitleColor = .black
        jobDescriptionValue.selectedTitleColor = .black
        jobResponsibilitiesValue.selectedTitleColor = .black
        
        view.addSubview(chooseArticleDropDown)
        
        chooseArticleDropDown.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        chooseArticleDropDown.heightAnchor.constraint(equalToConstant: 35).isActive = true
        chooseArticleDropDown.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        chooseArticleDropDown.topAnchor.constraint(equalTo: jobTitleValue.bottomAnchor, constant: 24).isActive = true
        
        view.addSubview(jobCategoryDropDown)
        
        jobCategoryDropDown.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        jobCategoryDropDown.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobCategoryDropDown.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        jobCategoryDropDown.topAnchor.constraint(equalTo: chooseArticleDropDown.bottomAnchor, constant: 24).isActive = true
        
        jobLocationValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        jobLocationValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobLocationValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        jobLocationValue.topAnchor.constraint(equalTo: jobCategoryDropDown.bottomAnchor, constant: 24).isActive = true
        
        salaryLbl.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        salaryLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        salaryLbl.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        salaryLbl.topAnchor.constraint(equalTo: jobLocationValue.bottomAnchor, constant: 24).isActive = true
        
        minSalaryValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        minSalaryValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        minSalaryValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        minSalaryValue.topAnchor.constraint(equalTo: salaryLbl.bottomAnchor, constant: 24).isActive = true
        
        maxSalaryValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        maxSalaryValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        maxSalaryValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        maxSalaryValue.topAnchor.constraint(equalTo: minSalaryValue.bottomAnchor, constant: 24).isActive = true
        
        tagsLbl.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        tagsLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        tagsLbl.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        tagsLbl.topAnchor.constraint(equalTo: maxSalaryValue.bottomAnchor, constant: 24).isActive = true
        
        tagsValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        tagsValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        tagsValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        tagsValue.topAnchor.constraint(equalTo: tagsLbl.bottomAnchor, constant: 24).isActive = true
        
        jobDescriptionValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        jobDescriptionValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobDescriptionValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        jobDescriptionValue.topAnchor.constraint(equalTo: tagsValue.bottomAnchor, constant: 24).isActive = true
        
        jobResponsibilitiesValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        jobResponsibilitiesValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobResponsibilitiesValue.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        jobResponsibilitiesValue.topAnchor.constraint(equalTo: jobDescriptionValue.bottomAnchor, constant: 24).isActive = true
        
        postJobBtn.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 24).isActive = true
        postJobBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        postJobBtn.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -24).isActive = true
        postJobBtn.topAnchor.constraint(equalTo: jobResponsibilitiesValue.bottomAnchor, constant: 46).isActive = true
        
        /*jobTypeValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        jobTypeValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobTypeValue.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        jobTypeValue.topAnchor.constraint(equalTo: jobTitleValue.bottomAnchor, constant: 12).isActive = true*/
        
        setupDropDowns()
        
        getUserInfo()
        
        
    }
    
    var uniqueId: String!
    var employerName: String!
    var profileImageUrl: String!
    var employerEmail: String!
    var employerLocation: String!
    
    @objc func getUserInfo(){
        
        if let user = Auth.auth().currentUser {
            
            self.uniqueId = user.uid
            
            let userRef = Database.database().reference().child("users").child(self.uniqueId).child("info")
            
            userRef.observe(.value, with: {(snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    if let companyName = dict["fullName"] as? String {
                        
                        self.employerName = companyName
                    }
                    
                    if let image = dict["profileImageUrl"] as? String {
                        
                        self.profileImageUrl = image
                        
                    }
                    
                    if let email = dict["email"] as? String {
                        
                        self.employerEmail = email
                        
                    }
                    
                    if let location = dict["location"] as? String {
                        
                        self.employerLocation = location
                        self.jobLocationValue.text = location
                    }
                    
                }
                
            })
            
        }
        
        
    }
    
    
    
    @objc func postJobF(){
        
        
        if jobTitleValue.text! == "" || chooseArticleDropDown.text! == "" || jobCategoryDropDown.text! == "" || minSalaryValue.text == "" || maxSalaryValue.text == "" || jobDescriptionValue.text == "" || jobResponsibilitiesValue.text == ""{
            
            Loaf("Error posting job. Please fill in all fields.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
            
            return
        }
        
        let date = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        let year =  components.year!
        let month = components.month!
        let day = components.day!
        
        let finalDate = "\(day)/\(month)/\(year)"
        
        
        
        let jobRef = Database.database().reference().child("jobs")
        
        let jobKey = NSUUID().uuidString
        
        let values = ["jobJey": jobKey, "datePosted": finalDate, "employerEmail": self.employerEmail, "employerName": self.employerName, "jobCategory": self.jobCategoryDropDown.text!, "jobCity": "New York", "jobDescription": jobDescriptionValue.text!, "profileImageUrl": self.profileImageUrl, "jobLat": 0.0, "jobLng": 0.0, "jobLocation": self.employerLocation, "jobResponsibilities": self.jobResponsibilitiesValue.text!, "jobTitle": jobTitleValue.text!.capitalized, "jobType": chooseArticleDropDown.text!.capitalized, "keywords": tagsValue.text!, "maxSalary": maxSalaryValue.text!.capitalized, "minSalary": minSalaryValue.text!.capitalized, "numberOfCandidates": 0, "userId": self.uniqueId] as [String : Any]
        
        jobRef.child(jobKey).updateChildValues(values) {(error, reference) in
            
            if error != nil {
                
                Loaf("Error posting job. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                
            
            }else {
                
                //success
                //Loaf("Success", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                
                let jobsVC = CompanyJobsViewController()
                jobsVC.modalPresentationStyle = .fullScreen
                jobsVC.key = self.uniqueId
                
                self.present(jobsVC, animated: true, completion: nil)
                
                
            }
        
        }
        
    }
    
    let chooseArticleDropDown : DropDown = {
        
        let dd = DropDown(frame: .zero)
        dd.translatesAutoresizingMaskIntoConstraints = false
        dd.placeholder = "Job Type"
        
        return dd
        
    }()
    
    let jobCategoryDropDown : DropDown = {
        
        let dd = DropDown(frame: .zero)
        dd.translatesAutoresizingMaskIntoConstraints = false
        dd.placeholder = "Job Category"
        dd.layer.zPosition = 10
        
        return dd
        
    }()
    
    func setupDropDowns() {
        
        setupChooseArticleDropDown()
        setupJobCategoryDropDown()
    }
    
    func setupChooseArticleDropDown() {
        
        
        
        chooseArticleDropDown.optionArray = ["Full time", "Part time", "Remote"]
        // Its Id Values and its optional
        chooseArticleDropDown.optionIds = [1,23,54,22]
        // Image Array its optional
        //chooseArticleDropDown.ImageArray = [👩🏻‍🦳,🙊,🥞]

        // The the Closure returns Selected Index and String
        chooseArticleDropDown.didSelect{(selectedText , index ,id) in
        self.jobTypeValue.text = selectedText
            }
        
    }
    
    func setupJobCategoryDropDown(){
        
        
        jobCategoryDropDown.optionArray = ["Web & Software Dev", "Data Science & Analytics", "Accounting & Finance", "Sales & Marketing", "Graphics & Design", "Digital Marketing", "Clerical & Data Entry", "Education & Training", "Engineering", "Management", "Other"]
        // Its Id Values and its optional
        jobCategoryDropDown.layer.zPosition = 10
        jobCategoryDropDown.optionIds = [1,23,54,22, 13, 16, 18, 19, 20, 21, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]
        // Image Array its optional
        //chooseArticleDropDown.ImageArray = [👩🏻‍🦳,🙊,🥞]

        // The the Closure returns Selected Index and String
        jobCategoryDropDown.didSelect{(selectedText , index ,id) in
            
            //self.jobTypeValue.text = selectedText
        
        }
    }
    
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }

}
