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

class PublicationsViewController: UITableViewController, UIViewControllerPreviewingDelegate {
    
    @IBOutlet var dataProvider:  (UITableViewDataSource & UITableViewDelegate & PublicationDataProvider)!
    var model : [PromotedMessage] = [PromotedMessage]()
    var imagesDictionary : [NSDictionary]!
    var presenter : PublicationsPresenter!
    var mainDelegate : MainNavigationController!
    var obsevableModel : Observable<PromotedMessage>!
    override func viewDidLoad() {
        super.viewDidLoad()
        /** test
         self.dataProvider.model = self.model
        */

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
        /**
         self.tableView.delegate = self.dataProvider
        */

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
        return cell.configCell(imagesDictionary: self.imagesDictionary, currentPublication: currentPublication)
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
        /** test
        self.dataProvider.model = publications
        self.dataProvider.imagesDictionary = images
        */
        self.tableView.reloadData()
    }
    func showError() {
        
    }
}
