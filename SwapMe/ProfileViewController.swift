//
//  ProfileViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 03/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var user_img: UIImageView!
    
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var txt_first: UITextField!
    
    @IBOutlet weak var txt_last: UITextField!
    
    @IBOutlet weak var txt_username: UITextField!
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
       // self.txt_first.text = UserDefaults.standard.string(forKey:"fname")
        
        
        self.txt_username.text = UserDefaults.standard.string(forKey: "username")
        
        self.txt_email.text = UserDefaults.standard.string(forKey:"uemail")
        
        self.txt_phone.text = UserDefaults.standard.string(forKey:"phone")
        
        user_img.layer.masksToBounds = false
        user_img.layer.cornerRadius = user_img.frame.height/2
        user_img.clipsToBounds = true
        
        self.user_img.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey:"profile_pic")!), placeholderImage: UIImage(named: "ic_profile_default"))
    }
    override func viewWillAppear(_ animated: Bool) {
        delegate.LastViewController = delegate.homeViewController
    }
    
    @IBAction func update(_ sender: Any) {
        
        
        let isValid:Bool = self.isValidEmail(testStr:txt_email.text!)
        
      /*  if(txt_first.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your First name.")
        }else*/ if(txt_username.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Last name.")
        }else if(txt_email.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Email.")
        }
        else if(!isValid){
            
            self.alertModule(title:"Error", msg:"Please enter valid Email.")
        }
    
        else if(txt_phone.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your Phone number.")
        }
        else{
            
            self.UpdateProfileApi()
            
        }
        
        
    }
    
    
    
    
    func UpdateProfileApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/users/"+UserDefaults.standard.string(forKey: "uid")!
        
        let parameter:[String:Any]?  = ["first_name":UserDefaults.standard.string(forKey: "fname")!,"last_name":UserDefaults.standard.string(forKey: "lname")!,"phone":self.txt_phone.text!+self.txt_phone.text!,"email":self.txt_email.text!,"username":self.txt_username.text!]
        
        
    let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        print(parameter!)
        
        Alamofire.request(url, method: .put, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
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
                        
                        let message = dic["message"] as! String
                        self.alertModule(title:"Success", msg:message)
                     
                         if let dic2 = dic1["user"] as? NSDictionary{
                        
                        let first = dic2["first_name"] as! String
                        let last = dic2["last_name"] as! String
                        let uid = dic2["id"] as! NSNumber
                        let uemail = dic2["email"] as! String
                        let phone = dic2["phone"] as! String
                        
                        let address = dic2["username"] as! String
                        
                        UserDefaults.standard.set(first, forKey: "fname")
                        UserDefaults.standard.set(last, forKey: "lname")
                        UserDefaults.standard.set(uemail, forKey: "uemail")
                        UserDefaults.standard.set(phone, forKey: "phone")
                        
                        UserDefaults.standard.set(address, forKey: "username")
                     
                        UserDefaults.standard.set(uid, forKey: "uid")
                        
                        
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
    
    
    @IBAction func takephoto(_ sender: Any) {
        
        let actionSheet =  UIAlertController(title:nil, message:nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            (_:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker,animated: true,completion: nil)
            } else {
                let alertVC = UIAlertController(
                    title: "No Camera",
                    message: "Sorry, this device has no camera",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: nil)
                alertVC.addAction(okAction)
                self.present(
                    alertVC,
                    animated: true,
                    completion: nil)
            }
        })
        
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: {
            (_:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary;
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(camera)
        
        actionSheet.addAction(gallery)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        //        let number = Int.random(in: 1000 ... 10000)
        
        self.dismiss(animated:true, completion:nil)
        
        let pickedImage = info[.originalImage] as? UIImage
        
         let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        self.user_img.image = pickedImage
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
     
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(pickedImage!.jpeg(.lowest)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
               
        }, to:"http://app.pyprentals.com/api/users/"+UserDefaults.standard.string(forKey: "uid")!+"/update_profile_picture",headers:header)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                upload.responseJSON
                    { response in
                        LoginViewController.removeSpinner(spinner: sv)
                        self.view.isUserInteractionEnabled = true
                        //print response.result
                        if response.result.value != nil
                        {
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                           print(dict)
                            
                            if let dic2 = dict["data"] as? NSDictionary{
                                
                                if let dic3 = dic2["user"] as? NSDictionary{
                           
                                    let first = dic3["first_name"] as! String
                                    let last = dic3["last_name"] as! String
                                    let uid = dic3["id"] as! NSNumber
                                    let uemail = dic3["email"] as! String
                                    let phone = dic3["phone"] as! String
                                    
                                    let address = dic3["username"] as! String
                                    
                                    if (dic3["profile_pic"] as? String) != nil{
                                        
                                        UserDefaults.standard.set(dic3["profile_pic"] as! String, forKey: "profile_pic")
                                    }else{
                                        UserDefaults.standard.set("", forKey: "profile_pic")
                                    }
                                    
                                    UserDefaults.standard.set(first, forKey: "fname")
                                    UserDefaults.standard.set(last, forKey: "lname")
                                    UserDefaults.standard.set(uemail, forKey: "uemail")
                                    UserDefaults.standard.set(phone, forKey: "phone")
                                    
                                    UserDefaults.standard.set(address, forKey: "username")
                                   
                                    UserDefaults.standard.set(uid, forKey: "uid")
                                
                                }
                            }
                        }
                }
            case .failure( _):
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                break
            }
        }
       
        
        
    }
    


}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
