//
//  Movement.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

class Movement: NSObject {
    var date: Date
    var valueDate: Date
    var movementDescription: String
    var amount: Decimal
    var balance: Decimal
    var category: String
    var rejected: Bool
    
    init(date: Date, valueDate: Date, movementDescription: String, amount: Decimal, balance: Decimal, category: String, rejected: Bool) {
        self.date = date
        self.valueDate = valueDate
        self.movementDescription = movementDescription
        self.amount = amount
        self.balance = balance
        self.category = category
        self.rejected = rejected
        
        super.init()
    }
    
    convenience init(random: Bool = false, date: Date = Date()) {
        if random {
            let valueDate = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
            let origins = ["Gas Company", "Phone Company", "Electricity Company", "Flight tickets", "Credit card", "University", "John Smith", "Dolce Roma Cafe", "Sports Bar", "Apple Inc."]
            let origin = origins[Int(arc4random_uniform(UInt32(origins.count)))]

            let actions = ["Salary payment from", "Bill from", "Invoice", "Transfer from", "Transfer to", "Purchase with card 4501XXXXXXXX1165 in", "Macbook Pro purchase"]
            let action = actions[Int(arc4random_uniform(UInt32(actions.count)))]
            
            let places = ["Curitiba", "Madrid", "London", "Barcelona", "Paris", "Roma", "Dublin", "Buenos Aires", "Sucre", "Brasilia", "Santiago de Chile", "Bogotá", "Quito", "Asunción", "Lima", "Montevideo", "Caracas", "Ottawa", "San José", "La Habana", "San Salvador", "Guatemala", "Tegucigalpa", "México", "Managua", "Santo Domingo"]
            let place = places[Int(arc4random_uniform(UInt32(places.count)))]
            
            let movementDescription = "\(action) \(origin) - \(place)"
            
            let amount = Movement.randomAmount(lower: -1000, upper: 1000)
            
            let balance = Movement.randomAmount(lower: 5000, upper: 10000)
            
            let categories = ["Transfers", "Credit cards", "Direct debits", "Withdrawals"]
            let category = categories[Int(arc4random_uniform(UInt32(categories.count)))]
            
            let rejected = false
            
            self.init(date: date, valueDate: valueDate, movementDescription: movementDescription, amount: amount, balance: balance, category: category, rejected: rejected)
        } else {
            self.init(date: Date(), valueDate: Date(), movementDescription: "", amount: 0, balance: 0, category: "Transfers", rejected: false)
        }
    }
    
    class func randomAmount(lower: Int, upper: Int) -> Decimal {
        let amount = Int(arc4random_uniform(UInt32(upper - lower + 1))) + lower
        return Decimal(amount)
    }
}
