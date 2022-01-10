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
    
    var imageselector: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDelegate methods
    
    @IBAction func AddFirstPhoto(sender: UIButton) {
        let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
        
        imageselector = 1
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        
        present(photoSourceRequestController, animated: true, completion: nil)
        
    }
    
    @IBAction func AddSecondPhoto(sender: UIButton) {
        let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
        
        imageselector = 2
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        
        present(photoSourceRequestController, animated: true, completion: nil)
    }
    
    @IBAction func AddThirdPhoto(sender: UIButton) {
        let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
        
        imageselector = 3
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        
        present(photoSourceRequestController, animated: true, completion: nil)
    }
    
    @IBAction func DeleteFirstPhoto(sender: UIButton) {
        photoImageView1.image = nil
    }
    @IBAction func DeleteSecondPhoto(sender: UIButton) {
        photoImageView2.image = nil
    }
    @IBAction func DeleteThirdPhoto(sender: UIButton) {
        photoImageView3.image = nil
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
                scenes.photoCount += 1
        }
        if let imageData2 = photoImageView2.image?.pngData() {  //having a default image already
            scenes.photo2 = imageData2
            scenes.photoCount += 1
        }
        if let imageData3 = photoImageView3.image?.pngData() {  //having a default image already
            scenes.photo3 = imageData3
            scenes.photoCount += 1
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
            if imageselector == 1 {
                photoImageView1.image = selectedImage1
                photoImageView1.contentMode = .scaleAspectFill
                photoImageView1.clipsToBounds = true
            }
        }
        
        if let selectedImage2 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if imageselector == 2 {
                photoImageView2.image = selectedImage2
                photoImageView2.contentMode = .scaleAspectFill
                photoImageView2.clipsToBounds = true
            }
        }

        if let selectedImage3 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if imageselector == 3 {
                photoImageView3.image = selectedImage3
                photoImageView3.contentMode = .scaleAspectFill
                photoImageView3.clipsToBounds = true
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerTwo(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

    }
    
    
}
