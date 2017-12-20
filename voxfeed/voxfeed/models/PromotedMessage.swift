//
//  PromotedMessage.swift
//  voxfeedTest
//
//  Created by luis Rodriguez on 13/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation


struct PromotedMessage : Equatable {
    static func ==(lhs: PromotedMessage, rhs: PromotedMessage) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        
        if lhs.date != rhs.date {
            return false
        }
        
        if lhs.socialNetwork != rhs.socialNetwork {
            return false
        }
//
//        if lhs.brand != rhs.socialNetwork {
//            return false
//        }
//
//        if lhs.post != rhs.post {
//            return false
//        }
//
//        if lhs.campaign != rhs.campaign {
//            return false
//        }
//
//        if lhs.user != rhs.user {
//            return false
//        }
//        if lhs.stats != rhs.stats {
//            return false
//        }
        return true
    }
    
    fileprivate var id = String()
    fileprivate var date = String()
    fileprivate var socialNetwork = String()
    fileprivate var user : User!
    fileprivate var brand : Brand!
    fileprivate var post : Post!
    fileprivate var campaign : Campaign!
    fileprivate var stats : Stats!
    fileprivate var earnings : Double!
    
    init(data : NSDictionary) {
        self.id = data["id"] as! String
        self.date = data["date"] as! String
        self.socialNetwork = data["socialNetwork"] as! String
        let brandDictionary = data["brand"] as! NSDictionary!
        let postDictionary = data["post"] as! NSDictionary!
        let campaignDictionary = data["campaign"] as! NSDictionary!
        let userDictionary = data["user"] as! NSDictionary!
        let statsDictioanry = data["stats"] as! NSDictionary!
        self.brand = Brand.init(name: brandDictionary!["name"] as! String, logo: brandDictionary!["logo"] as! String)
        self.post = Post.init(text: postDictionary!["text"] as! String, image: postDictionary!["image"] as! String , link: postDictionary!["link"] as! String)
        self.campaign = Campaign.init(name:  campaignDictionary!["name"] as! String, coverImage: campaignDictionary!["coverImage"] as! String)
        self.user = User.init(username: userDictionary!["username"] as! String, profileImage: userDictionary!["profileImage"] as! String)
        self.stats = Stats.init(likes: statsDictioanry!["likes"] as! Int, shares: statsDictioanry!["shares"] as! Int, clicks: statsDictioanry!["clicks"] as? Int ?? 0, audience: statsDictioanry!["audience"] as! Int, comments: statsDictioanry!["comments"] as! Int)
        self.earnings =  data["earnings"] as? Double ?? 0.0
    }
 
    
    func getId() -> String { return self.id }
    func getDate() -> String { return self.date }
    func getSocialNetwork() -> String { return self.socialNetwork}
    func getBrand() -> Brand { return self.brand }
    func getPost() -> Post { return self.post}
    func getCampaign() -> Campaign {return self.campaign}
    func getStats() -> Stats {return self.stats}
    func getUser() -> User {return self.user}
    func getEarnings() -> Double { return self.earnings}
    
    func toDictionary() -> [String : Any] {
        return [
            "id" : self.getId(),
            "date" : self.getDate(),
            "socialNetwork" : self.getSocialNetwork(),
            "brand" : self.getBrand(),
            "post" : self.getPost(),
            "campaign" : self.getCampaign(),
            "user" : self.getUser() , 
            "stats" : self.getStats()
        ]
    }
    
    //    self.post = Post.init(text: postDictionary!["text"] as! String, image: postDictionary!["image"] as! String , link: postDictionary!["link"] as! String)
    //    self.campaign = Campaign.init(name:  campaignDictionary!["name"] as! String, coverImage: campaignDictionary!["coverImage"] as! String)
    //    self.user = User.init(username: userDictionary!["username"] as! String, profileImage: userDictionary!["profileImage"] as! String)
    //    self.stats = Stats.init(likes: statsDictioanry!["likes"] as! Int, shares: statsDictioanry!["shares"] as! Int, clicks: statsDictioanry!["clicks"] as? Int ?? 0, audience: statsDictioanry!["audience"] as! Int, comments: statsDictioanry!["comments"] as! Int)
    //    self.earnings =  data["earnings"] as? Double ?? 0.0
}
