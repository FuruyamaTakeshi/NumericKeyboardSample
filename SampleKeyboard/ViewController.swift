//
//  ViewController.swift
//  SampleKeyboard
//
//  Created by Furuyama Takeshi on 2015/02/28.
//  Copyright (c) 2015年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, NumericKeyboardViewDelegate {

    @IBOutlet weak var numericKeyboard: NumericKeyboardView!
    
    @IBOutlet weak var myTextField: UITextField!
    
    var boxlayer :CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let boxlayer = CALayer()
        boxlayer.bounds = CGRectMake(0.0, 0.0, 85.0, 85.0)
        boxlayer.position = CGPointMake(160.0, 300.0)
        let color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let cgReddish = color.CGColor
        boxlayer.backgroundColor = cgReddish
        // UIImageを生成する
        let layerImage = UIImage(named: "Hypno")
        let image = layerImage?.CGImage
        boxlayer.contents = image
        boxlayer.contentsRect = CGRectMake(-0.1, -0.1, 1.2, 1.2)
        boxlayer.contentsGravity = kCAGravityResizeAspect
        
        self.boxlayer = boxlayer
        
        self.numericKeyboard.layer.position = CGPointMake(160.0, 160.0)
        self.numericKeyboard.hidden = true
        self.numericKeyboard.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var t: AnyObject = touches.anyObject()!
        var p = t.locationInView(self.view)
        println("\(p), \(self.numericKeyboard.frame)")

        if (self.numericKeyboard.frame.origin.x < p.x && p.x < CGRectGetMaxX(self.numericKeyboard.frame) &&
            self.numericKeyboard.frame.origin.y < p.y && p.y < self.numericKeyboard.frame.origin.y + 40) {
            self.numericKeyboard.layer.position = p
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var t: AnyObject = touches.anyObject()!
        var p = t.locationInView(self.view)
        if (self.numericKeyboard.frame.origin.x < p.x && p.x < CGRectGetMaxX(self.numericKeyboard.frame) &&
            self.numericKeyboard.frame.origin.y < p.y && p.y < self.numericKeyboard.frame.origin.y + 40) {
                self.numericKeyboard.layer.position = p
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var t: AnyObject = touches.anyObject()!
        var p = t.locationInView(self.view)
        println(p)

        if (self.numericKeyboard.frame.origin.x < p.x && p.x < CGRectGetMaxX(self.numericKeyboard.frame) &&
            self.numericKeyboard.frame.origin.y < p.y && p.y < self.numericKeyboard.frame.origin.y + 40) {
                self.numericKeyboard.layer.position = p
        }
    }
    
    // MARK: -
    func textFieldDidBeginEditing(textField: UITextField) {
    
        textField.resignFirstResponder()
        self.numericKeyboard.hidden = false
        self.numericKeyboard.center = self.view.center
    }
    
    func enterButtonDidPushed(resultLabelString: String?) {
        myTextField.text = resultLabelString
        self.numericKeyboard.hidden = true
    }
    
}

