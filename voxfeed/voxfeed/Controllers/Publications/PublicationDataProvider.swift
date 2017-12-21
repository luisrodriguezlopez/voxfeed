//
//  PublicationDataProvider.swift
//  voxfeed
//
//  Created by iMAC4 on 20/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit

class PublicationDataProvider: NSObject , UITableViewDataSource {
    var model : [PromotedMessage]? = [PromotedMessage]()
    var imagesDictionary : [NSDictionary]!

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CardPublicationCell",
            for: indexPath) as! CardPublicationCell
        
        return cell.configCell(imagesDictionary:  imagesDictionary, currentPublication: self.model![indexPath.row])
    }
    

}
