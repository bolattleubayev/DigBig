//
//  SubmissionTableViewController.swift
//  DigBig
//
//  Created by macbook on 5/4/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit
import Firebase

class SubmissionTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var item: DigItem?
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var photoIconImageView: UIImageView!
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        if let item = item {
            let POST_DB_REF: DatabaseReference = Database.database().reference().child("DigItems")
            let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")
            
            // Generate a unique ID for the post and prepare the post database reference
            let postDatabaseRef = POST_DB_REF.child(item.postID)
            
            // Use the unique key as the image name and prepare the storage reference
            guard let imageKey = postDatabaseRef.key else {
                return
            }
            
            let imageStorageRef = PHOTO_STORAGE_REF.child("\(imageKey).jpg")
            
            // Resize the image
            let scaledImage = photoIconImageView.image!.scale(newWidth: 640.0)
            
            guard let imageData = scaledImage.jpegData(compressionQuality: 0.9) else {
                return
            }
            
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            // Prepare the upload task
            let uploadTask = imageStorageRef.putData(imageData, metadata: metadata)
            
            // Observe the upload status
            uploadTask.observe(.success) { (snapshot) in
                
                guard let displayName = Auth.auth().currentUser?.displayName else {
                    return
                }
                
                snapshot.reference.downloadURL(completion: { (url, error) in
                    guard let url = url else {
                        return
                    }
                    
                    // Add a reference in the database
                    
                    let imageFileURL = url.absoluteString
                    let timestamp = Int(Date().timeIntervalSince1970 * 1000)
                    
                    
                    
                    let post: [String : Any] = ["imageFileURL": imageFileURL,
                                                "user": "Bolat Tleubayev",
                                                "timestamp": timestamp,
                                                "className": item.className,
                                                "title": item.title,
                                                "type": item.type,
                                                "text": item.text,
                                                "attachedFileURL": item.attachedFileURL,
                                                "date": item.date]
                    
                    postDatabaseRef.setValue(post)
                })
            }
            
            uploadTask.observe(.progress) { (snapshot) in
                
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                
                print("Uploading \(imageKey).jpg... \(percentComplete)% complete")
                
            }
            
            uploadTask.observe(.failure) { (snapshot) in
                
                if let error = snapshot.error {
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Constants.modifyNavigationController(navigationController: navigationController)
        
        imagePicker.delegate = self
        
        let url = URL(string: item!.imageFileURL)
        
        if let url = url {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.photoIconImageView.image = UIImage(data: data!)
                }
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("selected")
            photoIconImageView.image = selectedImage
            photoIconImageView.contentMode = .scaleAspectFit
            photoIconImageView.clipsToBounds = true
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func callImagePicker() {
        let alert = UIAlertController(title: "Select Image Source", message: "Please choose the image source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                let alert  = UIAlertController(title: "Warning", message: "This source type is not available", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })

        let photoGalleryAction = UIAlertAction(title: "Photo Gallery", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        
        alert.addAction(cameraAction)
        alert.addAction(photoGalleryAction)
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        // Handling the iPad action sheet representation
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath) {
        case [0, 0]:
            callImagePicker()
        default: break
        }
    }
}

