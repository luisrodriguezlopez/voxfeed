//
//  Utils.swift
//  voxfeed
//
//  Created by luis Rodriguez on 17/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    class func formatingDateToShort(stringDate : String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.ssssZ"
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date!)
    }
    
    class func getColorForSocialNetowrk(socialNetwork : String) -> UIColor {
        var facebookColor = UIColor.init(hex: "45609C")
        var twitterColor = UIColor.init(hex: "1Da1f3")
        var instagramColor = UIColor.init(hex: "E4405F")
        
        switch socialNetwork {
        case "facebook": return facebookColor
        case "instagram":return  instagramColor
            
        default:
           return twitterColor
        }
    }
}
