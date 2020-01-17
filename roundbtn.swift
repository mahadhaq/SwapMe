//
//  roundbtn.swift
//  SwapMe
//
//  Created by Shawal's Mac on 18/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import Foundation
@IBDesignable

class CircleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius: CGFloat = 30.0{
        
        didSet{
        setUpView()
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    
    func setUpView()
    {
        layer.cornerRadius = cornerRadius
    }

}
