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
    
    let defImage = UIImage(named: "camera5")

    
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
        guard people.count > indexPath.row else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let newPersons = people[indexPath.row]
        cell.namePerson.text = newPersons.name
        cell.namePerson.font = .boldSystemFont(ofSize: 19)
        cell.statusPerson.text = newPersons.status
        cell.dateBirthday.text = newPersons.dateBirthday
        
        
        
        //selected cell
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.2362961345, green: 0.9618863342, blue: 0.9818531826, alpha: 0.5))
        UITableViewCell.appearance().selectedBackgroundView = backgroundColorView

        cell.imagePerson.layer.cornerRadius = cell.imagePerson.frame.height / 3
        cell.imagePerson.clipsToBounds = true
        cell.backgroundColor = .clear
        cell.imagePerson.image?.jpegData(compressionQuality: 1.0)
        
        //action change image
        if newPersons.image == nil {
            cell.imagePerson.image = defImage
        } else {
            cell.imagePerson.image = UIImage(data: newPersons.image!)
        }
        
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
        
        //image convert to Data
        let imageData = newPersonVC.personImage.image?.pngData()
        taskObject.image = imageData
        
        
        
        do {
            try context.save()
            people.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
                }
        tableView.reloadData()

    }
    
    //Delete data from coreData
    @IBAction func deleteCoreData(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchReq:NSFetchRequest<Birthday> = Birthday.fetchRequest()
        
        if let days = try? context.fetch(fetchReq) {
            for day in days {
                context.delete(day)
            }
        }
        
        self.people.removeAll()

        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
                }
        tableView.reloadData()

    }
    
    //sms
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

