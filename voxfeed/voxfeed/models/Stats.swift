//
//  Stats.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation


class Stats  : Equatable {
    static func == (lhs: Stats, rhs: Stats) -> Bool {
        if lhs.likes != rhs.likes {
            return false
        }
        
        if lhs.shares != rhs.shares {
            return false
        }
        
        if lhs.clicks != rhs.clicks {
            return false
        }
        if lhs.audience != rhs.audience {
            return false
        }
        if lhs.comments != rhs.comments {
            return false
        }
        return true
    }
    
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
