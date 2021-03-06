//
//  TermsAndConditionVC.swift
//  SwapMe
//
//  Created by Mahad on 12/17/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import WebKit

class TermsAndConditionVC: UIViewController,WKUIDelegate {

    @IBOutlet var WebView: WKWebView!
    @IBOutlet var btn_menu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = WKWebViewConfiguration()
        WebView = WKWebView()
         WebView.uiDelegate = self
        
        let myURL = URL(string:"https://docs.google.com/gview?embedded=true&url=app.pyprentals.com/terms-of-service.pdf")
        let myRequest = URLRequest(url: myURL!)
        WebView.load(myRequest)
        
                if self.revealViewController() != nil {
                    btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                }
        // Do any additional setup after loading the view.
    }
    
    var popoverController:UIPopoverPresentationController?
    @IBAction func notifyBtn_Click(_ sender: Any) {
         let sb = UIStoryboard(name: "Main", bundle: nil)
                    let notesVC = sb.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        //            notesVC.PickupSwapVC = self
            //        notesVC.isManualSegue = true
                    notesVC.preferredContentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
                    notesVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            
                            popoverController = notesVC.popoverPresentationController
            //                popoverController?.delegate = self
                    popoverController?.sourceView = self.view
                    popoverController?.sourceRect = self.view.bounds
                    popoverController?.permittedArrowDirections = .up
                            
                    self.present(notesVC, animated: true, completion: nil)
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
