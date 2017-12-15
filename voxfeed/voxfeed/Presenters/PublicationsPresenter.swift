//
//  PublicationsPresenter.swift
//  voxfeed
//
//  Created by iMAC4 on 15/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation

protocol PublicationsView : NSObjectProtocol {
    func successRetrivePublications(publications : [PromotedMessage])
    func showError()
    
}

protocol PublicationsProtocol {
    init(view : PublicationsView , model : [PromotedMessage])
    func retrivePublications()
    
}


class PublicationsPresenter : PublicationsProtocol{
    var view : PublicationsView!
    var model : [PromotedMessage]!
    required init(view: PublicationsView, model: [PromotedMessage]) {
        self.view = view
    }
    
    func retrivePublications() {
        VoxfeedAPI().retrivePublications(success: { (response) in
           self.model =  response.map({ (dictionary) -> PromotedMessage in
                return PromotedMessage.init(data : dictionary as! NSDictionary)
            })
            self.view.successRetrivePublications(publications: self.model)
        }) { (error) in
            self.view.showError()
        }
    }
    
    
}
