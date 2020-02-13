//
//  SettinghelpVC.swift
//  SwapMe
//
//  Created by Mahad on 2/7/20.
//  Copyright © 2020 Rao Mudassar. All rights reserved.
//

import UIKit

class SettinghelpVC: UIViewController {

    
    @IBOutlet weak var btn_menu: UIButton!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    private var CREATE_SWAP = "f7Qz-DELI70"
    private var CREATE_PARTIAL_SWAP = "j7eL61ml0NU"
    private var AFTER_MATCH = "oUcK16FQafI"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    var popoverController:UIPopoverPresentationController?
    @IBAction func notify_btn(_ sender: UIButton) {
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
    
        @IBAction func back(_ sender: Any) {
            revealViewController()?.setFront(delegate.LastViewController, animated: true)
        }
    
    
    @IBAction func postpickswapBtn_Click(_ sender: Any) {
        let youtubeId = "f7Qz-DELI70"
        var youtubeUrl = URL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
//            UIApplication.shared.openURL(youtubeUrl)
        } else{
                youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func partialshiftBtn_Click(_ sender: Any) {
        let youtubeId = "j7eL61ml0NU"
        var youtubeUrl = URL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
//            UIApplication.shared.openURL(youtubeUrl)
        } else{
                youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func afterMatchBtn_Click(_ sender: Any) {
        let youtubeId = "oUcK16FQafI"
        var youtubeUrl = URL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl){
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
//            UIApplication.shared.openURL(youtubeUrl)
        } else{
                youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
//            UIApplication.shared.openURL(youtubeUrl)
        }
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
