//
//  CreateNoteViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 05/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class CreateNoteViewController: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var txt_title: UITextField!
    
    @IBOutlet weak var txt_notes: UITextView!
    
    @IBOutlet weak var btn_save: UIButton!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
       txt_notes.delegate = self
         
        txt_notes.layer.borderColor = UIColor.darkGray.cgColor
        txt_notes.layer.borderWidth = 1.0
        txt_notes.layer.cornerRadius = 5.0
        
        txt_notes.text = "Type description here..."
        
        if(StaticData.obj.isNew == "no"){
            
            txt_title.text = StaticData.obj.title
            txt_notes.text = StaticData.obj.desc
            btn_save.setTitle("Update", for: .normal)
     
        }else{
            
            txt_notes.textColor = UIColor.lightGray
            btn_save.setTitle("Save", for: .normal)
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type description here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil)
    }
    

    @IBAction func save(_ sender: Any) {
        
        if(txt_title.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your notes title.")
        }
        else if(txt_notes.text?.isEmpty)!{
            
            self.alertModule(title:"Error", msg:"Please enter your notes description.")
        } else if(txt_notes.text == "Type description here..."){
            
            self.alertModule(title:"Error", msg:"Please enter your notes description.")
        }
        else{
            if(StaticData.obj.isNew == "no"){
                self.UpdateNotesApi()
            }else{
               self.CreateNotesApi()
            }
            
        }
        
        
    }
    
    @IBAction func BackBtn_Click(_ sender: Any) {
//        self.dismiss(animated:true, completion: nil)
        revealViewController()?.setFront(delegate.LastViewController, animated: true)
    }
    
    
    func UpdateNotesApi(){
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        let url : String = "http://app.pyprentals.com/api/notes/"+StaticData.obj.nnid!
        
        let parameter:[String:Any]?  = ["title":self.txt_title.text!,"description":self.txt_notes.text!]
        
        
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
                    
                    let message = dic["message"] as! String
                    
                    
                    let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                        
//                        self.dismiss(animated:true, completion: nil)
                        self.revealViewController()?.setFront(self.delegate.LastViewController, animated: true)
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
    
    
    
    func CreateNotesApi(){
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        let url : String = "http://app.pyprentals.com/api/notes"
        
        let parameter:[String:Any]?  = ["user_id":UserDefaults.standard.string(forKey: "uid")!,"title":self.txt_title.text!,"description":self.txt_notes.text!]
        
        
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
                        
//                        self.dismiss(animated:true, completion: nil)
                        self.revealViewController()?.setFront(self.delegate.LastViewController, animated: true)
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
