//
//  Profile.swift
//  PR3
//
//  Copyright © 2018 uoc. All rights reserved.
//

import Foundation

//
//  Profile.swift
//  PR3
//
//  Created by Xavier Pereta on 08/05/2017.
//  Copyright © 2017 uoc. All rights reserved.
//

import Foundation

class Profile: NSObject, NSCoding {
    var name: String
    var surname: String
    var streetAddress: String
    var city: String
    var occupation: String
    var company: String
    var income: Int
    
    init(name: String, surname: String, streetAddress: String, city: String, occupation: String, company: String, income: Int) {
        self.name = name
        self.surname = surname
        self.streetAddress = streetAddress
        self.city = city
        self.occupation = occupation
        self.company = company
        self.income = income
        
        super.init()
    }
    
    convenience override init() {
        self.init(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        surname = aDecoder.decodeObject(forKey: "surname") as! String
        streetAddress = aDecoder.decodeObject(forKey: "streetAddress") as! String
        city = aDecoder.decodeObject(forKey: "city") as! String
        occupation = aDecoder.decodeObject(forKey: "occupation") as! String
        company = aDecoder.decodeObject(forKey: "company") as! String
        income = aDecoder.decodeInteger(forKey: "income")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(surname, forKey: "surname")
        aCoder.encode(streetAddress, forKey: "streetAddress")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(occupation, forKey: "occupation")
        aCoder.encode(company, forKey: "company")
        aCoder.encode(income, forKey: "income")
    }
}
