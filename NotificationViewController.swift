//
//  NotificationViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 05/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class NotificationViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var search: UISearchBar!
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var filtered:NSMutableArray = []
    var isManualSegue:Bool?
    var searchActive : Bool = false
    var PickupSwapVC:PickupSwapViewController?
    
    var notesArray:NSMutableArray = []
    
    var NotificationArray:[Datum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.search.delegate = self
        
         self.GetNotitificationApi()
   
        
       tableview.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back_btn(_ sender: UIButton) {
        
        if(isManualSegue == true)
        {
            if(PickupSwapVC != nil)
            {
                PickupSwapVC?.dismisspopover()
                return
            }
        }
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        self.SeenNotiApi()
        
   
        
        
    }
    
    func GetNotitificationApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/users/"+UserDefaults.standard.string(forKey: "uid")!+"/notifications"
        
        let parameter:[String:Any]?  = ["user_id":UserDefaults.standard.string(forKey: "uid")!]
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
       // print(parameter!)
        
        Alamofire.request(url, method: .get, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                self.notesArray = []
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                    
                    do{
                        let decoder = JSONDecoder()
                        let str = String(decoding: respones.data as! Data, as: UTF8.self)
                        let array = try decoder.decode(NotificationModel.self, from: respones.data!)
                                
                        print(array)
                        self.NotificationArray = array.data ?? []
                        print(self.NotificationArray.count)
                        
                        self.tableview.delegate = self
                        self.tableview.dataSource = self
                        self.tableview.reloadData()
                        
                            }
                                catch
                                {
                                    
                                }
                    
                   
//                 if let myCountry = dic["data"] as? [[String:Any]]{
//                    print(myCountry)
//
//                    //
//                    for dic in myCountry {
//
//                     if let Dict = dic["data"] as? NSDictionary{
//
//                        let timestamp = dic["created_at"] as? String
//
//                        let msg = Dict["message"] as? String
//
//                        if let dic2 = Dict["otherUserShift"] as? NSDictionary{
//
//                        if let dic1 = dic2["user"] as? NSDictionary{
//
//                            let username = dic1["username"] as? String
//
//                             let profile_pic = dic1["profile_pic"] as? String
//
////                            let obj = Notification(timestamp: timestamp, msg: msg, profile_pic: profile_pic,username:username)
////
////                                                    self.notesArray.add(obj)
//                            }
//                        }
//
//                    }
//                }
//                    self.tableview.delegate = self
//                    self.tableview.dataSource = self
//                    self.tableview.reloadData()
//                }else{
                    
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
                    
                    //let message = dic["message"] as! String
                    //self.alertModule(title:"Error", msg:message)
            
//                }
            }
                
                
            case .failure(let error):
                
                print(error)
                
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                self.alertModule(title:"Error",msg:error.localizedDescription)
                
                
            }
        })
        
        
    }
    
    
    func SeenNotiApi(){
        
           let url : String = "http://app.pyprentals.com/api/users/"+UserDefaults.standard.string(forKey: "uid")!+"/notifications_seen"
        

           
           let header: HTTPHeaders = [
               
               "Accept": "application/json"
           ]
           
           print(url)
          // print(parameter!)
           
           Alamofire.request(url, method: .patch, parameters: nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
               
               respones in
               
               switch respones.result {
               case .success( let value):
            
                   let json  = value
          
                    print(json)
                               let dic = json as! NSDictionary
                               let code = dic["status"] as! NSNumber
                               print(code)
                 
                   
                   
               case .failure(let error):
                   
                   print(error)
             
                   
                   
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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive == true){
            return self.filtered.count
        }else{
//           return self.notesArray.count
            print(self.NotificationArray.count)
            return self.NotificationArray.count
        }
        

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(searchActive == true){
         let cell:NotesTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! NotesTableViewCell
        
        
        
        let obj = self.filtered[indexPath.row] as! Notification
    
            
        cell.notes_title.text = obj.msg
        cell.notes_des.text = "Last Updated:"+obj.timestamp
        
        return cell
        }
        else{
            let cell:NotesTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! NotesTableViewCell
            
            let obj1 = self.NotificationArray[indexPath.row]
            
            let dat = obj1.data!
            
            if(obj1.eventName == EVENT_NAME_SHIFT_REQUEST_STATUS_NOTIFICATION)
            {
                cell.notes_title.text = "Swap request \(dat.status ?? "")"
                cell.notes_des.text = "Your request has been \(dat.status ?? "") by \(dat.request!.user?.username ?? "")\nShift:\(dat.getTitle())"
            }
                
            else if (obj1.eventName == EVENT_NAME_SHIFT_REQUEST_NOTIFICATION)
            {
                cell.notes_title.text = "New swap request"
                cell.notes_des.text = "New swap request from \(dat.request!.shift?.user?.username ?? "")\nSHIFT: \(dat.getTitle())"
            }
            else if(obj1.eventName == EVENT_NAME_SHIFT_REQUEST_NO_MORE_NOTIFICATION)
            {
                cell.notes_title.text = "Swap is no more"
                cell.notes_des.text = "This swap is no more\nShift:\(dat.getTitle())"
            }
            
            else {
                cell.notes_title.text = obj1.data?.message
                cell.notes_des.text = obj1.data?.getTitle()
            }
            
//            if(obj1.data?.request == nil)
//            {
//
//            }
//            else
//            {
//                cell.notes_title.text = "New swap request"
//                cell.notes_des.text = "New swap request from \(dat.request!.shift?.user?.username ?? "")\nSHIFT: \(dat.getTitle())"
//            }
            cell.notes_title.backgroundColor = postShiftColor
            cell.notes_des.backgroundColor = postShiftColor
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let obj1 = self.NotificationArray[indexPath.row] as! Datum
//
//        if(obj1.data?.request != nil)
//        {
//            return 90
//        }
//        else if (obj1.data?.shift?.shiftType == SHIFT_TYPE_POST || obj1.data?.shift?.shiftType == SHIFT_TYPE_PICKUP)
//        {
//
//            return 90
//        }
//        else
//        {
//            return 120
//        }
        
        
        return 120
    }
  
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
//
//            var uuid:String! = "0"
//
//            if(self.searchActive == true){
//                let obj = self.filtered[indexPath.row] as! Note
//                uuid = obj.nid
//            }else{
//
//                let obj = self.notesArray[indexPath.row] as! Note
//                uuid = obj.nid
//            }
//
//            let  sv = LoginViewController.displaySpinner(onView: self.view)
//
//
//
//            let url : String = "http://172.104.217.178/swapme/public/api/notes/"+uuid
//
//
//
//
//            let header: HTTPHeaders = [
//
//                "Accept": "application/json"
//            ]
//
//            print(url)
//
//
//            Alamofire.request(url, method: .delete, parameters: nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
//
//                respones in
//
//                switch respones.result {
//                case .success( let value):
//
//                    self.notesArray = []
//                    let json  = value
//                    LoginViewController.removeSpinner(spinner: sv)
//                    self.view.isUserInteractionEnabled = true
//                    print(json)
//                    let dic = json as! NSDictionary
//                    let code = dic["status"] as! NSNumber
//                    print(code)
//                    if(code == 200){
//
//                        self.GetNotesApi()
//
//                    }else{
//
//                        let message = dic["message"] as! String
//                        self.alertModule(title:"Error", msg:message)
//                    }
//
//
//
//                case .failure(let error):
//
//                    print(error)
//
//                    LoginViewController.removeSpinner(spinner: sv)
//                    self.view.isUserInteractionEnabled = true
//                    self.alertModule(title:"Error",msg:error.localizedDescription)
//
//
//                }
//            })
//
//        }
//
//        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
//
//            if(self.searchActive == true){
//                let obj = self.filtered[indexPath.row] as! Note
//                StaticData.obj.isNew = "no"
//                StaticData.obj.title = obj.title
//                StaticData.obj.desc = obj.descri
//                StaticData.obj.nnid = obj.nid
//            }else{
//
//                let obj = self.notesArray[indexPath.row] as! Note
//                StaticData.obj.isNew = "no"
//                StaticData.obj.title = obj.title
//                StaticData.obj.desc = obj.descri
//                StaticData.obj.nnid = obj.nid
//            }
//
//
//
//            self.performSegue(withIdentifier:"gotocreate", sender: self)
//
//
//
//        }
//        edit.backgroundColor = UIColor.init(red:243/255, green: 111/255, blue: 54/255, alpha: 1.0)
//
//        let config = UISwipeActionsConfiguration(actions: [delete,edit])
//        config.performsFirstActionWithFullSwipe = false
//        return config
//    }
    
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated:true, completion: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        searchActive = false;
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
        searchBar.showsCancelButton = true
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = []
        searchActive = true;
        
        if((self.notesArray.count) > 0){
            for i in 0...(notesArray.count)-1{
                let obj = notesArray[i] as! Notification
                if obj.msg!.lowercased().range(of:searchText.lowercased()) != nil {
                    
                    self.filtered.add(obj)
                    
                }
            }
        }
        
        
        print(filtered)
        
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableview.reloadData()
        
    }
    
    


}
