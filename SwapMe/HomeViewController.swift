//
//  HomeViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 02/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import PusherSwift
import Alamofire
import MIBadgeButton_Swift

class HomeViewController: UIViewController,PusherDelegate {
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var create_view: UIView!
    
    @IBOutlet weak var message_view: UIView!
    
    @IBOutlet weak var pending_view: UIView!
    
    @IBOutlet weak var notes_view: UIView!
    
    var pusher : Pusher!
    

    @IBOutlet weak var btn_badge: MIBadgeButton!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.navigationBar.isHidden = true
        create_view.layer.cornerRadius = 8.0
        create_view.clipsToBounds = true
        
        message_view.layer.cornerRadius = 8.0
        message_view.clipsToBounds = true
        
        pending_view.layer.cornerRadius = 8.0
        pending_view.clipsToBounds = true
        
        notes_view.layer.cornerRadius = 8.0
        notes_view.clipsToBounds = true

        if self.revealViewController() != nil {
           btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        delegate.LastViewController = self
        delegate.SubscribetoPusher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.btn_badge.badgeString = ""
        delegate.homeViewController = self
        delegate.LastViewController = self
        self.RecoverPWDApi()
    }
    

    
    
    func RecoverPWDApi(){
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/users/"+UserDefaults.standard.string(forKey: "uid")!+"/notifications/unseen"
        
      
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
   
        
        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                let dic1 = dic["data"] as! NSDictionary
                let count = dic1["totalUnseen"] as! Int
                    print(count)
                    if(count > 0){
                    
                    self.btn_badge.badgeString = String(count)
                    
                    self.btn_badge.badgeEdgeInsets = UIEdgeInsets(top:3, left: 0, bottom: 0, right: 3)
                    
                    self.btn_badge.badgeTextColor = UIColor.white
                    self.btn_badge.badgeBackgroundColor = UIColor.red
                    }
                    
                }else{
                    
                    let message = dic["message"] as! String
                    self.alertModule(title:"Error", msg:message)
                }
                
                
                
            case .failure(let error):
                
                print(error)
                
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                self.alertModule(title:"Error",msg:error.localizedDescription)
                
                
            }
        })
        
    }
    
    func alertModule(title:String,msg:String){
           
           let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
           
           let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
               alertController.dismiss(animated: true, completion: nil)
           })
           
           alertController.addAction(alertAction)
           
           present(alertController, animated: true, completion: nil)
           
       }
    
    @IBAction func CreateSwap_Click(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CreateSwapViewController") as! CreateSwapViewController
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.LastViewController = self
//        revealViewController()?.pushFrontViewController(vc, animated: true)
        
        revealViewController()?.setFront(vc, animated: true)
    }
    
    
    @IBAction func Messagebtn_Click(_ sender: Any) {
              let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.LastViewController = self
        //        revealViewController()?.pushFrontViewController(vc, animated: true)
                
                revealViewController()?.setFront(vc, animated: true)
    }
    
    
    @IBAction func PendingSwapBtn_Click(_ sender: Any) {
//        PendingSwapViewController
        let sb = UIStoryboard(name: "Main", bundle: nil)
                       let vc = sb.instantiateViewController(withIdentifier: "PendingSwapViewController") as! PendingSwapViewController
                       
                       let delegate = UIApplication.shared.delegate as! AppDelegate
                       delegate.LastViewController = self
               //        revealViewController()?.pushFrontViewController(vc, animated: true)
                       
                       revealViewController()?.setFront(vc, animated: true)
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
    
}
