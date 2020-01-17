//
//  roundtextfield.swift
//  SwapMe
//
//  Created by Shawal's Mac on 06/12/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import Foundation
@IBDesignable

class roundtextfield: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    @IBInspectable var cornerRadius: CGFloat = 30.0{
//
//        didSet{
//        setUpView()
//        }
//
//    }
    
    @IBInspectable var cornerRadius: CGFloat {
           set {
            layer.cornerRadius = 10
               clipsToBounds = newValue > 0
           }
           get {
               return layer.cornerRadius
           }
       }
    
//    override func prepareForInterfaceBuilder() {
//        setUpView()
//    }
//
//
//    func setUpView()
//    {
//        layer.cornerRadius = cornerRadius
//    }

}
