//
//  DetailViewController.swift
//  voxfeed
//
//  Created by luis Rodriguez on 16/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var promotedMessage  : PromotedMessage!
    var subtitle : UILabel!
    var mainDelegate : MainNavigationController!
    var isGoingToWeb = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet var dataProvider:  (UITableViewDataSource & UITableViewDelegate & DetailDataProvider)!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerButton.setTitle("Ver publicación en \(promotedMessage.getSocialNetwork())", for: .normal)
        footerButton.backgroundColor = Utils.getColorForSocialNetowrk(socialNetwork: promotedMessage.getSocialNetwork())

        let headerCell = UINib(nibName: "HeaderImage", bundle: nil)
        let statsCell = UINib(nibName: "StatsCell", bundle: nil)
        self.tableView.register(headerCell, forCellReuseIdentifier: "headerCell")
        self.tableView.register(statsCell, forCellReuseIdentifier: "statsCell")
        self.tableView.dataSource = self.dataProvider
        self.tableView.delegate = self.dataProvider
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard !isGoingToWeb else {
            isGoingToWeb = false
            return
        }
        self.navigationController?.title = "VoxFeed"
        
        self.navigationController?.navigationBar.subviews.last?.removeFromSuperview()
        self.subtitle.removeFromSuperview()
        self.navigationController?.navigationBar.isHidden = true
        self.mainDelegate.showNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = promotedMessage.getUser().getUsername()
        subtitle = UILabel.init(frame: CGRect(x: self.view.frame.width/2 - 50, y: 12, width: 100, height: 30))
        subtitle.textAlignment = .center
        subtitle.font = UIFont.init(name: "Arial", size: 11)
        subtitle.text = Utils.formatingDateToShort(stringDate: promotedMessage.getDate())
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-12.0, for: .default)
        self.navigationController?.navigationBar.insertSubview(subtitle, at: 0)
        
    }


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        var cell : StatsViewCell!
        switch indexPath.section {
        case 0:   header = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderImageDetail
                  header.configCell(promotedMessage: self.promotedMessage)
            return header
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! StatsViewCell
            return cell.configCell(indexPath: indexPath, cell: cell, stats: promotedMessage.getStats())
        }
    }
    
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 222
        default:
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "DESEMPEÑO"
        }else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 30
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
 
        let openWebView = UIPreviewAction(title: "Ver publicación en \(self.promotedMessage.getSocialNetwork())", style: .default) { (action, viewController) -> Void in
            let root = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            let main = root.childViewControllers[0] as! MainViewController
            main.performSegue(withIdentifier: "toWebView", sender: self.promotedMessage.getPost().getLink())
        }
        
        let nopeAction = UIPreviewAction(title: "No", style: .destructive) { (action, viewController) -> Void in
            
        }
        
        return [openWebView, nopeAction]
        
    }
    @IBAction func openWebView(_ sender: Any) {
        self.performSegue(withIdentifier: "toWebView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.isGoingToWeb = true
        let webView = segue.destination as! WebViewController
        webView.url = self.promotedMessage.getPost().getLink()
    }
    
}
