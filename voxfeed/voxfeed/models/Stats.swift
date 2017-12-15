//
//  Stats.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation


class Stats {
    fileprivate var likes = Int()
    fileprivate var shares = Int()
    fileprivate var clicks = Int()
    fileprivate var audience = Int()
    fileprivate var comments = Int()
    
    init(likes : Int, shares : Int , clicks : Int, audience : Int, comments : Int) {
        self.likes = likes
        self.shares = shares
        self.clicks = clicks
        self.audience = audience
        self.comments = comments
    }
    
    func getLikes() -> Int {return self.likes}
    func getShares() -> Int {return self.shares}
    func getClicks() -> Int {return self.clicks}
    func getAudience() -> Int {return self.audience}
    func getCommets() -> Int {return self.comments}
}
