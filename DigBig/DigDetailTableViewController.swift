//
//  DigDetailTableViewController.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit
import SafariServices

class DigDetailTableViewController: UITableViewController {
    
    var className: String?
    
    // MARK:- Firebase
    
    var postfeed: [DigItem] = []
    fileprivate var isLoadingPost = false // used for infinite scroll
    
    @objc fileprivate func loadRecentPosts() {
        isLoadingPost = true
        
        PostService.shared.getRecentPosts(start: postfeed.first?.timestamp, limit: 10) { (newPosts) in
            print("new post: \(newPosts)")
            
            var sortedPosts: [DigItem] = []
            
            for newPost in newPosts {
                if let className = self.className {
                    if newPost.className == className {
                        sortedPosts.append(newPost)
                    }
                }
            }
            
            if newPosts.count > 0 {
                // Add the array to the beginning of the posts arrays
                self.postfeed.insert(contentsOf: sortedPosts, at: 0)
            }
            
            self.isLoadingPost = false
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.modifyNavigationController(navigationController: navigationController)
        loadRecentPosts()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postfeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DigDetailTableViewCell
        
        if postfeed[indexPath.row].type == "Presentation" {
            cell.digDetailImageView.image = UIImage(named: "letterP")
        } else if postfeed[indexPath.row].type == "Link" {
            cell.digDetailImageView.image = UIImage(named: "letterL")
        } else {
            cell.digDetailImageView.image = UIImage(named: "letterD")
        }
        
        cell.digDetailTitleLabel.text = postfeed[indexPath.row].title
        cell.digDetailSubtitleLabel.text = postfeed[indexPath.row].type
        
//        if classData?.digItems[indexPath.row].type == "Presentation" {
//            cell.digDetailImageView.image = UIImage(named: "letterP")
//        } else if classData?.digItems[indexPath.row].type == "Link" {
//            cell.digDetailImageView.image = UIImage(named: "letterL")
//        } else {
//            cell.digDetailImageView.image = UIImage(named: "letterD")
//        }
//
//        cell.digDetailTitleLabel.text = classData?.digItems[indexPath.row].title
//        cell.digDetailSubtitleLabel.text = classData?.digItems[indexPath.row].type
//
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if postfeed[indexPath.row].type == "Presentation" {
            if let url = URL(string: postfeed[indexPath.row].attachedFileURL ?? "https://google.com") {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        } else if postfeed[indexPath.row].type == "Link" {
            if let url = URL(string: postfeed[indexPath.row].attachedFileURL ?? "https://google.com") {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        } else if postfeed[indexPath.row].type == "Document" {
            if let url = URL(string: postfeed[indexPath.row].attachedFileURL ?? "https://google.com") {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        } else {
            if let url = URL(string: "https://google.com") {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        }
    }
}
