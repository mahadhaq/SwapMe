//
//  SettingViewController.swift
//  SwapMe
//
//  Created by Shawal's Mac on 05/12/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var contactus: UILabel!
    
    @IBOutlet var TermsLbl: UILabel!
    
    @IBOutlet weak var btn_menu: UIButton!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.tapFunction))
             contactus.isUserInteractionEnabled = true
             contactus.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.TermstapFunction))
            TermsLbl.isUserInteractionEnabled = true
            TermsLbl.addGestureRecognizer(tap1)
        
        if self.revealViewController() != nil {
                   btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
               }
               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegate.LastViewController = delegate.homeViewController
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        
        revealViewController()?.pushFrontViewController(vc, animated: true)
    }

    @IBAction func updatePasswordBtn_Click(_ sender: Any) {
        //UpdatePasswordVC
        let sb = UIStoryboard(name: "Main", bundle: nil)
               let vc = sb.instantiateViewController(withIdentifier: "UpdatePasswordVC") as! UpdatePasswordVC
               revealViewController()?.pushFrontViewController(vc, animated: true)
    }
    
    
    @objc func TermstapFunction(sender:UITapGestureRecognizer) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TermsAndConditionVC") as! TermsAndConditionVC
        
        revealViewController()?.pushFrontViewController(vc, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
