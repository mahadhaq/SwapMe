//
//  CreateSwapViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 13/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class CreateSwapViewController: UIViewController {
    
    @IBOutlet weak var btn_menu: UIButton! 

    @IBOutlet weak var swap: UIView!
    
    
    @IBOutlet weak var post: UIView!
    
    @IBOutlet weak var pick: UIView!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        swap.layer.cornerRadius = 8.0
        swap.clipsToBounds = true
        
        post.layer.cornerRadius = 8.0
        post.clipsToBounds = true
        
        pick.layer.cornerRadius = 8.0
        pick.clipsToBounds = true
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        StaticData.obj.isSawp = "no"
            delegate.LastViewController = delegate.homeViewController
    }
    
    
   
    @IBAction func swapashift(_ sender: Any) {
//        self.present(SwapShiftViewController1(),animated: true, completion: nil)
        delegate.LastViewController = self
        revealViewController()?.pushFrontViewController(SwapShiftViewController1(), animated: true)
        
        
    }
    
    
    @IBAction func Back(_ sender: Any) {

        revealViewController()?.setFront(delegate.LastViewController, animated: true)

    }
    
    @IBAction func postswap(_ sender: UIButton) {
//         self.present(PostShiftViewController(),animated: true, completion: nil)
//        revealViewController()?.pushFrontViewController(PostShiftViewController(), animated: false)
        delegate.LastViewController = self
        revealViewController()?.setFront(PostShiftViewController(), animated: true)
    }
    
    @IBAction func pickswap(_ sender: UIButton) {
//         self.present(PickupSwapViewController(),animated: true, completion: nil)
        
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "PickSwapViewController") as! PickupSwapViewController
        
        let vc = PickupSwapViewController()
        delegate.LastViewController = self
        revealViewController()?.setFront(vc, animated: true)
//        revealViewController()?.pushFrontViewController(vc, animated: true)
        
    }
    
    
    
}
