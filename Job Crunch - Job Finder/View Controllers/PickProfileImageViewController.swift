//
//  PickProfileImageViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/21.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import CropViewController
import Firebase
import NVActivityIndicatorView
import Loaf

class PickProfileImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    var cropViewController: CropViewController!

    let startLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Profile"
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = .boldSystemFont(ofSize: 32)
        
        lbl.layer.zPosition = 3
        
        return lbl
        
    }()
    
    let locationImage: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "profile_icon")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        
        logo.layer.zPosition = 2
        
        return logo

    }()
    
    lazy var pickImageBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .black//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("Pick Image", for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(pickImageF), for: .touchUpInside)
        
        //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var skipBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .clear//UIColor(red: 237/255, green: 62/255, blue: 116/255, alpha: 1)
        
        btn.setTitle("skip", for: .normal)
        
        btn.setTitleColor(.gray, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        btn.addTarget(self, action: #selector(skipF), for: .touchUpInside)
        
        //btn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        /*btn.layer.shadowOffset = .zero
        btn.layer.shadowColor = UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1).cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 10)*/
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    let chooseLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.text = "Improve your chances of being discovered by providing a profile picture"
        
        lbl.numberOfLines = 3
        
        lbl.font = .systemFont(ofSize: 21)
        
        return lbl
    }()
    

    var loadingLoader: NVActivityIndicatorView = {
        
        let loader = NVActivityIndicatorView(frame: .zero)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.type = .ballScaleMultiple
        loader.tintColor = .black//UIColor.init(red: 255/255, green: 1/255, blue: 73/255, alpha: 1)
        loader.color = .black//UIColor.init(red: 255/255, green: 1/255, blue: 73/255, alpha: 1)
        
        //loader.startAnimating()
        
        return loader
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(startLbl)
        view.addSubview(locationImage)
        view.addSubview(chooseLbl)
        view.addSubview(skipBtn)
        view.addSubview(pickImageBtn)
        view.addSubview(loadingLoader)
        
        startLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        startLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        startLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        
        locationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -94).isActive = true
        locationImage.heightAnchor.constraint(equalToConstant: view.frame.width / 2.3).isActive = true
        locationImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2.3).isActive = true
        
        chooseLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseLbl.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 32).isActive = true
        chooseLbl.heightAnchor.constraint(equalToConstant: 90).isActive = true
        chooseLbl.widthAnchor.constraint(equalToConstant: view.frame.width / 1.2).isActive = true
        
        loadingLoader.topAnchor.constraint(equalTo: chooseLbl.bottomAnchor, constant: 12).isActive = true
        loadingLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 45).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        skipBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        skipBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        skipBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        skipBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        
        pickImageBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        pickImageBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
        pickImageBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        pickImageBtn.bottomAnchor.constraint(equalTo: skipBtn.topAnchor, constant: -12).isActive = true
        
        getUserInfo()
        
    }
    
    var uniqueId: String!
    
    @objc func getUserInfo(){
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            self.uniqueId = user.uid
            
        }
    }
    
    @objc func pickImageF(){
        
        addImageF()
    }
    
    @objc func skipF(){
        
        let vC = HomeViewController()
        vC.modalPresentationStyle = .fullScreen
        
        present(vC, animated: true, completion: nil)
    }
    
    let imagePickerController = UIImagePickerController()
    
    @objc func addImageF(){
        
        let alert = UIAlertController(title: "Select Source Type", message: nil, preferredStyle: .actionSheet)
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            
            self.imagePickerController.delegate = self
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
            
            //self.menuCV.selectItem(at: [0,0], animated: true, scrollPosition: [])
        
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            
            self.imagePickerController.delegate = self
            self.imagePickerController.allowsEditing = false
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
            
            //self.menuCV.selectItem(at: [0,0], animated: true, scrollPosition: [])
        
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        
        }
        
        alert.addAction(photoLibrary)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    
    }
    
    var globalImage: UIImage!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            
            return self.imagePickerControllerDidCancel(picker)
        
        }
        
        globalImage = image
        
        picker.dismiss(animated: true, completion: { [weak self] in
            
            self!.cropViewController = CropViewController(image: self!.globalImage)
            self!.cropViewController.delegate = self
            
            self!.present(self!.cropViewController, animated: true, completion: nil)
            
        })
        
    
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        cropViewController.dismiss(animated: true) {
            
            self.uploadImage()
            
        }
        
    }
    
    func uploadImage(){
        
        loadingLoader.startAnimating()
        skipBtn.isEnabled = false
        
        let imageName = NSUUID().uuidString
        
        //loadingLoader.alpha = 1
        
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        
        let uploadData = globalImage.pngData()!
        
        storageRef.putData(uploadData, metadata: nil) { (mdata, error) in
            
            if error != nil {
            
            }else {
                
                storageRef.downloadURL { (url, error) in
                    
                    guard let downloadURL = url else {
                        
                        self.loadingLoader.stopAnimating()
                        self.skipBtn.isEnabled = true
                        
                        // Uh-oh, an error occurred!
                        Loaf("Error uploading image. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                        
                        return
                    
                    }
                    
                    let itemReviewRef = Database.database().reference().child("users").child(self.uniqueId).child("info")
                    
                    let values = ["profileImageUrl": downloadURL.absoluteString]
                    
                    itemReviewRef.updateChildValues(values) {(error, reference) in
                        
                        if error != nil {
                            
                            self.loadingLoader.stopAnimating()
                            self.skipBtn.isEnabled = true
                            
                            Loaf("Error saving image. Please try again.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                            //failure
                        
                        }else {
                            
                            let vC = HomeViewController()
                            vC.modalPresentationStyle = .fullScreen
                            
                            self.present(vC, animated: true, completion: nil)
                            //success
                            
                            //self.loadingLoader.alpha = 0
                            
                            
                            /*self.profileImageBtn.imageView!.sd_setImage(with: URL(string: downloadURL.absoluteString)) { (image, error, cachType, url) in
                                
                                self.profileImageBtn.setImage(image, for: .normal)
                                
                                //self.profileImageUrl = downloadURL.absoluteString
                                
                                
                            }*/
                        
                        }
                    
                    }
                
                }
            
            }
        
        }
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
    
    }
    

}
