//
//  PublicationsViewController.swift
//  voxfeed
//
//  Created by luis Rodriguez on 14/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Alamofire
import UIKit

class PublicationsViewController: UITableViewController {
    var promoteMessage : PromotedMessage!
    override func viewDidLoad() {
        super.viewDidLoad()
        VoxfeedAPI().retrivePublications(success: { (response) in
            
        }, failure: <#T##(Error) -> ()#>)
        let nib = UINib.init(nibName: "CardPublication", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CardPublicationCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardPublicationCell", for: indexPath)

        // Configure the cell...

        return cell
    }

 

}
