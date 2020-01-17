//
//  SwapHistoryViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 18/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class SwapHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var seg_value: UISegmentedControl!
    
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var tablrview: UITableView!
    
    var history_Array:NSMutableArray = []
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tablrview.tableFooterView = UIView()
        
        self.GetSwapHistoryApi()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        delegate.LastViewController = delegate.homeViewController
    }
    
    func GetSwapHistoryApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/history/"+UserDefaults.standard.string(forKey: "uid")!
        
    
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
   
        
        Alamofire.request(url, method: .get, parameters:nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                self.history_Array = []
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                    
                    if let myCountry = dic["data"] as? [[String:Any]]{
                        print(myCountry)
                        
                        //
                        for Dict in myCountry {
                            
                            var swapDate:String! = ""
                            var swapDeps:String! = ""
                            var swapStart:String! = ""
                            var swapEnd:String! = ""
                            var swapID:String! = ""
                            var swapType:String! = ""
                            
                       
                            if let date1 = Dict["date"] as? String{
                                
                                swapDate = date1
                            }else{
                                if let dateArray = Dict["days"] as? NSArray{
                                    print(dateArray.count)
                                    for index in 0..<dateArray.count{
                                        
                                        if let date2 = dateArray[index] as? String{
                                            
                                            var stringArry:[String] = []
                                            stringArry.append(date2)
                                            
                                            swapDate = stringArry.joined(separator: ", ")
                                        
                                        }
                                        
                                        
                                    }
                                }
                            }
                            
                            if let departments = Dict["departments"] as? NSArray{
                                
                                swapDeps = (departments[0] as! String)
                            }
                            
                            if let start_time = Dict["start_time"] as? String{
                                
                                swapStart = start_time
                            }
                            
                            if let end_time = Dict["end_time"] as? String{
                                
                                swapEnd = end_time
                            }
                            if let Did = Dict["id"] as? Int{
                                
                                let nid:String! = "\(Did)"
                                swapID = nid
                            }
                            
                            if let type = Dict["shift_type"] as? String{
                                
                                swapType = type
                            }
                           
                           let obj = History(swapDate: swapDate, swapDeps: swapDeps, swapStart: swapStart, swapEnd: swapEnd, swapID: swapID, swapType: swapType)

                            self.history_Array.add(obj)
                       }
                        
                        self.tablrview.delegate = self
                        self.tablrview.dataSource = self
                        self.tablrview.reloadData()
                    }else{
                        
                        self.tablrview.delegate = self
                        self.tablrview.dataSource = self
                        self.tablrview.reloadData()
                        
                       
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
    
    func GetSwapMatchedHistoryApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/shifts/get_history/user/"+UserDefaults.standard.string(forKey: "uid")!
        
        
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        
        
        Alamofire.request(url, method: .get, parameters:nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                self.history_Array = []
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                    
                    if let dic1 = dic["data"] as? NSDictionary{
                        
                        if let dic2 = dic1["post"] as? NSDictionary{
                       
                        if let myCountry = dic2["match"] as? [[String:Any]]{
                            print(myCountry)
                       
                        for Dict in myCountry {
                            
                            var swapDate:String! = ""
                            var swapDeps:String! = ""
                            var swapStart:String! = ""
                            var swapEnd:String! = ""
                            var swapID:String! = ""
                            var swapType:String! = ""
                            
                            
                            if let date1 = Dict["date"] as? String{
                                
                                swapDate = date1
                            }else{
                                if let dateArray = Dict["days"] as? NSArray{
                                    print(dateArray.count)
                                    for index in 0..<dateArray.count{
                                        
                                        if let date2 = dateArray[index] as? String{
                                            
                                            var stringArry:[String] = []
                                            stringArry.append(date2)
                                            
                                            swapDate = stringArry.joined(separator: ", ")
                                            
                                        }
                                        
                                        
                                    }
                                }
                            }
                            
                            if let departments = Dict["departments"] as? String{
                                
                                swapDeps = departments
                            }
                            
                            if let start_time = Dict["start_time"] as? String{
                                
                                swapStart = start_time
                            }
                            
                            if let end_time = Dict["end_time"] as? String{
                                
                                swapEnd = end_time
                            }
                            if let Did = Dict["id"] as? Int{
                                
                                let nid:String! = "\(Did)"
                                swapID = nid
                            }
                            
                            if let type = Dict["shift_type"] as? String{
                                
                                swapType = type
                            }
                            
                            let obj = History(swapDate: swapDate, swapDeps: swapDeps, swapStart: swapStart, swapEnd: swapEnd, swapID: swapID, swapType: swapType)
                            
                            self.history_Array.add(obj)
                        }
                        
                        self.tablrview.delegate = self
                        self.tablrview.dataSource = self
                        self.tablrview.reloadData()
                    }else{
                        
                        self.tablrview.delegate = self
                        self.tablrview.dataSource = self
                        self.tablrview.reloadData()
                        
                        
                    }
                }
            
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.history_Array.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell:HistoryTableViewCell = self.tablrview.dequeueReusableCell(withIdentifier: "cell03") as! HistoryTableViewCell
            
            
            
            let obj = self.history_Array[indexPath.row] as! History
        
        let time:String! = obj.swapStart+"-"+obj.swapEnd
   
        cell.lbl_history.text = obj.swapDate+","+obj.swapDeps+","+time
            
            return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 68
    }
    
    
    @IBAction func SelectSegment(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            self.GetSwapHistoryApi()
        }else
        if (sender as AnyObject).selectedSegmentIndex == 1 {
            self.GetSwapMatchedHistoryApi()
        }
       
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
         let obj = self.history_Array[indexPath.row] as! History
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
        
            let  sv = LoginViewController.displaySpinner(onView: self.view)
          
            
            let url : String = "http://app.pyprentals.com/api/shifts"
            
            
            let parameter:[String:Any]?  = ["shift_type":obj.swapType!,"shift_id":obj.swapID!]
            
            print(parameter!)
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
            
            
            Alamofire.request(url, method: .delete, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
                respones in
                
                switch respones.result {
                case .success( let value):
                    
                    self.history_Array = []
                    let json  = value
                    LoginViewController.removeSpinner(spinner: sv)
                    self.view.isUserInteractionEnabled = true
                    print(json)
                    let dic = json as! NSDictionary
                    let code = dic["status"] as! NSNumber
                    print(code)
                    if(code == 200){
                        
                        self.GetSwapHistoryApi()
                        
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
        
       
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
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
