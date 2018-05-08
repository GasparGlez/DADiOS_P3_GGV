//
//  CalculatorViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var initialAmountLabel: UILabel!
    @IBOutlet weak var initialAmountSlider: UISlider!
    @IBOutlet weak var interestRateLabel: UILabel!
    @IBOutlet weak var interestRateStepper: UIStepper!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var yearsStepper: UIStepper!
    @IBOutlet weak var finalAmountLabel: UILabel!
    
    
    @IBAction func initialAmountChanged(_ sender: UISlider) {
        updateLabels()
        updateFinalAmout()
    }
    
    @IBAction func interestRateChanged(_ sender: UIStepper) {
        updateLabels()
        updateFinalAmout()
    }
    
    @IBAction func yearsChanged(_ sender: UIStepper) {
        updateLabels()
        updateFinalAmout()
    }
    
    func updateLabels() {
        let initialAmount = initialAmountSlider.value
        let interestRate = interestRateStepper.value
        let years = yearsStepper.value

        initialAmountLabel.text = String.init(format: "Initial amount: %.0f €", initialAmount)
        interestRateLabel.text = String.init(format: "Interest rate: %.2f %", interestRate)
        yearsLabel.text = String.init(format: "Years: %.0f", years)
    }
    
    func updateFinalAmout() {
        let initialAmount = initialAmountSlider.value
        let interestRate = interestRateStepper.value / 100
        let years = yearsStepper.value

        let finalAmount = Services.calculateFinalAmount(ForAmount: initialAmount, WithInterest: interestRate, AndYears: years)
        
        finalAmountLabel.text = String.init(format: "Final amount: %.2f €", finalAmount)
    }
    
    override func viewDidLoad() {
        initialAmountSlider.value = 100
        interestRateStepper.value = 1
        yearsStepper.value = 1
        
        updateLabels()
        updateFinalAmout()
    }
}
