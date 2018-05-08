//
//  MovementDetailViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController {
    var movement: Movement!

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let amountFormatter = NumberFormatter()
        amountFormatter.numberStyle = .currency
        amountFormatter.currencySymbol = "€"
        amountFormatter.currencyDecimalSeparator = ","
        amountFormatter.currencyGroupingSeparator = "."
        amountFormatter.positiveFormat = "#,##0.00 ¤"
        amountFormatter.negativeFormat = "-#,##0.00 ¤"
        
        amountLabel.text = amountFormatter.string(from: movement.amount as NSDecimalNumber)
        
        if movement.amount >= 0 {
            amountLabel.textColor = UIColor.black
        } else {
            amountLabel.textColor = UIColor.red
        }
        
        balanceLabel.text = amountFormatter.string(from: movement.balance as NSDecimalNumber)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dateLabel.text = dateFormatter.string(from: movement.date)
        valueDateLabel.text = dateFormatter.string(from: movement.valueDate)
        
        descriptionLabel.text = movement.movementDescription
        
        setupRejection()
    }
    
    func setupRejection() {
        if movement.rejected {
            let label = UILabel()
            
            label.text = "Rejected"
            label.textColor = UIColor.red
            label.textAlignment = .center
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(label)
            
            let topConstraint = label.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10)
            let leadingConstraint = label.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            let trailingConstraint = label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            topConstraint.isActive = true
            leadingConstraint.isActive = true
            trailingConstraint.isActive = true
        } else {
            let button = UIButton(type: .system)
            
            button.setTitle("Reject", for: .normal)
            button.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(button)
            
            let topConstraint = button.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10)
            let leadingConstraint = button.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            let trailingConstraint = button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            topConstraint.isActive = true
            leadingConstraint.isActive = true
            trailingConstraint.isActive = true
        }
    }
    
    @objc func rejectAction(sender: UIButton!) {
        movement.rejected = true

        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
