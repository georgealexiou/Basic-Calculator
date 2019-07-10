//
//  ViewController.swift
//  Basic Calculator
//
//  Created by George Alexiou on 10/07/2019.
//  Copyright © 2019 George Alexiou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberViewLabel: UILabel!
    
    var prevFloat: Float = 0.0
    var currFloat: Float = 0.0
    var currentNumber:String = ""
    
    var acEnabled: Bool = false
    
    var lastTag: Int = 0
    var isNegative: Bool = false
    var calculation: CalculationType = CalculationType.Nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel(labelToShow: "0")
    }
    
    //number button, -, %, +/- pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        //if numbers 1...9
        if(sender.tag <= 9){
            if(currentNumber != "0"){
                currentNumber = "\(currentNumber)\(sender.tag)"
            }
        }
            //if decimal seperator "."
        else if (sender.tag == 10){
            currentNumber = "\(currentNumber)."
        }
            //if +/-
        else if (sender.tag == 11){
            if(!isNegative){
                currentNumber = "-\(currentNumber)"
                isNegative = true
            }else if (isNegative){
                currentNumber.removeFirst()
                isNegative = false
            }
        }
            //if %
        else if (lastTag != 11 && sender.tag == 12){
            var floatCurrentNumber: Float = (currentNumber as NSString).floatValue
            floatCurrentNumber = floatCurrentNumber / 100
            currentNumber = "\(floatCurrentNumber)"
        }
        
        updateLabel(labelToShow: currentNumber)
        lastTag = sender.tag
        currFloat = (currentNumber as NSString).floatValue
    }
    
    //c button pressed (clear all)
    @IBAction func cButtonPressed(_ sender: UIButton) {
        if(acEnabled){
            currentNumber = ""
            lastTag = 0
            prevFloat = 0.0
            currFloat = 0.0
            updateLabel(labelToShow: "0")
        } else if (!acEnabled){
            currentNumber = ""
            lastTag = 0
            updateLabel(labelToShow: "0")
        }
        
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        calculateResult()
        calculation = CalculationType.Nil
    }
    
    // +,-,x,/ button pressed
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        //if this is not the first calculation on the number
        if(calculation != CalculationType.Nil){
            calculateResult();
        }
        //if this is the first calculation on the number
        else if (calculation == CalculationType.Nil){
            prevFloat = currFloat
            currFloat = 0.0
            lastTag = 0
            currentNumber = ""
            
        }
        defineCalculation(tag: sender.tag)
    }
    
    func calculateResult(){
        var result: Float = 0.0
        switch calculation{

        case CalculationType.Addition:
            result = currFloat + prevFloat
        
        case CalculationType.Subtraction:
            result = prevFloat-currFloat
            
        case CalculationType.Multiplication:
            result = prevFloat * currFloat
            
        case CalculationType.Division:
            result = prevFloat / currFloat
            
        default:
            print ("calculation of type Calculation type is CalculationType.Nil")
        }
        
        updateLabel(labelToShow: "\(result)")
        prevFloat = result
        currFloat = 0.0
        currentNumber = ""
        lastTag = 0
        isNegative = false
        
        
    }
    
    func updateLabel(labelToShow: String){
        numberViewLabel.text = labelToShow
    }
    
    func defineCalculation(tag: Int){
        switch tag{
        case 1:
            calculation = CalculationType.Division
            
        case 2:
            calculation = CalculationType.Multiplication
            
        case 3:
            calculation = CalculationType.Subtraction
            
        case 4:
            calculation = CalculationType.Addition
            
        default:
            print("Error - Could not assign calculation type")
        }
    }
}


enum CalculationType {
    case Division
    case Multiplication
    case Addition
    case Subtraction
    case Nil
}

