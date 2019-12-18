//
//  MyTableViewController.swift
//  termProject
//
//  Created by Christian Lopez on 3/31/19.
//  Copyright © 2019 Christian Lopez. All rights reserved.
//

import Foundation
import UIKit
//import SwiftyJSON

struct DishInfo: Decodable {
    var source_url: String
    var publisher_url: String
    var title: String
    var publisher: String
    var recipe_id: String
    var image_url: String
    var f2f_url: String
    var social_rank: String
}
extension DishInfo{
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case publisher = "publisher"
        case title = "title"
        case source_url = "source_url"
        case recipe_id = "recipe_id"
        case image_url = "image_url"
        
 
    }
 }


var recipeArray =  [DishInfo]()
var keyword = String()
class MyTableViewController: UITableViewController {
    
    
    @IBOutlet var myTableView: UITableView!
    var keyword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         getData()
        tableView.reloadData()
        animateTable()
    }/// END ViewDidLoad
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTable()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArray.count // number of downloaded dishes why is this not
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TheTableViewCell
       cell.textLabel?.text =  recipeArray[indexPath.row].title// set with dictionary array value
        return cell
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "myConnect", sender: nil)
        
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myConnect" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as? DetailViewController
                destination!.links = recipeArray[indexPath.row].source_url
                //print(destination?.links)
            }
        }
     }
    ///// Class specific methods below
    func getData(){
        let urlBase = "https://www.food2fork.com/api/search?key=7a4cb6cb74157395032fd834119976c9&q="
        let urlString = urlBase+keyword
        let url = URL(string: urlString ) // 1
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in // 4
            var recArray = [DishInfo]()
            guard let actualData = data else {
                print("Error: \(String(describing: error))") // 5
                return
            }
            let myParsedData = try? JSON(data: actualData)
            if let meals = myParsedData?["recipes"]{
                for (_, names) in meals {
                    let source_url = names["source_url"].stringValue
                    let publisher_url = names["publisher_url"].stringValue
                    let title = names["title"].stringValue
                    let publisher = names["publisher"].stringValue
                    let recipe_id = names["recipe_id"].stringValue
                    let image_url = names["image_url"].stringValue
                    let f2f_url = names["f2f_url"].stringValue
                    let social_rank = names["social_rank"].stringValue
                    recArray.append(DishInfo(source_url: source_url, publisher_url: publisher_url, title: title,
                                             publisher: publisher, recipe_id: recipe_id, image_url: image_url,
                                             f2f_url: f2f_url, social_rank: social_rank))
                }// End for loop
                DispatchQueue.main.async { /// you need this to load the tableview
                    self.tableView.reloadData()
                }// end dispatchQue
            }//end data Parsing*/
            recipeArray = recArray
            if recipeArray.count == 0 {  // error checking
                print("no data")
                recipeArray.append(DishInfo.init(source_url:"", publisher_url:"", title: "Sorry no match try a different keyword",
                                                 publisher: "", recipe_id: "", image_url: "",
                                                 f2f_url:"", social_rank: ""))
            }
            print(recipeArray)
        }//End of DataTask Closure // 2
        task.resume() // 3
    }/// end of method getData
    
    
    func animateTable(){
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableviewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableviewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 2.0, delay: Double(delayCounter)*0.05,
                           usingSpringWithDamping: 0.8, initialSpringVelocity: 0,
                           options: .curveEaseInOut, animations:{
                            cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter+=1
        }
    } /// END animate table
}
