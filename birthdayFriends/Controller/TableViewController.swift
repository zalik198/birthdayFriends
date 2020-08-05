//
//  TableViewController.swift
//  birthdayFriends
//
//  Created by Shom on 01.08.2020.
//  Copyright © 2020 Shom. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
   
    
    let person = Person.getPersons()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.namePerson.text = person[indexPath.row].name
        cell.statusPerson.text = person[indexPath.row].status
        cell.dateBirthday.text = person[indexPath.row].dateBirthday
        cell.imagePerson.image = UIImage(named: person[indexPath.row].image)
        cell.imagePerson.layer.cornerRadius = cell.imagePerson.frame.height / 3
        cell.imagePerson.clipsToBounds = true

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func cancel(_ segue: UIStoryboardSegue) {}


}
