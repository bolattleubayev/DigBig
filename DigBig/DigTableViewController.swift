//
//  DigTableViewController.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class DigTableViewController: UITableViewController {
    
    let classNames = ["Kazakh", "English", "Math"]
    let displayNames = ["Қазақ тілі", "English", "Математика"]
    let imageNames = ["kazakhLogo","englishLogo","mathLogo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.modifyNavigationController(navigationController: navigationController)
        self.title = "Dig"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return classNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DigTableViewCell
        
        cell.digCellTitle.text = displayNames[indexPath.row]
        cell.digCellImageView.image = UIImage(named: imageNames[indexPath.row])
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showClassData" {
            let detailViewController = segue.destination as! DigDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            detailViewController.className = classNames[indexPath!.row]
        }
    }
    
    
}
