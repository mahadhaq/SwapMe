//
//  PendingSwapViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 23/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class PendingSwapViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var swap_Ahistory_Arrayrray:NSMutableArray = []
    
    var history_Array:NSMutableArray = []
    
    var pendingSwapArray:NSMutableArray = []
    
     @IBOutlet weak var btn_menu: UIButton!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.GetSwapHistoryApi()
        
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        self.tableview.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        delegate.LastViewController = delegate.homeViewController
    }
    
    func GetSwapHistoryApi(){
         
         
         
         let  sv = LoginViewController.displaySpinner(onView: self.view)
         
         
         
         let url : String = "http://app.pyprentals.com/api/shifts/post/pickup/user/"+UserDefaults.standard.string(forKey: "uid")!
         
         
         
         let header: HTTPHeaders = [
             
             "Accept": "application/json"
         ]
         
         print(url)
    
         
         Alamofire.request(url, method: .get, parameters:nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
             
             respones in
             
             switch respones.result {
             case .success( let value):
                 
//                let pp = PendingSwapShift()
//                let pp1 = PostPickupShift()
//                pendingSwapArray.add(pp)
//                pendingSwapArray.add
                
                do{
                    self.pendingSwapArray.removeAllObjects()
                    let decoder = JSONDecoder()
                    //                        let str = String(decoding: respones as! Data, as: UTF8.self)
                    let array = try decoder.decode(PendingSwapModel.self, from: respones.data!)
                    LoginViewController.removeSpinner(spinner: sv)
                    self.view.isUserInteractionEnabled = true
                    print(array)
                    
                    if array.status == 200
                    {
                        if let postshifts = array.data?.postShifts
                        {
                             self.pendingSwapArray.addObjects(from: postshifts)
                        }
                        if let pickupshifts = array.data?.pickupShifts
                        {
                            self.pendingSwapArray.addObjects(from: pickupshifts)
                        }
                        if let postpickshifts = array.data?.postPickupShifts
                        {
                            self.pendingSwapArray.addObjects(from: postpickshifts)
                        }
                    }
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
                }
                catch
                {
                    
                }
                
                
                
                
//                self.history_Array.removeAllObjects()
//                 let json  = value
//                 LoginViewController.removeSpinner(spinner: sv)
//                 self.view.isUserInteractionEnabled = true
//                 print(json)
//                 let dic = json as! NSDictionary
//                 let code = dic["status"] as! NSNumber
//                 print(code)
//                 if(code == 200){
//
//                     if let myCountry = dic["data"] as? [[String:Any]]{
//                         print(myCountry)
//
//                         //
//                         for Dict in myCountry {
//
//                             var swapDate:String! = ""
//                             var swapDeps:String! = ""
//                             var swapStart:String! = ""
//                             var swapEnd:String! = ""
//                             var swapID:String! = ""
//                             var swapType:String! = ""
//
//
//                             if let date1 = Dict["date"] as? String{
//
//                                 swapDate = date1
//                             }else{
//                                 if let dateArray = Dict["days"] as? NSArray{
//                                     print(dateArray.count)
//                                     for index in 0..<dateArray.count{
//
//                                         if let date2 = dateArray[index] as? String{
//
//                                             var stringArry:[String] = []
//                                             stringArry.append(date2)
//
//                                             swapDate = stringArry.joined(separator: ", ")
//
//                                         }
//
//
//                                     }
//                                 }
//                             }
//
//                             if let departments = Dict["departments"] as? NSArray{
//
//                                 swapDeps = (departments[0] as! String)
//                             }
//
//                             if let start_time = Dict["start_time"] as? String{
//
//                                 swapStart = start_time
//                             }
//
//                             if let end_time = Dict["end_time"] as? String{
//
//                                 swapEnd = end_time
//                             }
//                             if let Did = Dict["id"] as? Int{
//
//                                 let nid:String! = "\(Did)"
//                                 swapID = nid
//                             }
//
//                             if let type = Dict["shift_type"] as? String{
//
//                                 swapType = type
//                             }
//
//                            let obj = History(swapDate: swapDate, swapDeps: swapDeps, swapStart: swapStart, swapEnd: swapEnd, swapID: swapID, swapType: swapType)
//
//                             self.history_Array.add(obj)
//                        }
//
//                         self.tableview.delegate = self
//                         self.tableview.dataSource = self
//                         self.tableview.reloadData()
//                     }else{
//
//                         self.tableview.delegate = self
//                         self.tableview.dataSource = self
//                         self.tableview.reloadData()
//
//
//                     }
//                 }
                 
                 
             case .failure(let error):
                 
                 print(error)
                 
                 LoginViewController.removeSpinner(spinner: sv)
                 self.view.isUserInteractionEnabled = true
                 self.alertModule(title:"Error",msg:error.localizedDescription)
                 
                 
             }
         })
         
         
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return self.history_Array.count
        
        return pendingSwapArray.count
        
        
    }
    
     // ---------------------------------- select rowatIndex -----------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:HistoryTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! HistoryTableViewCell
        
        
        let obj = self.pendingSwapArray[indexPath.row]
        
        if let data = obj as? PendingSwapShift
        {
            if let shift = data.shift
            {
                if shift.endTime == "\(AM_FRONT):00" || shift.endTime == "\(PM_FRONT):00" || shift.endTime == "\(PM_BACK):00" || shift.startTime == "\(AM_FRONT_START):00" || shift.startTime == "\(PM_FRONT_START):00" || shift.startTime == "\(PM_BACK_START):00"
                {
                    cell.lbl_history.backgroundColor = partialShiftColor
                }
                if shift.shiftType == ShiftType.shiftCreate
                {
                    cell.lbl_history.backgroundColor = postShiftColor
                }
                if shift.shiftType == ShiftType.shiftPickup
                {
                    cell.lbl_history.backgroundColor = pickShiftColor
                }
//                if shift.shiftType == ShiftType.POSTPICKUPSHIFT
//                {
//                    cell.lbl_history.backgroundColor == swapAShiftColor
//                }
                cell.lbl_history.text = shift.getTitle()
            }
        }
        
        else if let data = obj as? PostPickupShift
        {
            if let shift = data.shift
            {

                cell.lbl_history.backgroundColor = swapAShiftColor
                cell.lbl_history.text = shift.getPostPickupTitle()
            }
        }
        
        
        
//        if obj is PendingSwapShift
//        {
//            obj
//        }
        
        
//        let obj = self.history_Array[indexPath.row] as! History
//
//        let time:String! = obj.swapStart+"-"+obj.swapEnd
//
//        cell.lbl_history.text = obj.swapDate+","+obj.swapDeps+","+time
//
        return cell
        
        
    }
    // ---------------------------------- select row -----------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let obj = self.history_Array[indexPath.row] as! History
        let obj = self.pendingSwapArray[indexPath.row]
        delegate.LastViewController = self
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let pendingdetail = sb.instantiateViewController(withIdentifier: "PendingDetailViewController") as! PendingDetailViewController
        if let data = obj as? PendingSwapShift
                {
                    if let shift = data.shift
                    {
                        StaticData.obj.detailmatch =  shift.getTitle()
                        StaticData.obj.depValue = shift.departments
                    }
                    pendingdetail.pendingSwapData = data
                    pendingdetail.postPickSwapData = nil
                }
                
                else if let data = obj as? PostPickupShift
                {
                    if let shift = data.shift
                    {
                        StaticData.obj.detailmatch = shift.getPostPickupTitle()
                        StaticData.obj.depValue = "\(shift.postDepartment) \(shift.pickupDepartments)"
                    }
                    pendingdetail.pendingSwapData = nil
                    pendingdetail.postPickSwapData = data
                }
        
        
        
        
//        let time:String! = obj.swapStart+"-"+obj.swapEnd
//        StaticData.obj.detailmatch = obj.swapDate+","+obj.swapDeps+","+time
//        StaticData.obj.shift_type = self.history_Array[indexPath.row] as? String
//        StaticData.obj.shift_id = obj.swapID
        
       // if(obj.swapType == "0"){
        
        pendingdetail.pendingswapVC = self
        
        revealViewController()?.setFront(pendingdetail, animated: true)
//            revealViewController()?.pushFrontViewController(pendingdetail, animated: true)
//            self.performSegue(withIdentifier:"gotomatch", sender: self)
       // }
       
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "gotomatch"
//        {
//            
//        }
//    }
//    
     // ---------------------------------- row  Hight -----------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let obj = self.pendingSwapArray[indexPath.row]
        if let data = obj as? PostPickupShift
               {
                   return 100
               }
        return 74
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        revealViewController()?.setFront(delegate.LastViewController, animated: true)
//        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated:true, completion: nil)
    }
    
    
    
     // ---------------------------------- select row -----------------------
    
    
    
    func alertModule(title:String,msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    


}
