//
//  Chat1ViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class Chat1ViewController: UIViewController {
    
    @IBOutlet weak var user_title: UILabel!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.user_title.text = StaticData.obj.receiver_name
    }
    
    @IBAction func back(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        revealViewController()?.setFront(delegate.LastViewController, animated: true)
        //self.dismiss(animated:true, completion: nil)
    }
    

    @IBAction func sendRequest(_ sender: Any) {
        
        print("Hello send request")
    }
    
}
