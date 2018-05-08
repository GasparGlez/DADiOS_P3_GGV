//
//  PACServices.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

class Services {
    static var storedMovements: [Movement]?
    
    static func validate(username: String, password: String) -> Bool {
        if (username == "uoc" && password == "1234") {
            return true;
        } else {
            return false;
        }
    }
    
    static func validate(code: String) -> Bool {
        if (code == "1234") {
            return true;
        } else {
            return false;
        }
    }
    
    static func calculateFinalAmount(ForAmount amount: Float, WithInterest interest: Double, AndYears years: Double) -> Double {
        let final = Double(amount) * pow(1 + Double(interest), Double(years))
        
        return final
    }
    
    static func getMovements() -> [Movement] {
        // Provide a seed to generate predictable but random Movements
        srandom(10)
        
        if let movements = storedMovements {
            return movements
        } else {
            Services.storedMovements = [Movement]()
            
            for i:Int in 1...50 {
                var date: Date
                
                if i <= 4 {
                    date = Date()
                } else {
                    date = Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date()
                }
                let movement = Movement(random: true, date: date)
                Services.storedMovements?.append(movement)
            }
            
            return Services.storedMovements ?? [Movement]()
        }
    }
}
