//
//  ContactUsViewController.swift
//  SwapMe
//
//  Created by Shawal's Mac on 06/12/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ContactUsViewController: UIViewController {
    
    // @IBAction func btn_menu(_ sender: Any) {
    // }
    
    @IBOutlet weak var btn_menu: UIButton!
    
    
    @IBAction func Submit(_ sender: CircleButton) {
        
        let isValid:Bool = self.isValidEmail(testStr:emailTxt.text!)
        
        /*  if(txt_first.text?.isEmpty)!{
         
         self.alertModule(title:"Error", msg:"Please enter your First name.")
         }else*/ if(usernameTxt.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your UserName.")
         }else if(emailTxt.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Email.")
         }
         else if(!isValid){
            
            self.alertModule(title:"Error", msg:"Please enter valid Email.")
         }
            
         else if(phoneTxt.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Phone number.")
         }
         else{
            
            self.ContactUsApi()
            
        }
        
        
        
    }
    
    @IBAction func notify_btn(_ sender: UIButton) {
    }
    
    
    @IBOutlet var usernameTxt: roundtextfield!
    
    @IBOutlet var emailTxt: UITextField!
    
    @IBOutlet var phoneTxt: UITextField!
    
    
    @IBOutlet weak var DescTextView: UITextView!
    let textFieldCornerRadius:CGFloat = 5.0
    let textFieldBorderWidth:CGFloat = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        DescTextView.layer.borderColor = self.getUIColorFromHexString(hex: "E3E3E3").cgColor
        DescTextView.layer.borderWidth = self.textFieldBorderWidth
        DescTextView.layer.cornerRadius = self.textFieldCornerRadius
        
        
        self.usernameTxt.text = UserDefaults.standard.string(forKey: "username")
        
        self.emailTxt.text = UserDefaults.standard.string(forKey:"uemail")
        
        self.phoneTxt.text = UserDefaults.standard.string(forKey:"phone")
    }
    
    
    func getUIColorFromHexString(hex:String!) -> UIColor
    {
        
        var cString:NSString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
        
        if (cString.length < 6)
        {
            return UIColor.gray
        }
        
        if (cString.hasPrefix("0X"))
        {
            cString = cString.substring(from: 2) as NSString
        }
        else if(cString.hasPrefix("#"))
        {
            cString = cString.substring(from: 1) as NSString
        }
        
        if (cString.length != 6)
        {
            return UIColor.gray
        }
        
        var range:NSRange = NSRange(location: 0, length: 2)
        let rString:NSString = cString.substring(with: range) as NSString
        
        range.location = 2
        let gString:NSString = cString.substring(with: range) as NSString
        
        range.location = 4
        let bString:NSString = cString.substring(with: range) as NSString
        
        
        var r:uint = 0
        var g:uint = 0
        var b:uint = 0
        
        var scanner:Scanner = Scanner(string: rString as String)
        scanner.scanHexInt32(&r)
        scanner = Scanner(string: gString as String)
        scanner.scanHexInt32(&g)
        scanner = Scanner(string: bString as String)
        scanner.scanHexInt32(&b)
        
        return UIColor(red: (CGFloat(r))/255.0, green: (CGFloat(g))/255.0, blue: (CGFloat(b))/255.0, alpha: 1.0)
        
    }
    
    
    // MARK: - API
    func ContactUsApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/contact/send"
        
        let parameter:[String:Any]?  = ["description":DescTextView.text!,"email":emailTxt.text!,"phone":self.phoneTxt.text!,"username":self.usernameTxt.text!]
        
        
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
                    if let dic1 = dic["data"] as? NSDictionary{
                        
//                        let message = dic["message"] as! String
//                        self.alertModule(title:"Success", msg:message)
//
//                        if let dic2 = dic1["user"] as? NSDictionary{
//
//                            let first = dic2["first_name"] as! String
//                            let last = dic2["last_name"] as! String
//                            let uid = dic2["id"] as! NSNumber
//                            let uemail = dic2["email"] as! String
//                            let phone = dic2["phone"] as! String
//
//                            let address = dic2["username"] as! String
//
//                            UserDefaults.standard.set(first, forKey: "fname")
//                            UserDefaults.standard.set(last, forKey: "lname")
//                            UserDefaults.standard.set(uemail, forKey: "uemail")
//                            UserDefaults.standard.set(phone, forKey: "phone")
//
//                            UserDefaults.standard.set(address, forKey: "username")
//
//                            UserDefaults.standard.set(uid, forKey: "uid")
//
//
//                        }
                        
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
    
    
    // MARK: - Helpers
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
    /*
     // MARK: - Navigation
     
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
