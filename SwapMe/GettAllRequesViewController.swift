//
//  GettAllRequesViewController.swift
//  SwapMe
//
//  Created by Shawal's Mac on 28/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire


class GettAllRequesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    var request_Array:NSMutableArray = []
    var IncomingReqArray:[MsgReqDatum] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return request_Array.count
        return IncomingReqArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GetallRequestTableViewCell = self.requestTableView.dequeueReusableCell(withIdentifier: "getallrequest",for: indexPath) as! GetallRequestTableViewCell
        
        
        
//        let obj = self.request_Array[indexPath.row] as! AllRequest
        
        let data = IncomingReqArray[indexPath.row] as! MsgReqDatum
        
        if (data.shift != nil)
        {
            cell.RequestLabel.text = data.shift!.user?.username
            cell.detailLabel.text = data.getTitle()
            cell.shift_id = data.shiftID
            cell.reqID = data.id
            cell.getallreq = self
        }
        
        //        let time:String! = obj.swapStart+"-"+obj.swapEnd
        //
        //        cell.detailLabel.text = obj.swapDate+","+obj.swapDeps+","+time
        //        cell.RequestLabel.text = "Shawal"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    
    @IBOutlet weak var requestTableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        GetSwapHistoryApi()
    //    }
    
    func ViewAppearing() {
        GetSwapHistoryApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetSwapHistoryApi()
    }
    
    override func viewWillLayoutSubviews() {
        self.view.frame = (self.view.superview?.bounds)!
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.view.removeFromSuperview()
    }
    
    // --------------------------- Accept Button -----------------------------------
    @IBAction func Acceptbtn(_ sender: CircleButton) {
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
            print(sender.tag)
            
            let status = "ACCEPTED"
            //   let url = "http://app.pyprentals.com/api/shift_requests/148"
            let  sv = LoginViewController.displaySpinner(onView: self.view)
            
            
            
            let url : String = "http://app.pyprentals.com/api/shift_requests/148"
            
            let parameter:[String:Any]?  = ["status":"ACCEPTED","shift_id":"409"]
            
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
            print(parameter!)
            
            Alamofire.request(url, method: .patch, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
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
                            
                            self.dismiss(animated:true, completion: nil)
                            alertController.dismiss(animated: true, completion: nil)
                            self.GetSwapHistoryApi()
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
        
        
        
    }
    
    // --------------------------- Decline Button -----------------------------------
    /* @IBAction func Declinebtn(_ sender: Any) {
     
     if let buttonTitle = sender.title(for: .normal) {
     print(buttonTitle)
     }
     // DeclineRequest()
     
     }
     */
    @IBAction func Declinebtn(_ sender: CircleButton) {
        if let buttonTitle = sender.title(for: .normal) {
            print(buttonTitle)
            let status = "REJECTED"
            let  sv = LoginViewController.displaySpinner(onView: self.view)
            
            
            
            let url : String = "http://app.pyprentals.com/api/shift_requests/148"
            
            let parameter:[String:Any]?  = ["status":"REJECTED","shift_id":"409"]
            
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
            print(parameter!)
            
            Alamofire.request(url, method: .patch, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
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
                            
                            self.dismiss(animated:true, completion: nil)
                            alertController.dismiss(animated: true, completion: nil)
                            self.GetSwapHistoryApi()
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
        
        
        
    }
    
    
    
    
    
    // --------------------------- Accept API -----------------------------------
    
    func AcceptRequest(){
        
        
    }
    
    
    
    // --------------------------- Decline API -----------------------------------
    
    func DeclineRequest(){
        
        
    }
    
    
    
    // --------------------------- Get All Request API -----------------------------------
    
    
    func GetSwapHistoryApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        let url : String = "http://app.pyprentals.com/api/shift_requests/user/"+UserDefaults.standard.string(forKey: "uid")!
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        
        
        Alamofire.request(url, method: .get, parameters:nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                do{
                    self.IncomingReqArray.removeAll()
                    let decoder = JSONDecoder()
                    //                        let str = String(decoding: respones as! Data, as: UTF8.self)
                    let array = try decoder.decode(IncomingRequestModel.self, from: respones.data!)
                    LoginViewController.removeSpinner(spinner: sv)
                    self.view.isUserInteractionEnabled = true
                    print(array)
                    
                    if array.status == 200
                    {
                        self.IncomingReqArray = array.data ?? []
                    }
                    self.requestTableView.delegate = self
                    self.requestTableView.dataSource = self
                    self.requestTableView.reloadData()
                }
                catch
                {
                    
                }
                
                
                
                
                //                      self.request_Array = []
                //                      let json  = value
                //
                //                      print(json)
                //                      let dic = json as! NSDictionary
                //                      let code = dic["status"] as! NSNumber
                //                      print(code)
                //                      if(code == 200){
                //
                //                          if let myCountry = dic["data"] as? [[String:Any]]{
                //                              print(myCountry)
                //
                //                              //
                //                              for Dict in myCountry {
                //
                //                                  var swapDate:String! = ""
                //                                  var swapDeps:String! = ""
                //                                  var swapStart:String! = ""
                //                                  var swapEnd:String! = ""
                //
                //
                //
                //                                  if let date1 = Dict["date"] as? String{
                //
                //                                      swapDate = date1
                //                                  }else{
                //                                      if let dateArray = Dict["days"] as? NSArray{
                //                                          print(dateArray.count)
                //                                          for index in 0..<dateArray.count{
                //
                //                                              if let date2 = dateArray[index] as? String{
                //
                //                                                  var stringArry:[String] = []
                //                                                  stringArry.append(date2)
                //
                //                                                  swapDate = stringArry.joined(separator: ", ")
                //
                //                                              }
                //
                //
                //                                          }
                //                                      }
                //                                  }
                //
                //                                  if let departments = Dict["departments"] as? NSArray{
                //
                //                                      swapDeps = (departments[0] as! String)
                //                                  }
                //
                //                                  if let start_time = Dict["start_time"] as? String{
                //
                //                                      swapStart = start_time
                //                                  }
                //
                //                                  if let end_time = Dict["end_time"] as? String{
                //
                //                                      swapEnd = end_time
                //                                  }
                //
                //
                //                                 let obj = AllRequest(swapDate: swapDate, swapDeps: swapDeps, swapStart: swapStart, swapEnd: swapEnd )
                //
                //                                  self.request_Array.add(obj)
                //                             }
                //
                //                              self.requestTableView.delegate = self
                //                              self.requestTableView.dataSource = self
                //                              self.requestTableView.reloadData()
                //                          }else{
                //
                //                              self.requestTableView.delegate = self
                //                              self.requestTableView.dataSource = self
                //                              self.requestTableView.reloadData()
                //
                //
                //                          }
                //                      }
                
                
            case .failure(let error):
                
                print(error)
                
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                self.alertModule(title:"Error",msg:error.localizedDescription)
                
                
            }
        })
        
        
    }
    
    
    
    
    
    
    
    // --------------------------- TableView Cell  ------------------------------------------------
    
    
    
    
    
    
    // -------------------------------- AlertModule -------------------------------------------
    
    func alertModule(title:String,msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
}










