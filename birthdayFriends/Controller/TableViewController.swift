//
//  TableViewController.swift
//  birthdayFriends
//
//  Created by Shom on 01.08.2020.
//  Copyright © 2020 Shom. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    let persons = ["Шомахова Лилия", "Шомахова Заира", "Шомахов Залимхан"]
    let imagePerson = ["lilia", "zaira", "zsh"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = persons[indexPath.row]
        cell.imageView?.image = UIImage(named: imagePerson[indexPath.row])
        cell.imageView?.layer.cornerRadius = cell.frame.size.height / 3
        cell.imageView?.clipsToBounds = true

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


}
