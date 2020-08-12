//
//  NewPersonTableViewController.swift
//  birthdayFriends
//
//  Created by Shom on 05.08.2020.
//  Copyright © 2020 Shom. All rights reserved.
//
//Сделать красивым этот экран

import UIKit

class NewPersonTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "back.png"), for: .default)
        tableView.backgroundView = UIImageView(image: UIImage(named: "back.png"))
        
        tableView.tableFooterView = UIView()//скртыие пустых ячеек
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        //imageView
        imageView.image = UIImage(named: "camera5")
        imageView.contentMode = .center
       
        
        //MARK: Text fields settings
        nameTF.borderStyle = .none
        nameTF.autocapitalizationType = .sentences
        nameTF.returnKeyType = .done
        statusTF.borderStyle = .none
        statusTF.autocapitalizationType = .sentences
        statusTF.returnKeyType = .done
        birthdayTF.borderStyle = .none
        birthdayTF.inputAccessoryView = picker
        birthdayTF.returnKeyType = .done
        
        //сделать в другом методе
        let pickerDate = picker.date
        birthdayTF.text = String("\(pickerDate)")

    }
    
  
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alert = UIAlertController(title: "Choos Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallery()}))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            view.endEditing(true)
        }
    }
    
    
    //OpenCameraAction
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //OpenGalleryAction
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - ImagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
  


}

//MARK: Text field delegate

extension NewPersonTableViewController: UITextFieldDelegate {
    
    //скрытие клавы по нажатию на Готово
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
