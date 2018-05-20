//
//  Utils.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func show(Message message: String, WithTitle title: String, InViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension UIColor {
    func lighter(by percentage: CGFloat = 80.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }
        func darker(by percentage: CGFloat = 80.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0,0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}
// GGV Function to check a valid amount formatted
extension String {
    func isValidIncome(maxDecimalPlaces: Int) -> Bool {
        // We use a NumberFormatter to check if we can turn the string into a number and to get the locale specific decimal separator.
        let formatter = NumberFormatter()
        formatter.allowsFloats = true // Default true
        let decimalSeparator = formatter.decimalSeparator ?? ","  // Gets the locale specific decimal separator. Anyway, we assume "," is used as separator.
        
        // Check if we can create a valid number. (The formatter creates a NSNumber)
        if formatter.number(from: self) != nil {
            
            //let number = formatter.number(from: self) ?? -1.00
            
            // Split our string at the decimal separator
            let split = self.components(separatedBy: decimalSeparator)
            
            // Depending on whether there was a decimalSeparator we may have one
            // or two parts now. If it is two then the second part is the one after
            // the separator, aka the digits we care about.
            // If there was no separator then the user hasn't entered a decimal
            // number yet and we treat the string as empty, succeeding the check
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            // Finally check if we're <= the allowed digits
            let checkDecimalPlaces = digits.count <= maxDecimalPlaces
            //let checkPositiveNumber = !(number.floatValue.isLess(than: 0.00))
            return checkDecimalPlaces //&& checkPositiveNumber
        }
        
        return false // couldn't turn string into a valid number
    }
}
