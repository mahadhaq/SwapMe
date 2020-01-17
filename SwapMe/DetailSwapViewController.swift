//
//  DetailSwapViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 17/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class DetailSwapViewController: UIViewController {
    
    @IBOutlet weak var post_permanent: UILabel!
    
    @IBOutlet weak var post_days: UILabel!
    
    @IBOutlet weak var post_date: UILabel!
    
    @IBOutlet weak var post_departments: UILabel!
    @IBOutlet weak var post_start: UILabel!
    
    @IBOutlet weak var post_end: UILabel!
    
    @IBOutlet weak var pick_permanent: UILabel!
    @IBOutlet weak var pick_date: UILabel!
    
    @IBOutlet weak var pick: UILabel!
    
    @IBOutlet weak var pick_deparments: UILabel!
    
    @IBOutlet weak var pick_start: UILabel!
    
    @IBOutlet weak var pick_end: UILabel!
    
    @IBOutlet weak var btn_swap: UIButton!
    
    @IBOutlet weak var txt_name: UITextField!
    
    var tradeOption:String! = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.post_permanent.text = StaticData.obj.isPermanent
        self.post_days.text = StaticData.obj.daysvalues
        self.post_date.text = StaticData.obj.datevalue
        self.post_departments.text = StaticData.obj.depValue
        self.post_start.text = StaticData.obj.startValue
        self.post_end.text = StaticData.obj.endValue
        
        self.pick_permanent.text = StaticData.obj.isPermanentPick
        self.pick_date.text = StaticData.obj.daysvaluesPick
        self.pick_date.text = StaticData.obj.datevaluePick
        self.pick_deparments.text = StaticData.obj.depValuePick
        self.pick_start.text = StaticData.obj.startValuePick1!+" - "+StaticData.obj.startValuePick2!
        self.pick_end.text = StaticData.obj.endValuePick1!+" - "+StaticData.obj.endValuePick2!
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil)
    }
    
   
    
    
    @IBAction func match(_ sender: Any) {
        
        if(txt_name.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Swap Name.")
        }else{
            
            
            //self.CreatePickShiftApi()
            
            self.CreatePostShiftApi()
        }
        
    }
    
    
    
    func CreatePostShiftApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        var perama:String! = "0"
        var peramaPick:String! = "0"
        
        if(StaticData.obj.isPermanent == "NO"){
            
            perama = "0"
        }else{
            
            perama = "1"
        }
        
        if(StaticData.obj.isPermanentPick == "NO"){
            
            peramaPick = "0"
        }else{
            
            peramaPick = "1"
        }
        
        
        
        let parameter1:[String:Any]?  = ["days":StaticData.obj.daysvalues!,"date":StaticData.obj.datevalue!,"departments":StaticData.obj.depValue!,"start_time":StaticData.obj
            .startValue!,"end_time":StaticData.obj.endValue!]
        
        
        
        
        let parameter2:[String:Any]?  = ["days":StaticData.obj.daysvaluesPick!,"date":StaticData.obj.datevaluePick!,"departments":StaticData.obj.deplistPick,"start_time":StaticData.obj
            .startValuePick1!+"-"+StaticData.obj
            .startValuePick2!,"end_time":StaticData.obj
            .endValuePick1!+"-"+StaticData.obj
                        .endValuePick2!]
        
       
        
        
        
        let url : String = "http://app.pyprentals.com/api/shifts/post/pickup"
        
        
        
        let parameter:[String:Any]?  = ["is_permanent":perama!,"trade_type":self.tradeOption!,"trade_name":txt_name.text!,"user_id":UserDefaults.standard.string(forKey: "uid")!,"post":parameter1!,"pickup":parameter2!]
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        
        
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
    
    
    
    
    @IBAction func selectTrade(_ sender: Any) {
        
        let alert = UIAlertController(title: "Select Trade", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Direct Trade", style: .default , handler:{ (UIAlertAction)in
            self.tradeOption = "0"
            self.btn_swap.setTitle("Direct Trade", for: .normal)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Show Up To 2 Trades", style: .default , handler:{ (UIAlertAction)in
            self.tradeOption = "1"
            self.btn_swap.setTitle("Show Up To 2 Trades", for: .normal)
        }))
        
        alert.addAction(UIAlertAction(title: "Show Up To 3 Trades", style: .destructive , handler:{ (UIAlertAction)in
            self.tradeOption = "2"
            self.btn_swap.setTitle("Show Up To 3 Trades", for: .normal)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
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
