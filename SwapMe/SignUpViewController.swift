//
//  SignUpViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 02/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire
import CountryList

class SignUpViewController: UIViewController,CountryListDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var btn_signUp: UIButton!
    @IBOutlet weak var txt_first: UITextField!
    
    @IBOutlet weak var txt_last: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_pwd: UITextField!
    
    @IBOutlet weak var txt_retype: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_code: UITextField!
    
    var coudeCountry:String! = ""
    
    var countryList = CountryList()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_signUp.layer.cornerRadius = 5
        countryList.delegate = self
        
        txt_phone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        txt_phone.text = self.formattedNumber(number:textField.text!)
        
    }
    
    private func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "XXXXXXXXXX"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        let isValid:Bool = self.isValidEmail(testStr:txt_email.text!)
        
        if(txt_first.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your First name.")
        }else if(txt_last.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Last name.")
        }else if(txt_email.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Email.")
        }
        else if(!isValid){
            
            self.alertModule(title:"Error", msg:"Please enter valid Email.")
        }
        else if(txt_pwd.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Password.")
        }else if(txt_pwd.text! != txt_retype.text!){
            
            self.alertModule(title:"Error", msg:"Your Password doesn't match with Re-Type Password.")
        }else if(txt_pwd.text!.count < 8){
            
            self.alertModule(title:"Error", msg:"Password should be greater than or equal to 8 charaters.")
        }  else if(txt_code.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your code.")
        }
        else if(txt_phone.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Phone number.")
        }
        else{
            
            self.SignUpApi()
            
        }
    }
    
    func SignUpApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/register"
        
        let parameter:[String:Any]?  = ["first_name":self.txt_first.text!,"last_name":self.txt_last.text!,"phone":self.coudeCountry!+self.txt_phone.text!,"password":self.txt_pwd.text!,"email":self.txt_email.text!,"username":self.txt_first.text!+" "+self.txt_last.text!]
  
        
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
                       
                            UserDefaults.standard.set(token, forKey: "token")
                        
                        let message = dic["message"] as! String
                        
                         let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                            self.navigationController?.popViewController(animated: true)
                            alertController.dismiss(animated: true, completion: nil)
                        })
                        
                        alertController.addAction(alertAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                            
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
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[ A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    @IBAction func CountrySelect(_ sender: Any) {
        
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    func selectedCountry(country: Country) {
        txt_code.text =  country.flag!+" +"+country.phoneExtension
        self.coudeCountry = "+"+country.phoneExtension
    
    }
    


}
