//
//  NumericKeyboardView.swift
//  SampleKeyboard
//
//  Created by Furuyama Takeshi on 2015/02/28.
//  Copyright (c) 2015年 Furuyama Takeshi. All rights reserved.
//

import UIKit

enum Operation {
    case Addition
    case Multiplication
    case Subtraction
    case Division
    case Equal
    case None
}

protocol NumericKeyboardViewDelegate {
    func enterButtonDidPushed(resultLabelString: String?)
}

class NumericKeyboardView: UIView {

    var view: UIView!
    var delegate: NumericKeyboardViewDelegate! = nil
    
    @IBOutlet weak var display: UILabel!
    
    var shouldClearDisplayBeforeInserting = true
    var internalMemory = 0.0
    var nextOperation = Operation.None
    var shouldCompute = false

    @IBOutlet weak var numberLabel: RoundLabel!
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "NumericKeyboardView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }
    
    @IBAction func cleanDisplay(sender: AnyObject) {
        self.display.text = "0"
        internalMemory = 0.0
        nextOperation = Operation.Addition
        shouldClearDisplayBeforeInserting = true
    }
    
    @IBAction func didTapNumber(number: UIButton) {
        if shouldClearDisplayBeforeInserting {
            display.text = ""
            shouldClearDisplayBeforeInserting = false
        }
        
        if var numberAsString = number.titleLabel?.text {
            var numberAsNSString = numberAsString as NSString
            if var oldDisplay = display?.text! {
                display.text = "\(oldDisplay)\(numberAsNSString.intValue)"
            } else {
                display.text = "\(numberAsNSString.intValue)"
            }
        }
        shouldCompute = true
    }
    @IBAction func didTapOperation(operation: UIButton) {

        if shouldCompute {
            computeLastOperation()
        }
        
        if var op = operation.titleLabel?.text {
            switch op {
            case "+":
                nextOperation = Operation.Addition
            case "-":
                nextOperation = Operation.Subtraction
            case "X":
                nextOperation = Operation.Multiplication
            case "%":
                nextOperation = Operation.Division
            default:
                nextOperation = Operation.None
            }
        }
        shouldClearDisplayBeforeInserting = true
    }
    
    @IBAction func computeLastOperation() {
        // remember not to compute if another operation is pressed without inputing another number first
        
        if var input = display?.text {
            var inputAsDouble = (input as NSString).doubleValue
            var result = 0.0
            
            // apply the operation
            switch nextOperation {
            case .Addition:
                result = internalMemory + inputAsDouble
            case .Subtraction:
                result = internalMemory - inputAsDouble
            case .Multiplication:
                result = internalMemory * inputAsDouble
            case .Division:
                result = internalMemory / inputAsDouble
            default:
                result = 0.0
            }
            
            nextOperation = Operation.None
            
            var output = "\(result)"
            
            // if the result is an integer don't show the decimal point
            if output.hasSuffix(".0") {
                output = "\(Int(result))"
            }
            
            // truncatingg to last five digits
            var components = output.componentsSeparatedByString(".")
            if components.count >= 2 {
                var beforePoint = components[0]
                var afterPoint = components[1]
                if afterPoint.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 5 {
                    let index: String.Index = advance(afterPoint.startIndex, 5)
                    afterPoint = afterPoint.substringToIndex(index)
                }
                output = beforePoint + "." + afterPoint
            }
            
            // update the display
            display.text = output
            
            // save the result
            internalMemory = result
            
            // remember to clear the display before inserting a new number
            shouldClearDisplayBeforeInserting = true
            shouldCompute = false
        }
    }
    
    @IBAction func enterButtonDidPush(sender: AnyObject) {
        self.delegate.enterButtonDidPushed(display.text)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        xibSetup()
    }
    
}
