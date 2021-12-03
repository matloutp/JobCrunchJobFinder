//
//  SearchViewController.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/18.
//  Copyright © 2020 Thapelo. All rights reserved.
//

import UIKit
import BubbleTransition
import LUAutocompleteView
import Loaf

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var interactiveTransition = BubbleInteractiveTransition()
    
    var popularSearchesArray = ["Web Developer", "App Developer", "Accountant", "Engineer"]
    
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
    
    let searchLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("Search", comment: "")
        
        lbl.textColor = .black
        
        
        lbl.font = UIFont(name:"Copperplate", size: 27.0)
        
        lbl.textAlignment = NSTextAlignment.left
        
        return lbl
    }()

    private let autocompleteView = LUAutocompleteView()
    private let elements = ["Web Developer", "App Developer", "Data Scientist", "Accountant", "Marketing", "Graphics & Design", "Engineer", "Teacher", "Clerk", "Sales Rep", "Manager", "Tech lead", "HR", "Doctor", "Nurse", "Cashier", "Waitress"]
    
    let searchValue: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        txt.placeholder = "Search for a job title. e.g: engineer"
        
        return txt
    }()
    
    let popularSearchesLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Popular Searches"
        
        return lbl
    }()
    
    lazy var popularSearchesCV: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        cv.register(SalaryCollectionViewCell.self, forCellWithReuseIdentifier: "PopularId")
        cv.backgroundColor = .clear
        
        cv.layer.zPosition = 1
        
        
        return cv
    
    }()
    
    let searchBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .clear//UIColor(red: 133/255, green: 152/255, blue: 248/255, alpha: 1)
        
        let img = UIImage(named: "arrow-right")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.imageView?.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        
        
        btn.addTarget(self, action: #selector(searchF), for: .touchUpInside)
        
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    

    func setup(){
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(backBtn)
        view.addSubview(searchLbl)
        view.addSubview(searchBtn)
        
        view.addSubview(searchValue)
        
        view.addSubview(popularSearchesLbl)
        
        view.addSubview(popularSearchesCV)
        
        view.addSubview(autocompleteView)

        autocompleteView.textField = searchValue
        autocompleteView.dataSource = self
        autocompleteView.delegate = self

        // Customisation
        autocompleteView.rowHeight = 45
        
        searchValue.delegate = self
        
        popularSearchesCV.delegate = self
        popularSearchesCV.dataSource = self
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        
        searchLbl.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        searchLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        searchLbl.rightAnchor.constraint(equalTo: searchBtn.leftAnchor, constant: -12).isActive = true
        searchLbl.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true

        searchBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        searchBtn.topAnchor.constraint(equalTo: searchLbl.centerYAnchor, constant: 24).isActive = true
        
        searchValue.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        searchValue.heightAnchor.constraint(equalToConstant: 35).isActive = true
        searchValue.rightAnchor.constraint(equalTo: searchBtn.leftAnchor, constant: -12).isActive = true
        searchValue.topAnchor.constraint(equalTo: searchLbl.centerYAnchor, constant: 24).isActive = true
        
        //searchValue.becomeFirstResponder()
        
        popularSearchesLbl.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        popularSearchesLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        popularSearchesLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        popularSearchesLbl.topAnchor.constraint(equalTo: searchValue.centerYAnchor, constant: 24).isActive = true
        
        popularSearchesCV.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: -24).isActive = true
        popularSearchesCV.heightAnchor.constraint(equalToConstant: 395).isActive = true
        popularSearchesCV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        popularSearchesCV.topAnchor.constraint(equalTo: popularSearchesLbl.bottomAnchor, constant: 12).isActive = true
        
    }
    
    @objc func searchF(){
        
        if searchValue.text == "" {
            
            Loaf("Error. Please enter a job title you want to search for", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
            
        }else {
            
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            homeVC.toSearch = searchValue.text!.capitalized
            
            present(homeVC, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularId", for: indexPath) as! SalaryCollectionViewCell
        
        cell.salaryLbl.textAlignment = NSTextAlignment.left
        
        cell.salaryLbl.text = popularSearchesArray[indexPath.row]
        
        cell.background.layer.borderColor = UIColor.clear.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchValue.text = popularSearchesArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 64, height: 45)
        
        return size
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        popularSearchesLbl.isHidden = true
        popularSearchesCV.isHidden = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        popularSearchesLbl.isHidden = false
        popularSearchesCV.isHidden = false
        
    }
    
    
}

extension SearchViewController: LUAutocompleteViewDataSource {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void) {
        let elementsThatMatchInput = elements.filter { $0.lowercased().contains(text.lowercased()) }
        completion(elementsThatMatchInput)
    }
}

// MARK: - LUAutocompleteViewDelegate

extension SearchViewController: LUAutocompleteViewDelegate {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String) {
        print(text + " was selected from autocomplete view")
        popularSearchesLbl.isHidden = false
        popularSearchesCV.isHidden = false
    }
}
