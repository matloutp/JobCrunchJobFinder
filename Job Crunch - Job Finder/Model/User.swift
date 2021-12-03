//
//  User.swift
//  Job Crunch - Job Finder
//
//  Created by Thapelo on 2020/11/24.
//  Copyright © 2020 Thapelo. All rights reserved.
//


import UIKit

class User: NSObject {
    
    @objc var fullName: String?
    @objc var email: String?
    @objc var profileImageUrl: String?
    @objc var userName: String?
    @objc var userId: String?
    @objc var phone: String?
    @objc var location: String?
    @objc var role: String?
    @objc var userCV: String?
    @objc var about: String?
    
    @objc var followers: [String: Any]?
    
    @objc var blocked: [String: Any]?

}
