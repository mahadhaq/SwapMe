//
//  LoginViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 02/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btn_login: UIButton!
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btn_login.layer.cornerRadius = 5
        
       
    }
    
    
    @IBAction func Lofin(_ sender: Any) {
        
        let isValid:Bool = self.isValidEmail(testStr:txt_email.text!)
        
        if(txt_email.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Email.")
        }else if(!isValid){
            
            self.alertModule(title:"Error", msg:"Please enter valid Email.")
        }
        else if(txt_password.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Password.")
        }else if(txt_password.text!.count < 8){
            
            self.alertModule(title:"Error", msg:"Password should be greater than or equal to 8 charaters.")
        }
        else{
            
            self.SignInApi()
            
        }
        
    }
    
    func SignInApi(){
        
     
        let sv = LoginViewController.displaySpinner(onView: self.view)
        self.view.isUserInteractionEnabled = false
        
        
        let url : String = "http://app.pyprentals.com/api/login"
        
        let parameter:[String:Any]?  = ["email":txt_email.text!,"password":txt_password.text!]
        
        print(url)
        print(parameter!)
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
                    if let dic1 = dic["data"] as? NSDictionary{
                        
                        let token = dic1["token"] as! String
                        if let dic2 = dic1["user"] as? NSDictionary{
                            let first = dic2["first_name"] as! String
                            let last = dic2["last_name"] as! String
                            let uid = dic2["id"] as! NSNumber
                            let uemail = dic2["email"] as! String
                            let phone = dic2["phone"] as! String
                          
                            let address = dic2["username"] as! String
                            
                            if (dic2["profile_pic"] as? String) != nil{
                                
                                UserDefaults.standard.set(dic2["profile_pic"] as! String, forKey: "profile_pic")
                            }else{
                                UserDefaults.standard.set("", forKey: "profile_pic")
                            }
                            
                            UserDefaults.standard.set(first, forKey: "fname")
                            UserDefaults.standard.set(last, forKey: "lname")
                            UserDefaults.standard.set(uemail, forKey: "uemail")
                            UserDefaults.standard.set(phone, forKey: "phone")
                        
                            UserDefaults.standard.set(address, forKey: "username")
                            UserDefaults.standard.set(self.txt_password.text!, forKey: "password")
                            UserDefaults.standard.set(token, forKey: "token")
                            
                            UserDefaults.standard.set(uid, forKey: "uid")
                            
                            //let str = self.toString(uid as? NSNumber);
                            //print(str)
                            
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                            self.present(vc, animated: true, completion: nil)
                            
                            
                            
                        }
                        
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
    
    func toString(_ anything: Any?) -> String {
        if let any = anything {
            if let num = any as? NSNumber {
                return num.stringValue
            } else if let str = any as? String {
                return str
            }
        }
        return ""

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
extension LoginViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
