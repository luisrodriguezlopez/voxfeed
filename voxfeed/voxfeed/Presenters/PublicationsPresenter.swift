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
import RxSwift
import Alamofire
import RxCocoa
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
        let observablePublications = self.rx_getPublications()
        observablePublications.subscribe(onNext: { (response) in
        
            }, onError: { (error) in
                self.view.showError()
            }, onCompleted: {
             self.rx_retriveImages(promotedMessages: self.model).bind(onNext: { (images) in
                   self.view.successRetrivePublications(publications: self.model, images: images)
             })
                
            })
    }

    func rx_getPublications() -> Observable<[PromotedMessage]> {
        let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10 // seconds
            configuration.timeoutIntervalForResource = 10
        let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        return Observable.create ({ (observe)  in
            let request = alamoFireManager.request("https://api.voxfeed.com/public/promoted_messages", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                guard response.error == nil else {
                    return observe.onError(response.error!)
                }
                let array = response.value as! NSArray
                self.model = array.map({ (dictionary) -> PromotedMessage in
                    
                    return PromotedMessage.init(data : dictionary as! NSDictionary)
                    
                })
                observe.onCompleted()
            })
        return Disposables.create { request.cancel() }
        }).retry(3)
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
    
    func rx_retriveImages(promotedMessages : [PromotedMessage]) -> Observable<[NSDictionary]> {
        var imagesArray : [NSDictionary]! = []
        let manager = SDWebImageManager()
        return Observable.create ({ (observeFinish)  in
               Observable<PromotedMessage>.from(promotedMessages).map { (promotedMessageItem) -> NSDictionary!  in
                return  ["id" : promotedMessageItem.getId(), "image" : promotedMessageItem.getPost().getImage()]
                }.map { (urlImage) -> Observable<NSDictionary> in
                        return Observable.create ({ (observe)  in
                            manager.imageDownloader?.downloadImage(with: URL.init(string: urlImage.object(forKey: "image") as! String ), options: SDWebImageDownloaderOptions.continueInBackground, progress: nil,
                                completed: { (image, data, error, complete) in
                                guard error == nil else {
                                    return
                                }
                                var dictionary = NSDictionary()
                                dictionary = ["id" :  urlImage.object(forKey: "id") as! String, "image" : image]
                                return observe.onNext(dictionary)
                        })
                         return Disposables.create {  }
                        })
                }.bind(onNext: { (observableImage) in
                    observableImage.bind(onNext: { (finalImage) in
                        imagesArray.append(finalImage)
                        if imagesArray.count == promotedMessages.count {
                            observeFinish.onNext(imagesArray)
            
                        }
                    })
                })
        
      })
    }
}
