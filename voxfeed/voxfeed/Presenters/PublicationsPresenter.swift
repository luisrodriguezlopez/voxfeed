//
//  PublicationsPresenter.swift
//  voxfeed
//
//  Created by iMAC4 on 15/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
protocol PublicationsView : NSObjectProtocol {
    func successRetrivePublications(publications : [PromotedMessage] , images : [NSDictionary])
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
            self.retriveImages(model: self.model, success: { (images) in
                self.view.successRetrivePublications(publications: self.model, images : images)
            })
        }) { (error) in
            self.view.showError()
        }
    }
    
    
    
    func retriveImages(model : [PromotedMessage], success : @escaping(_ images : [NSDictionary]) ->()) {
        var imagesDictionaryArray : [NSDictionary] = []
        for promoteMessage in model {
            var img : UIImage!
            self.retriveImage(promotedMessage: promoteMessage, success: { (image) in
                var dictionary = NSDictionary()
                dictionary = ["id" :  promoteMessage.getId(), "image" : image] 
                imagesDictionaryArray.append(dictionary)
                if imagesDictionaryArray.count == self.model.count {
                    success(imagesDictionaryArray)
                }
            })
        }
    }
    
    
    func retriveImage(promotedMessage : PromotedMessage , success : @escaping (_ image : UIImage) ->()) {
        let manager = SDWebImageManager()
        manager.imageDownloader?.downloadImage(with: URL.init(string: promotedMessage.getPost().getImage()), options: SDWebImageDownloaderOptions.continueInBackground, progress: nil, completed: { (image, data, error, complete) in
            guard error == nil else {
                return
            }
            success(image!)
        })
    }
    
    
    
}
