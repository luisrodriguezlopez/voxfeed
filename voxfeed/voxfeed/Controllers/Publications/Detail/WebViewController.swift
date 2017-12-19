//
//  WebViewController.swift
//  voxfeed
//
//  Created by luis Rodriguez on 17/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    var url : String!
    var fromMain = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromMain {
            self.backButton.isHidden = true
        }
        webView.load(URLRequest.init(url: URL.init(string: url)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
