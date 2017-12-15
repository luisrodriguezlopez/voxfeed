//
//  Campaing.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation

class Campaign {
    fileprivate var name = String()
    fileprivate var coverImage = String()
    
    init(name : String, coverImage : String) {
        self.name = name
        self.coverImage = coverImage
    }
    
    func getName() -> String {return self.name}
    func getCoverImage() -> String {return self.coverImage}
}
