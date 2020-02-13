//
//  UpdatePasswordVC.swift
//  SwapMe
//
//  Created by Mahad on 12/17/19.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class UpdatePasswordVC: UIViewController {

    @IBOutlet var btn_menu: UIButton!
    
    @IBOutlet var oldPassTxt: roundtextfield!
    @IBOutlet var newPassTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
                   btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
               }
        // Do any additional setup after loading the view.
    }
    @IBOutlet var confirmPassTxt: UITextField!
    
    @IBAction func updateBtn_Click(_ sender: Any) {
        
        let oldPassword = UserDefaults.standard.string(forKey:"password")
        
        if(oldPassword != oldPassTxt.text)
        {
            self.alertModule(title:"Error", msg:"Old password is incorrect.")
        }
        else if(newPassTxt.text != confirmPassTxt.text)
        {
            self.alertModule(title:"Error", msg:"New Password doesn't match with Confirm Password.")
        }
            else if(newPassTxt.text!.count < 8){
                
                self.alertModule(title:"Error", msg:"Password should be greater than or equal to 8 charaters.")
            }
        else
        {
            PasswordUpdateApi()
        }
        
    }
    
       // MARK: - API
        func PasswordUpdateApi(){
            
            
            
            let  sv = LoginViewController.displaySpinner(onView: self.view)
            
            
            
            let url : String = "http://app.pyprentals.com/api/users/"+UserDefaults.standard.string(forKey: "uid")!+"/update_password"
            
            let parameter:[String:Any]?  = ["password":newPassTxt.text!,"old_password":oldPassTxt.text!]
            
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
            print(parameter!)
            
            Alamofire.request(url, method: .post, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
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
                    if(code == 200)
                    {
                        let message = dic["message"] as! String
                        self.alertModule(title:"Success", msg:message)
                       
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
