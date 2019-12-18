//
//  DetailViewController.swift
//  termProject
//
//  Created by Christian Lopez on 4/13/19.
//  Copyright © 2019 Christian Lopez. All rights reserved.
//

import UIKit
//import SwiftyJSON
import WebKit


var myWeb = WKWebView()
class DetailViewController: UIViewController {
    var links:String = ""
    @IBOutlet weak var myWeb: WKWebView!
    
    @IBOutlet var thisView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    print(links)
        let url = URL (string: links)
        let request = URLRequest(url: url!)
        myWeb.load(request)
    }
}
