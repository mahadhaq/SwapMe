//
//  DetailPickViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 17/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

class DetailPickViewController:UIViewController {
    
    @IBOutlet weak var permanent: UILabel!
    
     var userNotificationCenter = UNUserNotificationCenter.current()
    @IBOutlet weak var days: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var depatments: UILabel!
    
    @IBOutlet weak var time_start: UILabel!
    
    @IBOutlet weak var time_end: UILabel!
    
    @IBOutlet weak var txt_name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.permanent.text = StaticData.obj.isPermanentPick
        if(StaticData.obj.isPermanentPick == "NO"){
            
            self.date.text = StaticData.obj.datevaluePick
            self.days.text = ""
        }else{
            self.date.text = ""
            self.days.text = StaticData.obj.daysvaluesPick
        
        }
        
        self.depatments.text = StaticData.obj.depValuePick
        
        self.time_start.text = StaticData.obj.startValuePick1!+" - "+StaticData.obj.startValuePick2!
        
        self.time_end.text = StaticData.obj.endValuePick1!+" - "+StaticData.obj.endValuePick2!
        
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated:true, completion: nil)
    }
    
    
    @IBAction func match(_ sender: Any) {
        
        if(txt_name.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Swap Name.")
        }else{
            
            
            self.CreatePickShiftApi()
            
        }
    }
    
   
    
    func CreatePickShiftApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        var perama:String! = "0"
        
        if(StaticData.obj.isPermanentPick == ""){
            
            perama = "1"
        }else{
            
            perama = "0"
        }
        
        
        
        let url : String = "http://app.pyprentals.com/api/shifts/pick"
        
        let parameter:[String:Any]?  = ["trade_name":txt_name.text!,"user_id":UserDefaults.standard.string(forKey: "uid")!,"is_permanent":perama!,"days":StaticData.obj.daysvaluesPick!,"date":StaticData.obj.datevaluePick!,"departments":StaticData.obj.deplistPick,"start_time":StaticData.obj
            .startValuePick1!+"-"+StaticData.obj
                .startValuePick2!,"end_time":StaticData.obj
                    .endValuePick1!+"-"+StaticData.obj
                        .endValuePick2!]
        
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
                if(code == 200){
                    
                    let message = dic["message"] as! String
                    
                    let notificationContent = UNMutableNotificationContent()
                    notificationContent.title = "SwapMe"
                    notificationContent.body = message
                    notificationContent.badge = NSNumber(value: 1)
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                                    repeats: false)
                    let request = UNNotificationRequest(identifier: "testNotification",
                                                        content:notificationContent,
                                                        trigger: trigger)
                    
                    self.userNotificationCenter.add(request) { (error) in
                        if let error = error {
                            print("Notification Error: ", error)
                        }
                    }
                    
                    let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                        
                        self.dismiss(animated:true, completion: nil)
                        alertController.dismiss(animated: true, completion: nil)
                    })
                    
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    
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
    
    
    
    
}
