//
//  AboutJobViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/19.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import Firebase
import PopupDialog
import KYCircularProgress
import MobileCoreServices
import Loaf

class AboutJobViewController: UIViewController, UIDocumentPickerDelegate {
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 430)
    
    var key: String!
    
    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
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
    

    
    let companyLogo: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "microsoft")
        
        return img
    }()
    
    let jobTitleValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Product Designer"
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .boldSystemFont(ofSize: 28)
        
        return lbl
    }()
    
    
    let companyName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Microsoft Inc."
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .boldSystemFont(ofSize: 19)
        
        return lbl
    }()
    
    let companyAddress: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "1600 Amphitheatre Parkway, Mountain View"
        lbl.numberOfLines = 2
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .systemFont(ofSize: 16)
        
        return lbl
    }()
    
    let jobDescriptionLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Job Description"
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.font = .boldSystemFont(ofSize: 21)
        
        return lbl
    }()
    
    let jobDescriptionValueLbl: UITextView = {
        
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = false
        lbl.text = "..."
        lbl.backgroundColor = .clear
        lbl.textAlignment = NSTextAlignment.left
        lbl.textColor = .gray
        lbl.font = .systemFont(ofSize: 21)
        
        return lbl
    }()
    
    let jobResponsibilitiesLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Responsibilities"
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.font = .boldSystemFont(ofSize: 21)
        
        return lbl
    }()
    
    let jobResponsibilitiesValueLbl: UITextView = {
        
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = false
        lbl.text = "...."
        lbl.textAlignment = NSTextAlignment.left
        lbl.textColor = .gray
        lbl.font = .systemFont(ofSize: 21)
        lbl.backgroundColor = .clear
        
        return lbl
    }()
    
    var applyView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        vw.layer.zPosition = 10
        
        return vw
    }()
    
    lazy var applyForJobBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 21
        btn.backgroundColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Apply Now", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(applyF), for: .touchUpInside)
        
        //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 11
        
        return btn
    }()

    let jobSalaryValueLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = ""
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .systemFont(ofSize: 32)
        
        lbl.layer.zPosition = 11
        
        return lbl
    }()
    
    let jobPositionValueLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = ""
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.font = .boldSystemFont(ofSize: 32)
        
        lbl.layer.zPosition = 11
        
        return lbl
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
    lazy var scrollViewContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.frame.size = contentSize
        return vw
    }()
    
    var uploadBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .black
        
        vw.alpha = 0.6
        
        vw.layer.zPosition = 12
        
        vw.isHidden = true
        
        return vw
    }()
    
    var progressBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 8
        
        vw.layer.zPosition = 12
        
        vw.isHidden = true
        
        
        return vw
    }()
    
    let progressLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black
        
        lbl.textAlignment = NSTextAlignment.center
        
        return lbl
    }()
    
    lazy var cancelUploadBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 18
        btn.backgroundColor = .clear//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Cancel", for: .normal)
        
        btn.setTitleColor(.black, for: .normal)
        
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(cancelF), for: .touchUpInside)
        
        //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 12
        
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    var descriptionConstraint: NSLayoutConstraint?
    var responsibilitiesConstraint: NSLayoutConstraint?
    
    
    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(topScrollView)
        topScrollView.addSubview(loginContainer)
        
        loginContainer.addSubview(backBtn)
        loginContainer.addSubview(companyLogo)
        loginContainer.addSubview(jobTitleValue)
        loginContainer.addSubview(companyName)
        loginContainer.addSubview(companyAddress)
        loginContainer.addSubview(jobDescriptionLbl)
        loginContainer.addSubview(jobDescriptionValueLbl)
        loginContainer.addSubview(jobResponsibilitiesLbl)
        loginContainer.addSubview(jobResponsibilitiesValueLbl)
        
        view.addSubview(applyView)
        view.addSubview(applyForJobBtn)
        
        view.addSubview(jobSalaryValueLbl)
        view.addSubview(jobPositionValueLbl)
        
        view.addSubview(uploadBackground)
        view.addSubview(progressBackground)
        
        progressBackground.addSubview(cancelUploadBtn)
        
        topScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topScrollView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        topScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        loginContainer.centerXAnchor.constraint(equalTo: topScrollView.centerXAnchor).isActive = true
        loginContainer.heightAnchor.constraint(equalToConstant: view.frame.height + 180).isActive = true
        loginContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        bottomConstraint = loginContainer.centerYAnchor.constraint(equalTo: topScrollView.centerYAnchor, constant: 50)
        bottomConstraint?.isActive = true
        
        
        backBtn.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: loginContainer.topAnchor, constant: 45).isActive = true
        
        companyLogo.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor, constant: 0).isActive = true
        companyLogo.heightAnchor.constraint(equalToConstant: 135).isActive = true
        companyLogo.widthAnchor.constraint(equalToConstant: 135).isActive = true
        companyLogo.topAnchor.constraint(equalTo: loginContainer.topAnchor, constant: 95).isActive = true
        
        jobTitleValue.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor, constant: 0).isActive = true
        jobTitleValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobTitleValue.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        jobTitleValue.topAnchor.constraint(equalTo: companyLogo.bottomAnchor, constant: 12).isActive = true
        
        companyName.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor, constant: 0).isActive = true
        companyName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        companyName.widthAnchor.constraint(equalToConstant: 135).isActive = true
        companyName.topAnchor.constraint(equalTo: jobTitleValue.bottomAnchor, constant: 12).isActive = true
        
        companyAddress.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor, constant: 0).isActive = true
        companyAddress.heightAnchor.constraint(equalToConstant: 35).isActive = true
        companyAddress.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        companyAddress.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 12).isActive = true
        
        jobDescriptionLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 36).isActive = true
        jobDescriptionLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobDescriptionLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        jobDescriptionLbl.topAnchor.constraint(equalTo: companyAddress.bottomAnchor, constant: 12).isActive = true
        
        jobDescriptionValueLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 36).isActive = true
        descriptionConstraint = jobDescriptionValueLbl.heightAnchor.constraint(equalToConstant: 100)
        descriptionConstraint?.isActive = true
        jobDescriptionValueLbl.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -36).isActive = true
        jobDescriptionValueLbl.topAnchor.constraint(equalTo: jobDescriptionLbl.bottomAnchor, constant: 12).isActive = true
        
        jobResponsibilitiesLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 36).isActive = true
        jobResponsibilitiesLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        jobResponsibilitiesLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        jobResponsibilitiesLbl.topAnchor.constraint(equalTo: jobDescriptionValueLbl.bottomAnchor, constant: 12).isActive = true
        
        jobResponsibilitiesValueLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 36).isActive = true
        responsibilitiesConstraint = jobResponsibilitiesValueLbl.heightAnchor.constraint(equalToConstant: 100)
        responsibilitiesConstraint?.isActive = true
        jobResponsibilitiesValueLbl.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -36).isActive = true
        jobResponsibilitiesValueLbl.topAnchor.constraint(equalTo: jobResponsibilitiesLbl.bottomAnchor, constant: 12).isActive = true
        
        applyView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        applyView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        applyView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        applyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        applyForJobBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        applyForJobBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        applyForJobBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        applyForJobBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        
        jobSalaryValueLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        jobSalaryValueLbl.heightAnchor.constraint(equalToConstant: 75).isActive = true
        jobSalaryValueLbl.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
        jobSalaryValueLbl.bottomAnchor.constraint(equalTo: applyForJobBtn.topAnchor, constant: -12).isActive = true
        
        jobPositionValueLbl.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
        jobPositionValueLbl.heightAnchor.constraint(equalToConstant: 75).isActive = true
        jobPositionValueLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        jobPositionValueLbl.bottomAnchor.constraint(equalTo: applyForJobBtn.topAnchor, constant: -12).isActive = true
        
        uploadBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadBackground.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        uploadBackground.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        uploadBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        progressBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBackground.heightAnchor.constraint(equalToConstant: 350).isActive = true
        progressBackground.widthAnchor.constraint(equalToConstant: 350).isActive = true
        progressBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        cancelUploadBtn.leftAnchor.constraint(equalTo: progressBackground.leftAnchor, constant: 12).isActive = true
        cancelUploadBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
        cancelUploadBtn.rightAnchor.constraint(equalTo: progressBackground.rightAnchor, constant: -12).isActive = true
        cancelUploadBtn.bottomAnchor.constraint(equalTo: progressBackground.bottomAnchor, constant: -12).isActive = true
        
        fetchJob()
        
        getUserInfo()
        
    }
    
    var employerKey: String!
    var uniqueId: String!
    
    var userName: String!
    var userEmail: String!
    
    var userProfileImageUrl: String!
    
    @objc func getUserInfo(){
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            self.uniqueId = user.uid
            
            let userRef = Database.database().reference().child("users").child(self.uniqueId).child("info")
            
            userRef.observe(.value, with: {(snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    if let userCV = dict["userCV"] as? String {
                        
                        self.hasCV = true
                        
                        self.userCV = userCV
                        
                    }
                    
                    if let email = dict["email"] as? String {
                        
                        self.userEmail = email
                        
                    }
                    
                    if let name = dict["fullName"] as? String {
                        
                        self.userName = name
                        
                    }
                    
                    if let image = dict["profileImageUrl"] as? String {
                        
                        self.userProfileImageUrl = image
                        
                    }
                    
                    
                }
                
            })
            
        }
    }
    
    var userCV: String!
    var hasCV = false
    
    var extraHeight = 78
    
    @objc func fetchJob(){
        
        let jobRef = Database.database().reference().child("jobs").child(key)
        
        jobRef.observe(.value, with: {(snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject] {
                
                
                if let jobTitle = dict["jobTitle"] as? String {
                    
                    self.jobTitleValue.text = jobTitle
                }
                
                if let jobLocation = dict["jobLocation"] as? String {
                    
                    self.companyAddress.text = jobLocation
                }
                
                if let employerName = dict["employerName"] as? String {
                    
                    self.companyName.text = employerName
                }
                
                if let companyKey = dict["userId"] as? String {
                    
                    self.employerKey = companyKey
                    
                    
                    self.fetchCompanyInfo(userId: companyKey)
                }
                
                if let jobDescription = dict["jobDescription"] as? String {
                    
                    var jobDesrc = jobDescription
                    
                    jobDesrc = jobDesrc.replacingOccurrences(of: "<br>", with: "")
                    
                    self.jobDescriptionValueLbl.text = jobDesrc
                    
                    
                    var height: CGFloat = 80
                    
                    height = self.estimatedFrameForText(text: jobDescription).height + CGFloat(self.extraHeight)
                    
                    self.descriptionConstraint?.constant = height
                    
                    
                }
                
                if let jobResponsibilities = dict["jobResponsibilities"] as? String {
                    
                    self.jobResponsibilitiesValueLbl.text = jobResponsibilities
                    
                    var height: CGFloat = 80
                    
                    height = self.estimatedFrameForText(text: jobResponsibilities).height + CGFloat(self.extraHeight)
                    
                    self.responsibilitiesConstraint?.constant = height
                }
                
                if let jobSalary = dict["maxSalary"] as? String {
                    
                    self.jobSalaryValueLbl.text = "$ " + jobSalary
                }
                
                if let jobPosition = dict["jobType"] as? String {
                    
                    self.jobPositionValueLbl.text = jobPosition
                }
                
                if let userProfile = dict["profileImageUrl"] as? String {
                    
                    self.companyLogo.sd_setImage(with: URL(string: userProfile), placeholderImage: UIImage(named: "job_crunch"))
                }
                
                
            }
            
        })
        
    }
    
    private func estimatedFrameForText(text: String) -> CGRect {
        
        let size = CGSize(width: 200, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    @objc func fetchCompanyInfo(userId: String){
        
        let companyRef = Database.database().reference().child("users").child(userId).child("info")
        
        companyRef.observe(.value, with: {(snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject] {
                
                
                
                if let userCV = dict["userCV"] as? String {
                    
                    self.hasCV = true
                    
                    self.userCV = userCV
                    
                }
                
            }
            
        })
        
    }
    
    
    private var halfCircularProgress: KYCircularProgress!
    
    @objc func applyF(){
        
        if hasCV == false {
            
            //send cv:
            
            // Prepare the popup assets
            let title = "Upload CV"
            let message = "You need to have your CV uploaded to be able to apply for a job"
            let image = UIImage(named: "upload")

            // Create the dialog
            let popup = PopupDialog(title: title, message: message, image: image)

            // Create buttons
            let buttonOne = CancelButton(title: "CANCEL") {
                print("You canceled the car dialog.")
            }

            // This button will not the dismiss the dialog
            let buttonTwo = DefaultButton(title: "Upload CV", dismissOnTap: true) {
                
                let types: [String] = [kUTTypePDF as String]
                self.documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
                self.documentPicker.delegate = self
                self.documentPicker.modalPresentationStyle = .formSheet
                self.documentPicker.allowsMultipleSelection = false
                self.present(self.documentPicker, animated: true, completion: nil)
                    
                
                /**/
                
            }
            
            // Add buttons to dialog
            // Alternatively, you can use popup.addButton(buttonOne)
            // to add a single button
            popup.addButtons([buttonOne, buttonTwo])

            // Present dialog
            self.present(popup, animated: true, completion: nil)
            
        }else {
            
            //apply
            
            let applyRef = Database.database().reference().child("users").child(self.employerKey).child("candidates")
            
            let applicationKey = NSUUID().uuidString
            
            let values = ["applicationKey": applicationKey, "candidateCV": self.userCV, "candidateEmail": self.userEmail, "candidateId": self.uniqueId, "candidateName": self.userName, "jobKey": self.key, "jobTitle": jobTitleValue.text!, "profileImageUrl": self.userProfileImageUrl] as [String : Any]
            
            applyRef.child(applicationKey).updateChildValues(values) {(error, reference) in
                
                if error != nil {
                    
                    Loaf("Error applying for job. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                    
                
                }else {
                    
                    //success
                    Loaf("Successfully applied for job. Wait for a response from the employer.", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                    
                }
            
            }
        }
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
         // you get from the urls parameter the urls from the files selected
        
        let newUrls = urls.compactMap { (url: URL) -> URL? in
            // Create file URL to temporary folder
            var tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
            // Apend filename (name+extension) to URL
            tempURL.appendPathComponent(url.lastPathComponent)
            do {
                // If file with same name exists remove it (replace file with new one)
                if FileManager.default.fileExists(atPath: tempURL.path) {
                    try FileManager.default.removeItem(atPath: tempURL.path)
                }
                // Move file from app_id-Inbox to tmp/filename
                try FileManager.default.moveItem(atPath: url.path, toPath: tempURL.path)
                return tempURL
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        // ... do something with URLs
        
        self.uploadBackground.isHidden = false
        self.progressBackground.isHidden = false
        
        self.configureHalfCircularProgress()
        
        uploadCVDocument(url: newUrls.first!)
    }
    
    var documentPicker: UIDocumentPickerViewController!
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
        
        //Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true)
        
        
    }
    
    func uploadCVDocument(url: URL){
        
        let fileName = NSUUID().uuidString
        
        //loadingLoader.alpha = 1
        
        let storageRef = Storage.storage().reference().child("resumes").child("\(fileName)")
        
        
        let uploadTask = storageRef.putFile(from: url, metadata: nil) { (mdata, error) in
            
            if error != nil {
                
            
            }else {
                
                storageRef.downloadURL { (url, error) in
                    
                    guard let downloadURL = url else {
                        
                        self.uploadBackground.isHidden = true
                        self.progressBackground.isHidden = true
                        // Uh-oh, an error occurred!
                        Loaf("Error uploading file. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                        
                        return
                    
                    }
                    
                    let itemReviewRef = Database.database().reference().child("users").child(self.uniqueId).child("info")
                    
                    let values = ["userCV": downloadURL.absoluteString]
                    
                    itemReviewRef.updateChildValues(values) {(error, reference) in
                        
                        if error != nil {
                            
                            self.uploadBackground.isHidden = true
                            self.progressBackground.isHidden = true
                            
                            Loaf("Error saving file. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                            
                            self.uploadBackground.isHidden = true
                            self.progressBackground.isHidden = true
                            //failure
                        
                        }else {
                            
                            //success
                            Loaf("File uploaded. You can now apply for a job", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                            
                            self.uploadBackground.isHidden = true
                            self.progressBackground.isHidden = true
                            
                            self.hasCV = true
                            self.userCV = downloadURL.absoluteString
                        
                        }
                    
                    }
                
                }
                
            }
        }
        
        let observer = uploadTask.observe(.progress) { snapshot in
            
            self.progress = self.progress &+ 1
            let normalizedProgress = Double(self.progress) / Double(UInt8.max)
            
            self.halfCircularProgress.progress = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        }
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        documentPicker.dismiss(animated: true, completion: nil)
    }
    
    
    private func configureHalfCircularProgress() {
        
        halfCircularProgress = KYCircularProgress(frame: CGRect(x: -35, y: 0, width: view.frame.width, height: view.frame.height/2), showGuide: true)
        
        let center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 4)
        
        halfCircularProgress.path = UIBezierPath(arcCenter: center, radius: CGFloat((halfCircularProgress.frame).width/3), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        halfCircularProgress.strokeStart = 0.5
        halfCircularProgress.colors = [UIColor.black, UIColor.black, UIColor.black, UIColor.black]
        halfCircularProgress.guideColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
      
        let labelWidth = CGFloat(80.0)
        let textLabel = UILabel(frame: CGRect(x: (view.frame.width - labelWidth) / 2, y: (view.frame.height - labelWidth) / 4, width: labelWidth, height: 32.0))
        textLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        halfCircularProgress.addSubview(textLabel)

        halfCircularProgress.progressChanged {
            (progress: Double, circularProgress: KYCircularProgress) in
            print("progress: \(progress)")
            textLabel.text = "\(Int(progress * 100.0))%"
        }
        
        progressBackground.addSubview(halfCircularProgress)
    }
    
    private var progress: UInt8 = 0
    private var animationProgress: UInt8 = 0
    
    @objc private func updateProgress() {
        progress = progress &+ 1
        let normalizedProgress = Double(progress) / Double(UInt8.max)
        
        halfCircularProgress.progress = normalizedProgress
    }
    
    @objc func cancelF(){
        
        uploadBackground.isHidden = true
        progressBackground.isHidden = true
        
        print("h")
        
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }

}

extension AboutJobViewController: KYCircularProgressDelegate {
    func progressChanged(progress: Double, circularProgress: KYCircularProgress) {
        
        
        progressLbl.text = "\(Int(progress * 100.0))%"
    }
}
