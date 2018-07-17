//
//  DetailDataProvider.swift
//  voxfeed
//
//  Created by iMAC4 on 21/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit

class DetailDataProvider: NSObject , UITableViewDelegate, UITableViewDataSource {
    var promotedMessage : PromotedMessage!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var header : HeaderImageDetail!
        var stats : StatsViewCell!
        switch indexPath.section {
        case 0:  header = tableView.dequeueReusableCell(withIdentifier: "headerCell",for: indexPath) as! HeaderImageDetail
                return header
        default :
            stats = tableView.dequeueReusableCell(withIdentifier: "statsCell",for: indexPath) as! StatsViewCell
                return  stats.configCell(indexPath: indexPath, cell: stats, stats: promotedMessage.getStats())
        }
    }

}
