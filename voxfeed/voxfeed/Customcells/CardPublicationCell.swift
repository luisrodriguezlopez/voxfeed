//
//  CardPublicationCell.swift
//  voxfeed
//
//  Created by luis Rodriguez on 14/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit
import SDWebImage
class CardPublicationCell: UITableViewCell {
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblSocialNetwork: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var txtPost: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imagePost: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        self.imagePost.reloadInputViews()
    }
    
    func configCell(imagesDictionary : [NSDictionary]!, currentPublication : PromotedMessage) -> CardPublicationCell {
        self.lblDate.text = Utils.formatingDateToShort(stringDate: currentPublication.getDate())
        self.lblSocialNetwork.textColor = Utils.getColorForSocialNetowrk(socialNetwork: currentPublication.getSocialNetwork())
        self.lblUsername.text = currentPublication.getUser().getUsername()
        self.lblSocialNetwork.text = currentPublication.getSocialNetwork()
        self.txtPost.text = currentPublication.getPost().getText()
        self.profileImage.sd_setImage(with: URL.init(string: currentPublication.getUser().getProfileImage()), placeholderImage: UIImage(), options: SDWebImageOptions.highPriority, completed: nil)
        let placeholderImage = UIImage(named: "default-placeholder-300x300")
        var isDownloading = false
        
        let currentDictImage = imagesDictionary.filter { ($0["id"] as! String == currentPublication.getId()) }.first
        self.imagePost.image = currentDictImage!["image"] as! UIImage
        return self
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
