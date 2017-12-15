//
//  PublicationsViewController.swift
//  voxfeed
//
//  Created by luis Rodriguez on 14/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import Alamofire
import SDWebImage
import UIKit
import RxSwift
import RxCocoa

class PublicationsViewController: UITableViewController {
    var model : [PromotedMessage] = [PromotedMessage]()
    var images : [UIImage]!
    var presenter : PublicationsPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PublicationsPresenter.init(view: self, model: self.model)
        self.presenter.retrivePublications()
        let nib = UINib.init(nibName: "CardPublication", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CardPublicationCell")
        self.tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.model.count > 0 else {
            return UITableViewCell()
        }
        let currentPublication = self.model[indexPath.row] as PromotedMessage
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardPublicationCell", for: indexPath) as! CardPublicationCell
        cell.lblUsername.text = currentPublication.getUser().getUsername()
        cell.lblSocialNetwork.text = currentPublication.getSocialNetwork()
        cell.txtPost.text = currentPublication.getPost().getText()
        cell.profileImage.sd_setImage(with: URL.init(string: currentPublication.getUser().getProfileImage()), placeholderImage: UIImage(), options: SDWebImageOptions.highPriority, completed: nil)
        cell.imagePost.startAnimating()
        let placeholderImage = UIImage(named: "default-placeholder-300x300")
        var isDownloading = false
//        cell.imagePost.image = placeholderImage
//        cell.imagePost.frame = CGRect.init(x: 0, y: 0, width: cell.frame.height - 20, height: 0)
//        self.tableView.beginUpdates()
        cell.imagePost.sd_setImage(with: URL.init(string: currentPublication.getPost().getImage()), placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority) { (image, error, option, url) in
            guard error == nil else {
                return
            }
            DispatchQueue.main.async() {
                cell.imagePost.image = image
                cell.reloadInputViews()
                cell.imagePost.reloadInputViews()
                cell.setNeedsDisplay()
                cell.layoutIfNeeded()
//                self.tableView.endUpdates()

            }
        }
        return cell
    }

    
}

extension PublicationsViewController : PublicationsView {
    func successRetrivePublications(publications: [PromotedMessage]) {
        self.model = publications
        self.tableView.reloadData()
    }
    
    func showError() {
        
    }
    
    
}
