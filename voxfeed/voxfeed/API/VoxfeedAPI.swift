//
//  voxfeedAPI.swift
//  voxfeed
//
//  Created by luis Rodriguez on 14/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit
import Alamofire

class VoxfeedAPI {
// https://api.voxfeed.com/public/promoted_messages
    
    func retrivePublications(success : @escaping(_ result : NSArray) ->(), failure : @escaping(_ error : Error) -> ()) {
        Alamofire.request("https://api.voxfeed.com/public/promoted_messages", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            guard response.error == nil else {
                failure(response.error!)
                return
            }
            success(response.value as! NSArray)

    
        })
        
    }
}
