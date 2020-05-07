//
//  AddTaskTableViewController.swift
//  DigBig
//
//  Created by macbook on 5/4/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit
import Firebase

class AddTaskTableViewController: UITableViewController {
    
    private var user: String = "Bolat Tleubayev"
    private var className: String = "Math"
    private var titlee: String = "Homework"
    private var type: String = "Presentation"
    private var text: String = "You should do this task"
    private var date: String = "5th of MAy, 2020"
    private var timestamp: Int = Int(Date().timeIntervalSince1970 * 1000)
    private var imageFileURL: String = ""
    private var attachedFileURL: String = ""
    
    @IBOutlet weak var subjectSegmentedControl: UISegmentedControl!
    @IBAction func subjectChanged(_ sender: UISegmentedControl) {
        switch subjectSegmentedControl.selectedSegmentIndex
        {
        case 0:
            className = "Math"
        case 1:
            className = "Kazakh"
        case 2:
            className = "English"
        default:
            break
        }
    }
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var taskTypeSegmentedControl: UISegmentedControl!
    @IBAction func taskTypeChanged(_ sender: UISegmentedControl) {
        switch taskTypeSegmentedControl.selectedSegmentIndex
        {
        case 0:
            type = "Presentation"
        case 1:
            type = "Document"
        case 2:
            type = "Link"
        default:
            break
        }
    }
    
    @IBOutlet weak var textTextView: UITextView!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var attachmentURLTextField: UITextField!
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        let POST_DB_REF: DatabaseReference = Database.database().reference().child("DigItems").childByAutoId()
        
        let post: [String : Any] = ["imageFileURL": "",
                                    "user": "Bolat Tleubayev",
                                    "timestamp": timestamp,
                                    "className": className,
                                    "title": taskTextField.text ?? "Homework",
                                    "type": type,
                                    "text": textTextView.text ?? "Some task description",
                                    "attachedFileURL": attachmentURLTextField.text ?? "https://google.com",
                                    "date": dateTextField.text ?? "5th of May, 2020"]

        POST_DB_REF.setValue(post)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.modifyNavigationController(navigationController: navigationController)
    }

}
