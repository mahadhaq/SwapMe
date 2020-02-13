//
//  MessageViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class MessageViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var search: UISearchBar!
    
    
    @IBOutlet weak var segBtn: UISegmentedControl!
    
    @IBOutlet weak var IncomingReqContainerView: UIView!
    
    @IBOutlet weak var MessagesView: UIView!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func segBtnRes(_ sender: Any) {
        
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            MessagesView.isHidden = false
            IncomingReqContainerView.isHidden = true
            self.GetNotesApi()
        }else
        if (sender as AnyObject).selectedSegmentIndex == 1 {
            
            //GettAllRequesViewController
            for subview in IncomingReqContainerView.subviews
            {
                subview.removeFromSuperview()
            }
            if(MsgReqVC != nil)
            {
                MsgReqVC = nil
            }
            MsgReqVC = self.storyboard?.instantiateViewController(withIdentifier: "GettAllRequesViewController") as? GettAllRequesViewController
            
            IncomingReqContainerView.addSubview(MsgReqVC!.view)
            MessagesView.isHidden = true
//            MsgReqVC?.ViewAppearing()
            IncomingReqContainerView.isHidden = false
            print("Second")
        }
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var filtered:NSMutableArray = []
    var searchActive : Bool = false
    
    var MsgReqVC:GettAllRequesViewController?
    
    var notesArray:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.search.delegate = self
        
        
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        tableview.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.GetNotesApi()
        delegate.LastViewController = delegate.homeViewController
    }
    
    func GetNotesApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/messages/inbox"
        
        let parameter:[String:Any]?  = ["user_id":UserDefaults.standard.string(forKey: "uid")!]
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        print(parameter!)
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
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
                    
                    if let myCountry = dic["data"] as? [[String:Any]]{
                        print(myCountry)
                        
                        for Dict in myCountry {
                            
                            var timestamp:String! = ""
                            var msg:String! = ""
                            var sid:String! = ""
                            var rid:String! = ""
                            var rName:String! = ""
                            var shiftId = ""
                            var totalUnread = ""
                            var msg_id = ""
                            var shiftdetail = ""
                            
                            if let dic1 = Dict["message"] as? NSDictionary{
                                
                                if let dic2 = dic1["message"] as? String{
                                    
                                    msg = dic2
                                }
                                
                                if let dic12 = dic1["id"] as? Int{
                                    let nid:String! = "\(dic12)"
                                    msg_id = nid
                                  
                                                               }
                                
                                if let dic6 = dic1["sender"] as? [String:Any]
                                {
                                    if let dic4 = dic6["id"] as? Int{
                                        let nid:String! = "\(dic4)"
                                        sid = nid
                                       
                                    }
//                                    if let dic5 = dic6["username"] as? String{
//                                       rName = dic5
//
//                                    }
                                    
                                }
                                
                                if let dic6 = dic1["sender_id"] as? String{
                                    sid = dic6
                                }
                                
                                if let dic11 = Dict["totalUnReadMessage"] as? Int{
                                 let nid:String! = "\(dic11)"
                                     totalUnread = nid
                                                               
                                }
                                if let dic7 = dic1["shift_id"] as? Int{
                                    let nid:String! = "\(dic7)"
                                    shiftId = nid
                                }
                                
                                if let dic3 = dic1["receiver"] as? NSDictionary{
                                    
                                    if let dic4 = dic3["id"] as? Int{
                                        let nid:String! = "\(dic4)"
                                        rid = nid
                                       
                                    }
                                    
                                    if let dic5 = dic3["username"] as? String{
                                       rName = dic5

                                    }
                                }
                                if let shiftdic = dic1["shift"] as? [String:Any]
                                {
                                    let date:String? = shiftdic["date"] as? String
                                    let departments:String = shiftdic["departments"] as! String
                                    let formatter = DateFormatter()
                                    formatter.dateStyle = DateFormatter.Style.none
                                    formatter.dateFormat = "HH:mm:ss"
                                    var starttime:Date = Date()
                                    var endtime:Date = Date()
                                    if let stime = shiftdic["start_time"] as? String
                                        {
                                            starttime = formatter.date(from: stime)!
                                    }
                                    if let etime = shiftdic["end_time"] as? String
                                        {
                                            endtime = formatter.date(from: etime)!
                                    }
                                    formatter.dateFormat = "hh:mm a"
                                    
                                    shiftdetail = "\(date ?? ""),\(departments), \(formatter.string(from: starttime)) - \(formatter.string(from: endtime))"
                                    print(shiftdetail)
                                    
                                }
                                
                            }
                            
                            
                            
                            let obj = Inbox(timestamp: timestamp, msg: msg,sid:sid,rid:rid,rName:rName,shiftId:shiftId,totalUnread:totalUnread,msg_id:msg_id,shift_detail: shiftdetail)
                            
                            self.notesArray.add(obj)
                        }
                        
                        self.tableview.delegate = self
                        self.tableview.dataSource = self
                        self.tableview.reloadData()
                    }else{
                        
                        self.tableview.delegate = self
                        self.tableview.dataSource = self
                        self.tableview.reloadData()
                        
                        //let message = dic["message"] as! String
                        //self.alertModule(title:"Error", msg:message)
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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive == true){
            return self.filtered.count
        }else{
            return self.notesArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(searchActive == true){
            let cell:MessageCellTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! MessageCellTableViewCell
            
            
            
            let obj = self.filtered[indexPath.row] as! Inbox
            
            cell.notes_title.text = obj.rName
            cell.notes_des.text = obj.msg
            cell.message_count.text = obj.totalUnread
            cell.messagedetailLbl.text = obj.Shiftdetail
            
            if(obj.totalUnread == "0"){
                cell.message_count.alpha = 0
                
            }
            
            return cell
        }else{
            let cell:MessageCellTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! MessageCellTableViewCell
            
            
            
            let obj = self.notesArray[indexPath.row] as! Inbox
            
            cell.notes_title.text = obj.rName
            cell.notes_des.text = obj.msg
            cell.message_count.text = obj.totalUnread
            cell.messagedetailLbl.text = obj.Shiftdetail
            
            if(obj.totalUnread == "0"){
                cell.message_count.alpha = 0
                
            }
            
            return cell
        }
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 130
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searchActive == true){
            let obj = self.filtered[indexPath.row] as! Inbox
            StaticData.obj.receiver_id = obj.rid
            StaticData.obj.receiver_name = obj.rName
            StaticData.obj.shift_id = obj.shiftId
            StaticData.obj.msg_id = obj.msg_id
           
           
            
        }else{
            
            let obj = self.notesArray[indexPath.row] as! Inbox
            StaticData.obj.receiver_id = obj.rid
            StaticData.obj.receiver_name = obj.rName
            StaticData.obj.shift_id = obj.shiftId
            StaticData.obj.msg_id = obj.msg_id
        }
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Chat1ViewController") as! Chat1ViewController
        
//        revealViewController()?.pushFrontViewController(vc, animated: true)
        delegate.LastViewController = self
        revealViewController()?.setFront(vc, animated: true)
//        self.performSegue(withIdentifier:"intochat", sender: self)
        
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
                let obj = notesArray[i] as! Inbox
                if obj.rName!.lowercased().range(of:searchText.lowercased()) != nil {
                    
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
    
    @IBAction func back(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        revealViewController()?.setFront(delegate.LastViewController, animated: true)
        //self.dismiss(animated:true, completion: nil)
    }
    
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "IncomingRequestSegue"
//            {
//                let msgReqVC:GettAllRequesViewController=segue.destination as! GettAllRequesViewController
//                //jobDetailVC.jobSelected=self.jobSelected
//                self.MsgReqVC = msgReqVC
//            }
//    }
    
    
    
}
