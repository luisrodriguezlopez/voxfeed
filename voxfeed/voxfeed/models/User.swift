//
//  User.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation


class User {
    fileprivate var username  = String()
    fileprivate var profileImage = String()
    
    init(username : String , profileImage : String) {
        self.username = username
        self.profileImage = profileImage
    }
    
    func getUsername() -> String {return self.username}
    func getProfileImage() -> String {return self.profileImage}
}
