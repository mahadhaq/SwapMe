//
//  SwapViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 13/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire
import RSSelectionMenu
import DatePickerDialog

class SwapViewControroller: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var startView: UIView!
    
    @IBOutlet weak var days_view: UIView!
    @IBOutlet weak var end_view: UIView!
    
    var dataSource = DepartmentResponse()
    
    var name:String! = ""
    var dateString:String! = ""
    @IBOutlet weak var box_img: UIImageView!
    
    var simpleDataArray:[String?] = []
    @IBOutlet weak var lbl_days: UILabel!
    
    var department_array:NSMutableArray = []
    
    var selectedNames: [String] = []
    
    @IBOutlet weak var day_down: UIImageView!
    
    
    var week_array:[String?] = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var selectedWeeks: [String] = []
    @IBOutlet weak var btn_days: UIButton!
    
    @IBOutlet weak var txt_start: UILabel!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var txt_end: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    
    @IBOutlet weak var shiftRemovel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   /*     if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        */
        startView.layer.cornerRadius = 8.0
        startView.clipsToBounds = true
        
        days_view.layer.cornerRadius = 8.0
        days_view.clipsToBounds = true
        
        end_view.layer.cornerRadius = 8.0
        end_view.clipsToBounds = true
        
        
        self.GetDepartmentApi()
    }
    
    
    
    
    
    
    @IBAction func selectDeparment(_ sender: Any) {
        
        
        
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource:(self.dataSource.data?.mainlineDepartments?.map({$0.name}))!) { (cell, name, indexPath) in
                   cell.textLabel?.text = name
               }
               // provide selected items
               menu.setSelectedItems(items: selectedNames) { (name, index, selected, selectedItems) in
                   self.selectedNames = selectedItems as! [String]
                  
                   //StaticData.obj.deplist = selectedItems as! [String]
                   
                   self.btn_select.setTitle(name!, for: .normal)
                   
                   StaticData.obj.depValue = name!
                   
                   
               }
               // show - Present
               menu.show(from: self)
    }
    
   /*
    @IBAction func add(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add Department", message: "Enter deparment name", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = ""
            textField.text = ""
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            if(firstTextField.text != ""){
                self.name = firstTextField.text!
                self.CreateDepartmentApi()
            }else{
                
                self.alertModule(title:"Error", msg: "Please enter department name.")
            }
          
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
      
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    */
    
    
   
    
    func CreateDepartmentApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/departments"
       
        let parameter:[String:Any]?  = ["name":name!]
        
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
    
    func GetDepartmentApi(){
       
        let  sv = LoginViewController.displaySpinner(onView: self.view)
       
        let url : String = "http://app.pyprentals.com/api/departments"
       
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
       
        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
          
            switch respones.result {
            case .success( let value):
              
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
              
                do {
                             
                    let jsonDecoder = JSONDecoder()
                    self.dataSource = try jsonDecoder.decode(DepartmentResponse.self, from: respones.data!)
                    print(self.dataSource)
                             
                    }
                catch {
                    print("Json Mapping Error")
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
    
    
    @IBAction func selectStart(_ sender: Any) {
        
        DatePickerDialog().show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
               
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.txt_start.text = formatter.string(from: dt)
                StaticData.obj.startValue = formatter.string(from: dt)
                
            }
        }
        
    }
    
    @IBAction func selectEnd(_ sender: Any) {
        
        DatePickerDialog().show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
              
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.txt_end.text = formatter.string(from: dt)
                
                 StaticData.obj.endValue = formatter.string(from: dt)
                
        }
        }
    }
    
    
    @IBAction func makePermanant(_ sender: Any) {
        
        if(box_img.image == UIImage(named:"icons8-unchecked-checkbox-96")){
            
            self.box_img.image = UIImage(named: "icons8-tick-box-75")
            self.datepicker.alpha = 0
            self.lbl_days.text = "Select Days"
            self.btn_days.alpha = 1
            StaticData.obj.isPermanent = "YES"
            self.day_down.alpha = 1
           
            
        }else{
            self.box_img.image = UIImage(named: "icons8-unchecked-checkbox-96")
            self.datepicker.alpha = 1
            self.lbl_days.text = "Select Date"
            self.btn_days.alpha = 0
            StaticData.obj.isPermanent = "NO"
            self.day_down.alpha = 0
           
            
        }
        
    }
    
    
    @IBAction func dateselect(_ sender: Any) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateString = formatter.string(from: datepicker.date)
        StaticData.obj.datevalue = formatter.string(from: datepicker.date)
        StaticData.obj.isPermanent = "NO"
        
    }
    
    @IBAction func SelectDays(_ sender: Any) {
        
        
        let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource:week_array) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        // provide selected items
        menu.setSelectedItems(items: selectedWeeks) { (name, index, selected, selectedItems) in
            self.selectedWeeks = selectedItems as! [String]
            
            
            self.btn_days.setTitle(self.selectedWeeks.joined(separator:","), for: .normal)
            StaticData.obj.daysvalues = self.selectedWeeks.joined(separator:",")
            
            
        }
        // show - Present
        menu.show(from: self)
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        // self.dismiss(animated:true, completion: nil)
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
        if(StaticData.obj.isPermanent == "NO"){
            
            if(StaticData.obj.datevalue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap date.")
            }else if(StaticData.obj.depValue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap department.")
            }else if(StaticData.obj.endValue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap end time.")
            }else if(StaticData.obj.startValue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap start time.")
            }else{
                if(StaticData.obj.isSawp == "no"){
                self.performSegue(withIdentifier:"gotodetail", sender: self)
                }else{
                   self.performSegue(withIdentifier:"swapPick", sender: self)
                }
            }
        }else{
            
            if(StaticData.obj.daysvalues == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap days.")
            }else if(StaticData.obj.depValue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap department.")
            }else if(StaticData.obj.endValue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap end time.")
            }else if(StaticData.obj.startValue == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap start time.")
            }else{
                
                if(StaticData.obj.isSawp == "no"){
                    self.performSegue(withIdentifier:"gotodetail", sender: self)
                }else{
                    self.performSegue(withIdentifier:"swapPick", sender: self)
                }
               
            }
        }
    }
    
    
    
    
    
    
}
