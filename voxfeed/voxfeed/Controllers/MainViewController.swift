//
//  MainViewController.swift
//  voxfeed
//
//  Created by luis Rodriguez on 14/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
protocol MainNavigationController {
    func hideNaivgation()
    func showNavigation()
}

class MainViewController: UIViewController , MainNavigationController {
    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var publicationsView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { index in
            UIView.animate(withDuration: 0.5, animations: {
                self.changeContainer(index: index)
            })
        }).disposed(by: disposeBag)
    }
    
    
    
    
    func changeContainer(index : Int) {
        switch index {
        case 0:
            self.initialView.alpha = 0
            self.publicationsView.alpha = 1
        default:
            self.publicationsView.alpha = 0
            self.initialView.alpha = 1
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView" {
            var webView = segue.destination as! WebViewController
            webView.url = sender as! String
            webView.fromMain = true
            return
        }
        if segue.identifier == "publicaitonView" {
            var navController = segue.destination as! UINavigationController
            var publicationsVC = navController.childViewControllers.first as! PublicationsViewController
            publicationsVC.mainDelegate = self
        }
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
