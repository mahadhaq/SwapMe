//
//  ForgetPasswordViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 02/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var btn_recover: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_recover.layer.cornerRadius = 5

    }
    
    @IBAction func RecoverPwd(_ sender: Any) {
        
        let isValid:Bool = self.isValidEmail(testStr:txt_email.text!)
        
        if(txt_email.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Email.")
        }
        else if(!isValid){
            
            self.alertModule(title:"Error", msg:"Please enter valid Email.")
        }else{
    
    self.RecoverPWDApi()
    }
    
}

func RecoverPWDApi(){
    
    
    let  sv = LoginViewController.displaySpinner(onView: self.view)
    
    
    
    let url : String = "http://app.pyprentals.com/api/password/email"
    
    
    let parameter:[String:Any]?  = ["email":txt_email.text!]
    
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
                let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
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
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

}
