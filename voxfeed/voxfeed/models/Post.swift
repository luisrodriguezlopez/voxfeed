//
//  Post.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation


class Post {
    fileprivate var text = String()
    fileprivate var image = String()
    fileprivate var  link = String()
    
    
    init(text : String , image : String, link : String) {
        self.text = text
        self.image = image
        self.link = link
    }
    
    func getText() -> String {return self.text}
    func getImage()-> String {return self.image}
    func getLink() -> String {return self.link}
}
