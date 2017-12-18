//
//  MainViewController.swift
//  voxfeed
//
//  Created by luis Rodriguez on 14/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit

protocol MainNavigationController {
    func hideNaivgation()
    func showNavigation()
}

class MainViewController: UIViewController , MainNavigationController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier != "toWebView"  else {
            var webView = segue.destination as! WebViewController
            webView.url = sender as! String
            return
        }
        var navController = segue.destination as! UINavigationController
        var publicationsVC = navController.childViewControllers.first as! PublicationsViewController
        publicationsVC.mainDelegate = self
    }
    
    func hideNaivgation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.groupTableViewBackground
        self.navigationController?.isNavigationBarHidden = true
        self.segmentedControl.isHidden = true
    }
    
    func showNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.segmentedControl.isHidden = false

    }
    



}
