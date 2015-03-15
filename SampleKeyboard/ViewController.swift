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
    var initPosition :CGPoint!

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

//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        var t: AnyObject = touches.anyObject()!
//        var p = t.locationInView(self.view)
//        println("\(p), \(self.numericKeyboard.frame)")
//
//        if (self.numericKeyboard.frame.origin.x < p.x && p.x < CGRectGetMaxX(self.numericKeyboard.frame) &&
//            self.numericKeyboard.frame.origin.y < p.y && p.y < self.numericKeyboard.frame.origin.y + 40) {
//            self.numericKeyboard.layer.position = p
//        }
//    }
//    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        var t: AnyObject = touches.anyObject()!
//        var p = t.locationInView(self.view)
//        if (self.numericKeyboard.frame.origin.x < p.x && p.x < CGRectGetMaxX(self.numericKeyboard.frame) &&
//            self.numericKeyboard.frame.origin.y < p.y && p.y < self.numericKeyboard.frame.origin.y + 40) {
//                self.numericKeyboard.layer.position = p
//        }
//    }
//    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        var t: AnyObject = touches.anyObject()!
//        var p = t.locationInView(self.view)
//        println(p)
//
//        if (self.numericKeyboard.frame.origin.x < p.x && p.x < CGRectGetMaxX(self.numericKeyboard.frame) &&
//            self.numericKeyboard.frame.origin.y < p.y && p.y < self.numericKeyboard.frame.origin.y + 40) {
//                self.numericKeyboard.layer.position = p
//        }
//    }
    
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
    
    @IBAction func dragGesture(sender: UIPanGestureRecognizer) {
        
        if (sender.view?.bounds.origin.y < 20) {
        println("y=\(sender.view?.bounds.origin.y)")
        
        
        if(sender.state == UIGestureRecognizerState.Began) {
            // ドラッグオブジェクトの初期値を覚えておく
            self.initPosition = sender.view?.center;
            
            // 事前にUse Auto Layoutは外しておくこと
            self.view.bringSubviewToFront(sender.view!)
            sender.view?.alpha = 0.8

        }

        
        // 移動量を取得
        let point = sender.translationInView(self.view)
        let view = self.view!
        
        // 移動量をドラッグしたViewの中心値に加える
        let movedPoint = CGPointMake(view.center.x + point.x, view.center.y + point.y)
        
        // ドラッグで移動した距離を初期化する
        sender.setTranslation(CGPointZero, inView: self.view)
        
        if(sender.state == UIGestureRecognizerState.Ended
            || sender.state == UIGestureRecognizerState.Failed
            || sender.state == UIGestureRecognizerState.Cancelled) {
                // ドラッグするためにタップしている座標を取得
                let dropPoint = sender.locationInView(self.view)
                
                sender.view?.center = dropPoint
                sender.view?.alpha = 1.0
        }
        }
    }
}

