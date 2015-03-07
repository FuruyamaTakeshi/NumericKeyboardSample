//
//  RoundButton.swift
//  SampleKeyboard
//
//  Created by Furuyama Takeshi on 2015/02/28.
//  Copyright (c) 2015年 Furuyama Takeshi. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
