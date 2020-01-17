//
//  PickSwapViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 17/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire
import RSSelectionMenu
import DatePickerDialog

class PickSwapViewController: UIViewController {
    
    var name:String! = ""
    var dateString:String! = ""
    @IBOutlet weak var box_img: UIImageView!
    
    
    var dataSource = DepartmentResponse()
    
    var simpleDataArray:[String?] = []
    @IBOutlet weak var lbl_days: UILabel!
    
    var department_array:NSMutableArray = []
    
    var selectedNames: [String] = []
    
    @IBOutlet weak var day_down: UIImageView!
    
    
    var week_array:[String?] = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var selectedWeeks: [String] = []
    @IBOutlet weak var btn_days: UIButton!
    
    @IBOutlet weak var txt_start1: UILabel!
    
    @IBOutlet weak var txt_end1: UILabel!
    
    @IBOutlet weak var txt_start2: UILabel!
    
    
    @IBOutlet weak var txt_end2: UILabel!
    
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var txt_end: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    
    @IBOutlet weak var start1_view: UIView!
    
    @IBOutlet weak var start2_view: UIView!
    
    @IBOutlet weak var End1_view: UIView!
    
    @IBOutlet weak var End2_view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if self.revealViewController() != nil {
        //            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //        }
        
        
        start1_view.layer.cornerRadius = 8.0
        start1_view.clipsToBounds = true
        
        start2_view.layer.cornerRadius = 8.0
        start2_view.clipsToBounds = true
        
        End1_view.layer.cornerRadius = 8.0
        End1_view.clipsToBounds = true
        
        End2_view.layer.cornerRadius = 8.0
        End2_view.clipsToBounds = true
        
        
        self.GetDepartmentApi()
    }
    
    
    
    
    
    
    @IBAction func selectDeparment(_ sender: Any) {
        
        StaticData.obj.deplistPick = []
        
        let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource:((self.dataSource.data?.mainlineDepartments?.map({$0.name}))!)) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        
        menu.setSelectedItems(items: selectedNames) { (name, index, selected, selectedItems) in
            
            self.selectedNames = selectedItems as! [String]
            
            StaticData.obj.deplistPick.add(name!)
            
            self.btn_select.setTitle(self.selectedNames.joined(separator:","), for: .normal)
            
            StaticData.obj.depValuePick = self.selectedNames.joined(separator:",")
            
            
        }
        // show - Present
        menu.show(from: self)
    }
    
    
   /* @IBAction func add(_ sender: Any) {
        
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
    }*/
    
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
                
                self.department_array = []
                self.simpleDataArray = []
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                
                do {
                                            
                                   let jsonDecoder = JSONDecoder()
                    self.dataSource = try jsonDecoder.decode(DepartmentResponse.self, from: respones.data!)
                                   print(self.dataSource)
                                            
                                   }
                               catch {
                                   print("Json Mapping Error")
                               }
                
                
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                    
                    if let myCountry = dic["data"] as? [[String:Any]]{
                        print(myCountry)
                        
                        for Dict in myCountry {
                            
                            
                            
                            let id = Dict["id"] as? Int
                            
                            let did:String! = "\(id ?? 0)"
                            
                            let name = Dict["name"] as? String
                            let department_type = Dict["department_type"] as? String
                            
                           
                            
                            self.simpleDataArray.append(name)
                            
                           
                        }
                        
                    }else{
                        
                        let message = dic["message"] as! String
                        self.alertModule(title:"Error", msg:message)
                    }
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
    
    
    @IBAction func SelectStart1(_ sender: Any) {
        
        DatePickerDialog().show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
               
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    self.txt_start1.text = formatter.string(from: dt)
                    StaticData.obj.startValuePick1 = formatter.string(from: dt)
            }
        }
        
    }
        
    @IBAction func selectEnd1(_ sender: Any) {
        
        DatePickerDialog().show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.txt_end1.text = formatter.string(from: dt)
                StaticData.obj.endValuePick1 = formatter.string(from: dt)
            }
        }
        
    }
    
    @IBAction func selectStart2(_ sender: Any) {
        
        DatePickerDialog().show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.txt_start2.text = formatter.string(from: dt)
                StaticData.obj.startValuePick2 = formatter.string(from: dt)
            }
        }
        
    }
    
    @IBAction func selectEnd2(_ sender: Any) {
        
        DatePickerDialog().show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.txt_end2.text = formatter.string(from: dt)
                StaticData.obj.endValuePick2 = formatter.string(from: dt)
            }
        }
        
    }
    
    
    
    
    
    
    @IBAction func makePermanant(_ sender: Any) {
        
        if(box_img.image == UIImage(named:"icons8-unchecked-checkbox-96")){
            
            self.box_img.image = UIImage(named: "icons8-tick-box-75")
            self.datepicker.alpha = 0
            self.lbl_days.text = "Select Days"
            self.btn_days.alpha = 1
            StaticData.obj.isPermanentPick = "YES"
            self.day_down.alpha = 1
            
            
        }else{
            self.box_img.image = UIImage(named: "icons8-unchecked-checkbox-96")
            self.datepicker.alpha = 1
            self.lbl_days.text = "Select Date"
            self.btn_days.alpha = 0
            StaticData.obj.isPermanentPick = "NO"
            self.day_down.alpha = 0
            
            
        }
        
    }
    
    
    @IBAction func dateselect(_ sender: Any) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateString = formatter.string(from: datepicker.date)
        StaticData.obj.datevaluePick = formatter.string(from: datepicker.date)
        
    }
    
  @IBAction func SelectDays(_ sender: Any) {
        
        
        let menu = RSSelectionMenu(selectionStyle: .multiple, dataSource:week_array) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        // provide selected items
        menu.setSelectedItems(items: selectedWeeks) { (name, index, selected, selectedItems) in
            self.selectedWeeks = selectedItems as! [String]
            
            
            self.btn_days.setTitle(self.selectedWeeks.joined(separator:","), for: .normal)
            StaticData.obj.daysvaluesPick = self.selectedWeeks.joined(separator:",")
            
            
        }
        // show - Present
        menu.show(from: self)
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
       // self.dismiss(animated:true, completion: nil)
    }
    
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        if(StaticData.obj.isPermanentPick == "NO"){
            
            if(StaticData.obj.datevaluePick == ""){
                
              self.alertModule(title:"Error", msg: "Please select swap date.")
            }else if(StaticData.obj.depValuePick == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap department.")
            }else if(StaticData.obj.startValuePick1 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap start time.")
            }else if(StaticData.obj.startValuePick2 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap start time.")
            }
            else if(StaticData.obj.endValuePick1 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap end time.")
            }
            else if(StaticData.obj.endValuePick2 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap end time.")
            }else{
                
                
                
                if(StaticData.obj.isSawp == "no"){
                    self.performSegue(withIdentifier:"gotopickk", sender: self)
                }else{
                    self.performSegue(withIdentifier:"gotoswapPPshift", sender: self)
                }
            }
            
        }else{
            
            if(StaticData.obj.daysvaluesPick == "Yes"){
                
                self.alertModule(title:"Error", msg: "Please select swap days.")
    }
      else if(StaticData.obj.depValuePick == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap department.")
            }else if(StaticData.obj.startValuePick1 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap start time.")
            }else if(StaticData.obj.startValuePick2 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap start time.")
            }
            else if(StaticData.obj.endValuePick1 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap end time.")
            }
            else if(StaticData.obj.endValuePick2 == ""){
                
                self.alertModule(title:"Error", msg: "Please select swap end time.")
            }else{
                
                if(StaticData.obj.isSawp == "no"){
                    self.performSegue(withIdentifier:"gotopickk", sender: self)
                }else{
                    self.performSegue(withIdentifier:"gotoswapPPshift", sender: self)
                }
                
            }
        }
    }
    
    
    
    
    
    

}
