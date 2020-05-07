//
//  DuesCollectionViewController.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class DuesCollectionViewController: UICollectionViewController {
    
    @IBAction func reloadCollectionView(_ sender: UIBarButtonItem) {
        
        postfeed = []
        loadRecentPosts()
        collectionView.reloadData()
        
    }
    
    // MARK:- Firebase
    
    var postfeed: [DigItem] = []
    fileprivate var isLoadingPost = false // used for infinite scroll
    
    @objc fileprivate func loadRecentPosts() {
        isLoadingPost = true
        
        PostService.shared.getRecentPosts(start: postfeed.first?.timestamp, limit: 10) { (newPosts) in
            print("new post: \(newPosts)")
            
//            var sortedPosts: [DigItem] = []
//            
//            for newPost in newPosts {
//                if newPost.imageFileURL == "" {
//                    sortedPosts.append(newPost)
//                }
//            }
//            
            if newPosts.count > 0 {
                // Add the array to the beginning of the posts arrays
                self.postfeed.insert(contentsOf: newPosts, at: 0)
            }
            
            self.isLoadingPost = false
            
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.modifyNavigationController(navigationController: navigationController)
        self.title = "Dues"
        
        postfeed = []
        loadRecentPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postfeed = []
        loadRecentPosts()
        collectionView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revealDueTask" {
            let detailViewController = segue.destination as! DuesDetailViewController
            let indexPath = collectionView.indexPathsForSelectedItems?.first!
            detailViewController.item = postfeed[indexPath!.row]
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return postfeed.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DigItemCollectionViewCell
        
        
        if postfeed[indexPath.row].className == "Math" {
            cell.digItemImageView.image = UIImage(named: "mathVertical")!
        } else if postfeed[indexPath.row].className == "English" {
            cell.digItemImageView.image = UIImage(named: "englishVertical")!
        } else {
            cell.digItemImageView.image = UIImage(named: "kazakhVertical")!
        }
        
        // Checking completeness
        if postfeed[indexPath.row].imageFileURL != "" {
            cell.completenessIndidcatorImageView.isHidden = false
        } else {
            cell.completenessIndidcatorImageView.isHidden = true
        }
        
        cell.digItemTitle.text = postfeed[indexPath.row].className
        cell.digItemSubtitle.text = postfeed[indexPath.row].title
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "revealDueTask", sender: self)
    }
}
