//
//  Brand.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation


class Brand {
    fileprivate var name = String()
    fileprivate var logo = String()
    
    init(name : String , logo : String) {
        self.name = name
        self.logo = logo
    }
    
    
    func getName() -> String {return self.name}
    func getLogo() -> String {return self.logo}
    
}
