//
//  GetallRequestTableViewCell.swift
//  SwapMe
//
//  Created by Shawal's Mac on 28/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class GetallRequestTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var RequestLabel: UILabel!
    var shift_id:String?
    var reqID:Int?
    var getallreq:GettAllRequesViewController?
    
    @IBAction func Acceptbtn(_ sender: UIButton) {
        
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
            print(sender.tag)
            
            let status = "ACCEPTED"
            //   let url = "http://app.pyprentals.com/api/shift_requests/148"
            let  sv = LoginViewController.displaySpinner(onView: getallreq!.view)
            
            
            
            let url : String = "http://app.pyprentals.com/api/shift_requests/\(reqID!)"
            
            let parameter:[String:Any]?  = ["status":"ACCEPTED","shift_id":shift_id!]
            
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
            print(parameter!)
            
            Alamofire.request(url, method: .patch, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
                respones in
                
                
                switch respones.result {
                case .success( let value):
                    
                    let json  = value
                    LoginViewController.removeSpinner(spinner: sv)
                    self.getallreq!.view.isUserInteractionEnabled = true
                    print(json)
                    let dic = json as! NSDictionary
                    let code = dic["status"] as! NSNumber
                    print(code)
                    if(code == 200){
                        
                        let message = dic["message"] as! String
                        
                        
                        
                        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                            
                            alertController.dismiss(animated: true, completion: nil)
                            self.getallreq!.GetSwapHistoryApi()
                        })
                        
                        alertController.addAction(alertAction)
                        
                        self.getallreq!.present(alertController, animated: true, completion: nil)
                        
                        
                    }else{
                        
                        let message = dic["message"] as! String
                        self.getallreq!.alertModule(title:"Error", msg:message)
                    }
                    
                    
                    
                case .failure(let error):
                    
                    print(error)
                    
                    LoginViewController.removeSpinner(spinner: sv)
                    self.getallreq!.view.isUserInteractionEnabled = true
                    self.getallreq!.alertModule(title:"Error",msg:error.localizedDescription)
                    
                    
                }
            })
            
            
            
        }
        
          
          
        
        
    }
    
    
    @IBAction func Declinebtn(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
            let status = "REJECTED"
            let  sv = LoginViewController.displaySpinner(onView: self.getallreq!.view)
            
            
            let url : String = "http://app.pyprentals.com/api/shift_requests/\(reqID!)"
            
            let parameter:[String:Any]?  = ["status":"REJECTED","shift_id":shift_id!]
            
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
            print(parameter!)
            
            Alamofire.request(url, method: .patch, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
                respones in
                
                switch respones.result {
                case .success( let value):
                    
                    let json  = value
                    LoginViewController.removeSpinner(spinner: sv)
                    self.getallreq!.view.isUserInteractionEnabled = true
                    print(json)
                    let dic = json as! NSDictionary
                    let code = dic["status"] as! NSNumber
                    print(code)
                    if(code == 200){
                        
                        let message = dic["message"] as! String
                        
                        
                        
                        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                            
                            alertController.dismiss(animated: true, completion: nil)
                            self.getallreq!.GetSwapHistoryApi()
                        })
                        
                        alertController.addAction(alertAction)
                        
                        self.getallreq!.present(alertController, animated: true, completion: nil)
                        
                        
                    }else{
                        
                        let message = dic["message"] as! String
                        self.getallreq!.alertModule(title:"Error", msg:message)
                    }
                    
                    
                    
                case .failure(let error):
                    
                    print(error)
                    
                    LoginViewController.removeSpinner(spinner: sv)
                    self.getallreq!.view.isUserInteractionEnabled = true
                    self.getallreq!.alertModule(title:"Error",msg:error.localizedDescription)
                    
                    
                }
            })
            
            
            
        }
        
        
        
    }
    
    
}
