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
// facebook color #45609C
// twitter 1Da1f3
// instagram E4405F

// textColor  8f8e94

// primary color 16D4E6
class PublicationsViewController: UITableViewController, UIViewControllerPreviewingDelegate {

    
    var model : [PromotedMessage] = [PromotedMessage]()
    var imagesDictionary : [NSDictionary]!
    var presenter : PublicationsPresenter!
    var mainDelegate : MainNavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        if( traitCollection.forceTouchCapability == .available){
            
            registerForPreviewing(with: self, sourceView: view)
        }
        self.presenter = PublicationsPresenter.init(view: self, model: self.model)
        self.presenter.retrivePublications()
        let nib = UINib.init(nibName: "CardPublication", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CardPublicationCell")
        self.tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBar.isHidden = true
    }
 

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
        cell.lblDate.text = Utils.formatingDateToShort(stringDate: currentPublication.getDate())
   
        cell.lblSocialNetwork.textColor = Utils.getColorForSocialNetowrk(socialNetwork: currentPublication.getSocialNetwork())
    
        cell.lblUsername.text = currentPublication.getUser().getUsername()
        cell.lblSocialNetwork.text = currentPublication.getSocialNetwork()
        cell.txtPost.text = currentPublication.getPost().getText()
        cell.profileImage.sd_setImage(with: URL.init(string: currentPublication.getUser().getProfileImage()), placeholderImage: UIImage(), options: SDWebImageOptions.highPriority, completed: nil)
        let placeholderImage = UIImage(named: "default-placeholder-300x300")
        var isDownloading = false

        let currentDictImage = self.imagesDictionary.filter { ($0["id"] as! String == currentPublication.getId()) }.first
        cell.imagePost.image = currentDictImage!["image"] as! UIImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  indexPath.row == self.model.count  {
            if self.tableView.visibleCells.last == cell {
                print(indexPath.row)
                self.tableView.endUpdates()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPublication = self.model[indexPath.row]
        self.performSegue(withIdentifier: "toDetailVC", sender: currentPublication)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.promotedMessage = sender as! PromotedMessage
        self.navigationController?.navigationBar.isHidden = false
        detailVC.mainDelegate = self.mainDelegate
        self.mainDelegate.hideNaivgation()

    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let indexPath = self.tableView.indexPathForRow(at: location)
        let currentPublication = self.model[(indexPath?.row)!]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.promotedMessage = currentPublication
//        self.navigationController?.navigationBar.isHidden = false
        detailVC.mainDelegate = self.mainDelegate
        self.mainDelegate.hideNaivgation()
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.navigationBar.isHidden = false
        self.mainDelegate.hideNaivgation()
        self.show(viewControllerToCommit, sender: self)
    }
}

extension PublicationsViewController : PublicationsView {
    func successRetrivePublications(publications: [PromotedMessage], images : [NSDictionary]) {
        self.model = publications
        self.imagesDictionary = images
        self.tableView.reloadData()
    }
    func showError() {
        
    }
}
