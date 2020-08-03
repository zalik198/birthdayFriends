//
//  Model.swift
//  birthdayFriends
//
//  Created by Shom on 03.08.2020.
//  Copyright © 2020 Shom. All rights reserved.
//

import Foundation

struct Person {
    
    var name: String
    var status: String
    var dateBirthday: String
    var image: String
    
    static let personsAndImage = [("Шомахова Лилия", "lilia", "Дочка", "22.12.2015"), ("Шомахова Заира", "zaira", "Жена", "18.03.1991"), ("Шомахов Залимхан", "zsh", "Я", "15.07.1991")]
    //static let statusAndBirthday = ["Дочка": "22.12.2015", "Жена": "18.03.1991", "Я": "15.07.1991"]
   // static let personsAll = ["Шомахова Лилия", "Шомахова Заира", "Шомахов Залимхан"]
   
    
    
    static func getPersons() -> [Person] {

        var persons = [Person]()
        
        for (person, image, status, date) in  personsAndImage {
            persons.append(Person(name: person, status: status, dateBirthday: date, image: image))
            
        }
        
      
        
        return persons
    }
    
}
