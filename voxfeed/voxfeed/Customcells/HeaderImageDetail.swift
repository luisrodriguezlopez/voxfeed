//
//  HeaderImageDetail.swift
//  voxfeed
//
//  Created by luis Rodriguez on 16/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit

class HeaderImageDetail: UITableViewCell {
    @IBOutlet weak var campaignImage: UIImageView!
    @IBOutlet weak var lblEarnings: UILabel!
    @IBOutlet weak var campaingName: UILabel!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
