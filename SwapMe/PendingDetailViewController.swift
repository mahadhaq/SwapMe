//
//  PendingDetailViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class PendingDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var title_lbl: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    var pendingswapVC:PendingSwapViewController?
    var users_Array:NSMutableArray = []
    var pendingSwapData:PendingSwapShift?
    var postPickSwapData:PostPickupShift?
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.title_lbl.text = StaticData.obj.detailmatch
//        
//         self.tableview.tableFooterView = UIView()
//        
//        self.GetPendingSwapApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title_lbl.text = StaticData.obj.detailmatch
        self.tableview.tableFooterView = UIView()
        delegate.LastViewController = pendingswapVC!
//        self.GetPendingSwapApi()
        self.ShowDirectSwaps()
        
    }
    
    func ShowDirectSwaps()  {
        if(pendingSwapData != nil)
        {
            for trade in pendingSwapData?.trades ?? []
            {
                users_Array.add(trade)// trade.user
            }
        }
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
    
    
    @IBAction func Alert(_ sender: Any) {
        
        
        let alertController = UIAlertController(title: "Shift Detail", message: StaticData.obj.detailmatch, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
            
//            self.dismiss(animated:true, completion: nil)
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
//        let alertController = UIAlertController(title: "Shift Detail", message:
//            "Dept Name", preferredStyle: .alert)
//
//       // DetailalertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//
//        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func GetPendingSwapApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/shifts/post/pickup/user/"+UserDefaults.standard.string(forKey: "uid")!
        
        
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        
        
        Alamofire.request(url, method: .post, parameters:nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                self.users_Array = []
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                    
                    if let dic1 = dic["data"] as? NSDictionary{
                        
                        if let myCountry = dic1["pickupShifts"] as? [[String:Any]]{
                            
                            for dic2 in myCountry {
                                if let dic3 = dic2["trades"] as? [[String:Any]]{
                                 for dic4 in dic3 {
                                    
                                  if let Dict = dic4["user"] as? NSDictionary{
                                    var mutitle:String! = ""
                                    var muid:String! = ""
                                    var muimage:String! = ""
                                    if let username1 = Dict["username"] as? String{
                                        
                                        mutitle = username1
                                    }
                                    
                                    if let muid1 = Dict["id"] as? Int{
                                        
                                        let nid:String! = "\(muid1)"
                                        muid = nid
                                    }
                                    
                                    if let profile_pic1 = Dict["profile_pic"] as? String{
                                        
                                        muimage = profile_pic1
                                    }
                                    
                                  
                                    
                                    let obj = UsersMatch(muid: muid, mutitle: mutitle, muimage: muimage)
                                    
                                    self.users_Array.add(obj)
                                }
                                }
                            }
                            }
                            self.tableview.delegate = self
                            self.tableview.dataSource = self
                            self.tableview.reloadData()
                        }else{
                            
                            self.tableview.delegate = self
                            self.tableview.dataSource = self
                            self.tableview.reloadData()
                            
                            
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
        
        return self.users_Array.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MatchTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! MatchTableViewCell
  
        let obj = self.users_Array[indexPath.row] as! TradeClass
        
        
        
         cell.user1_image.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey:"profile_pic")!), placeholderImage: UIImage(named: "ic_profile_default"))
        
        cell.user2_image.sd_setImage(with: URL(string:obj.user?.profilePic ?? ""), placeholderImage: UIImage(named: "ic_profile_default"))
        
        cell.user1_title.text = UserDefaults.standard.string(forKey: "fname")!+" "+UserDefaults.standard.string(forKey: "lname")!
        
        cell.user2_title.text = obj.user?.username
        
        cell.user1_image.layer.masksToBounds = false
        cell.user1_image.layer.cornerRadius = cell.user1_image.frame.height/2
        cell.user1_image.clipsToBounds = true
        
        cell.user2_image.layer.masksToBounds = false
        cell.user2_image.layer.cornerRadius = cell.user2_image.frame.height/2
        cell.user2_image.clipsToBounds = true
        
      
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
             let obj = self.users_Array[indexPath.row] as! TradeClass
        
        StaticData.obj.receiver_id = "\(obj.user?.id ?? 0)"
        StaticData.obj.receiver_name = obj.user?.username
        StaticData.obj.receiver_Shiftid = obj.id
        StaticData.obj.shift_type = obj.shiftType.map { $0.rawValue }
        
        //Chat1ViewController
        
        delegate.LastViewController = self
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let pendingdetail = sb.instantiateViewController(withIdentifier: "Chat1ViewController") as! Chat1ViewController
        revealViewController()?.setFront(pendingdetail, animated: true)
        
//        self.performSegue(withIdentifier:"gotochat", sender: self)
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 232
    }
    
    
    
    
    @IBAction func back(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        
        revealViewController()?.setFront(delegate.LastViewController, animated: true)
        //self.dismiss(animated:true, completion: nil)
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
