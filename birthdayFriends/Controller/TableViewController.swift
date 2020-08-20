//
//  TableViewController.swift
//  birthdayFriends
//
//  Created by Shom on 01.08.2020.
//  Copyright © 2020 Shom. All rights reserved.
//

import UIKit
import MessageUI
import CoreData

class TableViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    var person = Person.getPersons()
    var people: [Birthday] = []

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "back.png"))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "back.png"), for: .default)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchReq:NSFetchRequest<Birthday> = Birthday.fetchRequest()
        do {
            people = try context.fetch(fetchReq)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }

    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let newPersons = people[indexPath.row]
        
        cell.namePerson.text = newPersons.name
        cell.namePerson.font = .boldSystemFont(ofSize: 19)
        cell.statusPerson.text = newPersons.status
        cell.dateBirthday.text = newPersons.dateBirthday
        
//        if newPersons.image == nil {
//            cell.imagePerson.image = UIImage(named: newPersons.personImage!)
//        } else {
//            cell.imagePerson.image = newPersons.image
//        }
        
        cell.imagePerson.layer.cornerRadius = cell.imagePerson.frame.height / 3
        cell.imagePerson.clipsToBounds = true
        cell.backgroundColor = .clear

        return cell
    }



    // MARK: - Navigation

    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
      
        
        guard let newPersonVC = segue.source as? NewPersonTableViewController else { return }
        newPersonVC.saveNewPerson()
        person.append(newPersonVC.newPerson!)
        tableView.reloadData()
        
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            
        guard let entiti = NSEntityDescription.entity(forEntityName: "Birthday", in: context) else { return }
        let taskObject = Birthday(entity: entiti, insertInto: context)
        taskObject.name = newPersonVC.nameTF.text
        taskObject.status = newPersonVC.statusTF.text
        taskObject.dateBirthday = newPersonVC.birthdayTF.text
        
                
                do {
                    try context.save()
                    people.append(taskObject)
                    tableView.reloadData()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
        
    
    }
    
    
    @IBAction func messageAction(_ sender: UIButton) {
        if MFMessageComposeViewController.canSendText() == true {
            let sms:[String] = [""]//номер
            let messageController = MFMessageComposeViewController()
            messageController.messageComposeDelegate = self
            messageController.recipients = sms
            messageController.body = "С днем рождения!"//текст
            self.present(messageController, animated: true, completion: nil)
        } else {
            print("hi")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
      }
}

