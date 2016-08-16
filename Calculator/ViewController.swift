//
//  ViewController.swift
//  Calculator
//
//  Created by Javier Rennola on 1/2/16.
//  Copyright © 2016 Javier Rennola. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
  
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber: Bool=false
    
    var brain = CalulatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber
        {
         display.text = display.text! + digit
         print("digit = \(digit)")
        }
        else
        {
         display.text = digit
         userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    
  @IBAction func operate(sender: UIButton) {

//      let operation = sender.currentTitle!
      if userIsInTheMiddleOfTypingNumber {
         enter()
        }
    if  let operation = sender.currentTitle
    {
        if  let result = brain.performOperation(operation)
        {
    
            displayValue = result
        }
        else
        {
            displayValue = 0
        }
    }
//        switch operation
//        {
//        case"×":performOperation {$0*$1}
//        case"÷":performOperation {$1/$0}
//        case"+":performOperation {$0+$1}
//        case"−":performOperation {$1-$0}
//        case"sin":performOperation2 {sin($0)}
//        case"cos":performOperation2 {cos($0)}
//        case"tan":performOperation2 {tan($0)}
//       default: break
//        }
        
        
    }
//        func performOperation (operation:(Double,Double)->Double)
//    {
//        if operandStack.count>=2
//        {
//            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
//            enter()
//        }
//    }
//    func performOperation2 (operation:Double->Double)
//    {
//        if operandStack.count>=1
//        {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }
    
//        var operandStack = Array<Double>()
    
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
       if let result = brain.pushOperand(displayValue)
       {
        displayValue = result
        }
        else
       {
        displayValue = 0 // display value took optional
        }
        
//        operandStack.append(displayValue)
//        print("operandStack = \(operandStack)")

        
    }
    
    
    var displayValue : Double
    {
        get
        {
         return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set
        {
         display.text = "\(newValue)"
         userIsInTheMiddleOfTypingNumber = false
        }
    }
 }

