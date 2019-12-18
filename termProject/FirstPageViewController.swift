//
//  FirstPageViewController.swift
//  termProject
//
//  Created by Christian Lopez on 5/1/19.
//  Copyright © 2019 Christian Lopez. All rights reserved.
//

import UIKit



class FirstPageViewController: UIViewController {
    //var searchbox = String()
   
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var myText: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var daLabel: UILabel!
    @IBOutlet weak var statuslabel: UILabel!
    @IBAction func searchButton(_ sender: Any) {
        self.performSegue(withIdentifier: "connect", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daLabel.text = "RECIPE RESEARCHER"
        myLabel.text = "Enter Search Keyword below"
        animateView()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        // Get the new view controller using segue.destination.
        if (segue.identifier == "connect") {
            let svc = segue.destination as! MyTableViewController
            svc.keyword = myText.text!
            svc.viewDidLoad()
        }
    }
    func animateView(){
        if self.myView.alpha == 0 {
            UIView.animate(withDuration: 1.5, delay: 0.3, usingSpringWithDamping: 2.0, initialSpringVelocity: 0.9, options: .curveEaseInOut, animations: {
                self.myView.alpha = 1.0
                self.myView.backgroundColor = UIColor.cyan
            }, completion: nil)
        }
    }
    
}

