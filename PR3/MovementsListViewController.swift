//
//  MovementsListViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementsListViewController: UITableViewController {
    var movements: [Movement]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMovements()
    }
    
    func setupMovements() {
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        movements = Services.getMovements()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movementsCount = movements.count
        
        if indexPath.row < movementsCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as! MovementCell
            
            let movement = movements[indexPath.row]
            
            cell.descriptionLabel.text = movement.movementDescription
            
            let amountFormatter = NumberFormatter()
            amountFormatter.numberStyle = .currency
            amountFormatter.currencySymbol = "€"
            amountFormatter.currencyDecimalSeparator = ","
            amountFormatter.currencyGroupingSeparator = "."
            amountFormatter.positiveFormat = "#,##0.00 ¤"
            amountFormatter.negativeFormat = "-#,##0.00 ¤"
            
            cell.amountLabel.text = amountFormatter.string(from: movement.amount as NSDecimalNumber)
            
            if movement.amount >= 0 {
                cell.amountLabel.textColor = UIColor.black
            } else {
                cell.amountLabel.textColor = UIColor.red
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            cell.dateLabel.text = dateFormatter.string(from: movement.date)
            
            if movement.rejected {
                cell.backgroundColor = UIColor.orange.lighter()
            } else {
                cell.backgroundColor = UIColor.white
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastMovementCell", for: indexPath)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // Get all movements
            movements = Services.getMovements()
        } else {
            // Get all movements and keep only those from today
            let allMovements = Services.getMovements()
            
            let filteredMovements = allMovements.filter { Calendar.current.isDateInToday($0.date) }
            
            movements = filteredMovements
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToMovementDetail" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let movement = movements[row]
                
                let destinationViewController = segue.destination as! MovementDetailViewController
                
                destinationViewController.movement = movement
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
