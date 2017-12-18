//
//  StatsViewCell.swift
//  voxfeed
//
//  Created by luis Rodriguez on 16/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit

class StatsViewCell: UITableViewCell {

    @IBOutlet weak var lblNumStats: UILabel!
    @IBOutlet weak var lblStats: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
