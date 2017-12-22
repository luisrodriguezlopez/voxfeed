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
        var observableImages : Observable<[NSDictionary]>!
        let observablePublications = self.rx_getPublications()
        observablePublications.subscribe(onNext: { (response) in
            print(response)
        
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
//             self.rx_retriveImages(promotedMessages: self.model).bind(onNext: { (image) in
//                    print(image)
//            })
//                observableImages.subscribe { (imagesDictionary) in
//                    print(imagesDictionary)
//                }


            }) {
        
        }
//        let observableImages = self.rx_getImages()
//        
//        observableImages.subscribe(onNext: { (response) in
//            
//            print(response)
//        }, onError: { (error) in
//            print(error)
//        }, onCompleted: {
//            print("complet")
//        }) {
//            
//        }
            //        VoxfeedAPI().retrivePublications(success: { (response) in
//           self.model =  response.map({ (dictionary) -> PromotedMessage in
//                return PromotedMessage.init(data : dictionary as! NSDictionary)
//            })
//            self.retriveImages(model: self.model, success: { (images) in
//                self.view.successRetrivePublications(publications: self.model, images : images)
//            })
//        }) { (error) in
//            self.view.showError()
//        }
    }

    

    
    func rx_getPublications() -> Observable<[PromotedMessage]> {
        return Observable.create ({ (observe)  in
            let request = Alamofire.request("https://api.voxfeed.com/public/promoted_messages", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                guard response.error == nil else {
                    return observe.onError(response.error!)
                }
                let array = response.value as! NSArray
                self.model = array.map({ (dictionary) -> PromotedMessage in
                    
                    return PromotedMessage.init(data : dictionary as! NSDictionary)
                    
                })
                observe.onNext(self.model)
                observe.onCompleted()
            })
        return Disposables.create { request.cancel() }
        })
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

//    func rx_getImages() -> Observable<[UIImage]> {
//        return Observable.create({ (observe) -> Disposable in
//
//
//
//            return Disposables.create {  }
//        })
//    }
    
    
    func retriveImage(promotedMessage : PromotedMessage , success : @escaping (_ image : UIImage) ->()) {
        let manager = SDWebImageManager()
        manager.imageDownloader?.downloadImage(with: URL.init(string: promotedMessage.getPost().getImage()), options: SDWebImageDownloaderOptions.continueInBackground, progress: nil, completed: { (image, data, error, complete) in
            guard error == nil else {
                return
            }
            success(image!)
        })
    }
    
//    func rx_retriveImages(promotedMessages : [PromotedMessage]) -> Observable<[UIImage]> {
//        var imagesArray : [UIImage]!
//        let manager = SDWebImageManager()
//        let observableArray : Observable<[UIImage]>!
//        var observerdictionary : Observable<NSDictionary>!
//        var imagesSecuente : Observable<[UIImage]>!
//      return Observable.create ({ (observeFinish)  in
//       Observable<PromotedMessage>.from(promotedMessages).map { (promotedMessageItem) -> String  in
//            return promotedMessageItem.getPost().getImage()
//            }.map { (urlImage) -> Observable<UIImage> in
//                return Observable.create ({ (observe)  in
//                let manager = SDWebImageManager()
//                manager.imageDownloader?.downloadImage(with: URL.init(string:urlImage), options: SDWebImageDownloaderOptions.continueInBackground, progress: nil,
//                        completed: { (image, data, error, complete) in
//                        guard error == nil else {
//                            return
//                        }
//                        return observe.onNext(image!)
//                })
//                 return Disposables.create {  }
//                })
//        }.bind(onNext: { (observableImage) in
//                    observableImage.bind(onNext: finalImage)
//                    imagesArray.append(finalImage)
//                    if imagesArray.count == promotedMessages.count {
//                        imagesSecuente = Observable.from(optional: imagesArray)
//                    }
//                }).dispose()
//
//        })
//
//        imagesSecuente.subscribe { (eventImage) in
//            switch eventImage {
//                case .completed : observeFinish.onNext(imagesArray)
//                case .error : return
//            case .next(_):
//                print("next")
//            }
//        } return Disposables.create {  }
//
//    }
}

