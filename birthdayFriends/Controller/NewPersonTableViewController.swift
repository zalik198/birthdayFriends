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
    
    var newPerson: Person?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "back.png"), for: .default)
        tableView.backgroundView = UIImageView(image: UIImage(named: "back.png"))
        
        tableView.tableFooterView = UIView()//скрытие пустых ячеек
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        //imageView
        personImage.image = UIImage(named: "camera5")
        personImage.contentMode = .center
       
        
        //MARK: Text fields settings
        nameTF.borderStyle = .none
        nameTF.autocapitalizationType = .sentences
        nameTF.returnKeyType = .done
        statusTF.borderStyle = .none
        statusTF.autocapitalizationType = .sentences
        statusTF.returnKeyType = .done
        datePicker.datePickerMode = .date
        birthdayTF.inputView = datePicker
        birthdayTF.returnKeyType = .done
        
        

        //кнопка Готово
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        birthdayTF.inputAccessoryView = toolbar
        
        //saveButton доступность при заполнении имени
        saveButton.isEnabled = false
        
        nameTF.addTarget(self, action: #selector(textFieldName), for: .editingChanged)
        
        
    }
    
    //действие при нажатии на Готово
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    //формат даты
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthdayTF.text = formatter.string(from: datePicker.date)
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
            personImage.contentMode = .scaleAspectFit
            personImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //если свойство имя не пустое
    @objc private func textFieldName() {
        if nameTF.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    
    func saveNewPerson() {
        newPerson = Person(name: nameTF.text!, status: statusTF.text, dateBirthday: birthdayTF.text, image: personImage.image, personImage: nil)
    }
    
  
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
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
