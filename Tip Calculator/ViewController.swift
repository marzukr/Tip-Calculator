//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Marzuk Rashid on 6/30/15.
//  Copyright © 2015 Marzuk Rashid. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var percentSegment: UISegmentedControl!
    @IBOutlet weak var tenPCTipButton: UIButton!
    @IBOutlet weak var fifteenPCTipButton: UIButton!
    @IBOutlet weak var twentyPCTipButton: UIButton!
    @IBOutlet weak var twentfivePCTipButton: UIButton!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var partyStepper: UIStepper!
    
    @IBOutlet weak var tipTotalLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    
    var billAmount:Double = 0
    var tipPercent = 10
    var party = 1
    
    //Here are all the IBOutlets and variables needed
    
    func calculateValues(bill:Double, tipPCent:Int, party:Int)
    {
        //This function calculates the total bill, tip, and bill per person and inserts the value
        //into the UILabels in the app given the bill total, tip percent, and number of members
        //in the party.
        
        let total = bill * (Double(tipPCent) / 100 + 1)
        let tipTotal = bill * (Double(tipPCent) / 100)
        
        if party != 1
        {
            let billPerPerson = total / Double(party)
            totalPerPersonLabel.text = String(format: "Total Per Person: $%.2f", billPerPerson)
            totalPerPersonLabel.hidden = false
        }
        else
        {
            totalPerPersonLabel.hidden = true
        }
        
        billTotalLabel.text = String(format: "Total: $%.2f", total)
        tipTotalLabel.text = String(format: "Tip: $%.2f", tipTotal)
    }
    
    func validateBillAmount(bill:String) -> Double
    {
        //This function checks that the user inputed bill amount is a valid number.
        
        if let check = Double(bill)
        {
            return check
        }
        else
        {
            return -4
        }
    }
    
    override func viewDidLoad()
    {
        //In viewDidLoad, the navigation bar title is styleized and the buttons are visually selected properly
        //and the program should calculate $0.00
        
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 26/255, green: 188/255, blue: 156/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        calculateValues(billAmount, tipPCent: tipPercent, party: party)
    }
    
    @IBAction func partyStepChanged(sender: AnyObject)
    {
        //This IBActions deals with changing the number of members in a party when the stepper is
        //pressed, as well as changing person to people when the party is > 1
        
        self.view.endEditing(true)
        party = Int(partyStepper.value)
        if party != 1
        {
            partyLabel.text = "\(party) People"
        }
        else
        {
            partyLabel.text = "\(party) Person"
        }
        calculateValues(billAmount, tipPCent: tipPercent, party: party)
    }

    @IBAction func billAmountChanged(sender: AnyObject)
    {
        //This IBAction makes sure the total is calculated live everytime the bill amount changes
        //when the user types, as well as validating the user's entry via the validateBillAmount
        //function, sending the user an error message if the entry is invalid.
        
        if validateBillAmount(billField.text!) != -4
        {
            billAmount = Double(billField.text!)!
            calculateValues(billAmount, tipPCent: tipPercent, party: party)
        }
        else if billField.text == ""
        {
            billAmount = 0
            calculateValues(billAmount, tipPCent: tipPercent, party: party)
        }
        else
        {
            billField.text = ""
            billAmount = 0
            calculateValues(billAmount, tipPCent: tipPercent, party: party)
            let alert = UIAlertController(title: "Error", message: "Please enter a valid number as the bill amount", preferredStyle: UIAlertControllerStyle.Alert)
            let okay = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(okay)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func changeTipPercent(pcent:Int)
    {
        //This function does the work when the tip percent is changed
        
        self.view.endEditing(true)
        tipPercent = pcent
        calculateValues(billAmount, tipPCent: tipPercent, party: party)
    }
    
    @IBAction func percentSelected(sender: AnyObject)
    {
        //This function sends the proper percent to the function changeTipPercent when the selected
        //percent changes.
        
        switch percentSegment.selectedSegmentIndex
        {
        case 0:
            changeTipPercent(10)
        case 1:
            changeTipPercent(15)
        case 2:
            changeTipPercent(20)
        case 3:
            changeTipPercent(25)
        default:
            break
        }
    }
    
    @IBAction func swipe(sender: AnyObject)
    {
        //This IBAction dismisses the keyboard when the user swipes down.
        
        self.view.endEditing(true)
    }
}

