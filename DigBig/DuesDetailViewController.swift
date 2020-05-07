//
//  DuesDetailViewController.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class DuesDetailViewController: UIViewController {
    
    var item: DigItem?
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailSubtitleLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.modifyNavigationController(navigationController: navigationController)
        
        if let item = item {
            detailTitleLabel.text = item.title
            detailSubtitleLabel.text = item.date
            detailTextView.text = item.text
        
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubmission" {
            let detailViewController = segue.destination as! SubmissionTableViewController
            detailViewController.item = item
        }
    }
    

}
