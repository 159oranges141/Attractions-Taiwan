//
//  NewSceneController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/13.
//

import UIKit

class NewSceneController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: RoundTextField! {
        didSet {
            nameTextField.tag = 0
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var cityTextField: RoundTextField! {
        didSet {
            cityTextField.tag = 1
            cityTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundTextField! {
        didSet {
            addressTextField.tag = 2
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 3
            descriptionTextView.layer.cornerRadius = 10.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var photoImageView1: UIImageView!
    
    @IBOutlet var photoImageView2: UIImageView!
    
    @IBOutlet var photoImageView3: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    //imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    //imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if nameTextField.text == "" || cityTextField.text == "" || addressTextField.text == "" || descriptionTextView.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let scenes = Scene(context: appDelegate.persistentContainer.viewContext)
        scenes.name = nameTextField.text!
        scenes.city = cityTextField.text!
        scenes.address = addressTextField.text!
        scenes.descript = descriptionTextView.text
        if let imageData1 = photoImageView1.image?.pngData() {  //having a default image already
            scenes.photo1 = imageData1
            scenes.photoCount = 1
        }
        if let imageData2 = photoImageView1.image?.pngData() {  //having a default image already
            scenes.photo2 = imageData2
            scenes.photoCount = 2
        }
        if let imageData3 = photoImageView1.image?.pngData() {  //having a default image already
            scenes.photo3 = imageData3
            scenes.photoCount = 3
        }
        
        appDelegate.saveContext()
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }

}

extension NewSceneController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage1 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView1.image = selectedImage1
            photoImageView1.contentMode = .scaleAspectFill
            photoImageView1.clipsToBounds = true
        }
        
        if let selectedImage2 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView2.image = selectedImage2
            photoImageView2.contentMode = .scaleAspectFill
            photoImageView2.clipsToBounds = true
        }
        
        if let selectedImage3 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView3.image = selectedImage3
            photoImageView3.contentMode = .scaleAspectFill
            photoImageView3.clipsToBounds = true
        }
        
        //set constraints here
        
        // get the selectedImageName
        //if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
        //selectedImageName = url.path
        //print(selectedImageName)
        //}
        
        
        dismiss(animated: true, completion: nil)
    }
    
}
