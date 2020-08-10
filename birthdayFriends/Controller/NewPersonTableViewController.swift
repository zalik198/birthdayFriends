//
//  NewPersonTableViewController.swift
//  birthdayFriends
//
//  Created by Shom on 05.08.2020.
//  Copyright © 2020 Shom. All rights reserved.
//
//Сделать красивым этот экран

import UIKit

class NewPersonTableViewController: UITableViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "back.png"))
        
        tableView.tableFooterView = UIView()//скртыие пустых ячеек
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        
       
        
        //MARK: Text fields settings
        nameTF.borderStyle = .none
        nameTF.autocapitalizationType = .sentences
        nameTF.returnKeyType = .done
        statusTF.borderStyle = .none
        statusTF.autocapitalizationType = .sentences
        statusTF.returnKeyType = .done
        birthdayTF.borderStyle = .none
        birthdayTF.autocapitalizationType = .sentences
        birthdayTF.returnKeyType = .done
        
        //imageView.backgroundColor = UIColor(patternImage: UIImage(named: "back.png")!)

    

        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
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
