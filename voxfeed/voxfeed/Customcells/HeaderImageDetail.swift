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
    
    func configCell(promotedMessage : PromotedMessage) {
        self.campaignImage.sd_setImage(with: URL.init(string: promotedMessage.getCampaign().getCoverImage()), completed: { (image, error, option, url) in
            self.campaignImage.image = image
            self.brandName.text = promotedMessage.getBrand().getName()
            self.campaingName.text = promotedMessage.getCampaign().getName()
            self.lblEarnings.text = "$\(promotedMessage.getEarnings()) USD"
            self.brandImage.sd_setImage(with: URL.init(string: promotedMessage.getBrand().getLogo()), completed: { (image, error, option, url) in
                self.brandImage.image = image
            })
        })
    }

}
