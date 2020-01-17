//
//  ViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 20/08/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var btn_login: UIButton!
    
    @IBOutlet weak var btn_signUP: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btn_login.layer.cornerRadius = 5
        btn_signUP.layer.cornerRadius = 5
    }
    
    


}

