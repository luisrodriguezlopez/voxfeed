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
    
    
    func configCell(indexPath : IndexPath,cell : StatsViewCell, stats : Stats) -> StatsViewCell {
        switch indexPath.row {
        case 0:
            self.lblStats.text = "Me gusta"
            self.lblNumStats.text = String(stats.getLikes())
            self.icon.image = #imageLiteral(resourceName: "icon-likes")
        case 1:
            self.lblStats.text = "Comentarios"
            self.lblNumStats.text = String(stats.getCommets())
            self.icon.image = #imageLiteral(resourceName: "icon-comments")
            
        case 2:
            self.lblStats.text = "Compartido"
            self.lblNumStats.text = String(stats.getShares())
            self.icon.image = #imageLiteral(resourceName: "icon-share")
            
        case 3:
            self.lblStats.text = "Audiencia"
            self.lblNumStats.text = String(stats.getAudience())
            self.icon.image = #imageLiteral(resourceName: "icon-audience")
            
        default:
            self.lblStats.text = "Clics"
            self.lblNumStats.text = String(stats.getClicks())
            self.icon.image = #imageLiteral(resourceName: "icon-clicks")
            
        }
        return self
    }

}
