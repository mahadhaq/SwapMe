//
//  SendRequestViewController.swift
//  SwapMe
//
//  Created by Shawal's Mac on 18/11/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class SendRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tabelview: UITableView!
    
    @IBOutlet weak var popup: UIView!
    
    var swap_Array:NSMutableArray = []
    
    var history_Array:NSMutableArray = []
    
    var senderid : String?
    var receiverid : String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetSwapMatchedHistoryApi()
        
        popup.layer.cornerRadius = 10
        popup.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        
      self.tabelview.tableFooterView = UIView()
    }
    
    
    
    
   //------------------------- Send Button -------------------
    @IBAction func sendRequest(_ sender: UIButton) {
        
        sendRequest()
    }
    
    
    // ---------------------- Send request method ---------------------------------------
    
    func sendRequest(){
        
       let  sv = LoginViewController.displaySpinner(onView: self.view)
               
        
        var perama:String! = "0"
        
        if(StaticData.obj.isPermanentPick == "NO"){
            
            perama = "0"
        }else{
            
            perama = "1"
        }
                      
                      
        let url : String = "http://app.pyprentals.com/api/shifts/\(StaticData.obj.shift_id ?? "")/request"
               
               
                      
        let parameter:[String:Any]?  = ["shift_type": StaticData.obj.shift_type ?? SHIFT_TYPE_SINGLE,"user_id": StaticData.obj.receiver_id! ,"shift_id": StaticData.obj.shift_id ?? 0,"user_shift_id":StaticData.obj.receiver_Shiftid ?? 0 ]
                      
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
                              
//                              let code = dic["status"] as? NSNumber
//                              print(code)
//                              if(code == 200){
                                  
                                  let message = dic["message"] as! String
                                  
                                  
                                  
                                  let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                                  let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                                      
                                      alertController.dismiss(animated: true, completion: nil)
                                  })
                                  
                                  alertController.addAction(alertAction)
                                  
                                  self.present(alertController, animated: true, completion: nil)
                                  
                                  
//                              }else{
//
//                                  let message = dic["message"] as! String
//                                  self.alertModule(title:"Error", msg:message)
//                              }
//
                              
                              
                          case .failure(let error):
                              
                              print(error)
                              
                              LoginViewController.removeSpinner(spinner: sv)
                              self.view.isUserInteractionEnabled = true
                              self.alertModule(title:"Error",msg:error.localizedDescription)
                              
                              
                          }
                      })
        
            
       
        
        
     /*   let parameter:[String:Any]?  = ["shift_type": "SINGLE_SHIFT","user_id": "237" ,"user_shift_id": "406"]
    
        guard let url = URL(string: "http://app.pyprentals.com/api/shifts/407/request") else {return}
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content")
        
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {return}
        
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                print(response)
            }
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                     
                }catch{
                    print(error)
                }
            }
            
        }.resume()*/
   
    }
    
    
    
    
    //------------------------- Cancel Button -------------------
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return history_Array.count
    }
    
   
    
    
    // ----------------- row selected --------------------
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //  print(self.history_Array[indexPath.row])
        
        let obj = self.history_Array[indexPath.row] as! MatchElement
         
        StaticData.obj.shift_id = "\(obj.id ?? 0)"
        
        if(obj.shiftType == SHIFT_TYPE_POST || obj.shiftType == SHIFT_TYPE_PICKUP)
        {
            StaticData.obj.shift_type = SHIFT_TYPE_SINGLE
        }
        else
        {
            StaticData.obj.shift_type = SHIFT_TYPE_POST_PICKUP
        }
        
        
//        StaticData.obj.shift_type = obj.shiftType
        
        
        
//         let time:String! = obj.swapStart+"-"+obj.swapEnd
//         StaticData.obj.detailmatch = obj.swapDate+","+obj.swapDeps+","+time
//         StaticData.obj.shift_type = self.history_Array[indexPath.row] as? String
//         StaticData.obj.shift_id = obj.swapID
//        StaticData.obj.nnid = obj.nnid
         
        // if(obj.swapType == "0"){
             
           //  self.performSegue(withIdentifier:"gotomatch", sender: self)
        
    }
    
    
    //------------------------- Return cell Method -------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RequestTableViewCell = tableView.dequeueReusableCell(withIdentifier:"requestcell", for: indexPath) as! RequestTableViewCell
        
        let obj = self.history_Array[indexPath.row] as! MatchElement
               
        cell.requetlabel.text = obj.getTitle()
//        let time:String! = obj.swapStart+"-"+obj.swapEnd
//
//        cell.requetlabel.text = obj.swapDate+","+obj.swapDeps+","+time
               return cell

        
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
                
                
                do{
                    self.history_Array.removeAllObjects()
                    let decoder = JSONDecoder()
                    let array = try decoder.decode(GetHistoryModel.self, from: respones.data!)
                    LoginViewController.removeSpinner(spinner: sv)
                    self.view.isUserInteractionEnabled = true
                    print(array)
                    if array.status == 200
                    {
                        self.history_Array.addObjects(from: array.data?.post?.match ?? [])
                    }
                    self.tabelview.delegate = self
                    self.tabelview.dataSource = self
                    self.tabelview.reloadData()
                    
                }
                catch
                {
                    
                }
                
                
                
//                self.history_Array = []
//                let json  = value
//                LoginViewController.removeSpinner(spinner: sv)
//                self.view.isUserInteractionEnabled = true
//                print(json)
//                let dic = json as! NSDictionary
//                let code = dic["status"] as! NSNumber
//                print(code)
//                if(code == 200){
//
//                    if let dic1 = dic["data"] as? NSDictionary{
//
//                        if let dic2 = dic1["post"] as? NSDictionary{
//
//                        if let myCountry = dic2["match"] as? [[String:Any]]{
//                            print(myCountry)
//                        //
//                        for Dict in myCountry {
//
//                            var swapDate:String! = ""
//                            var swapDeps:String! = ""
//                            var swapStart:String! = ""
//                            var swapEnd:String! = ""
//                            var swapID:String! = ""
//                            var swapType:String! = ""
//
//
//                            if let date1 = Dict["date"] as? String{
//
//                                swapDate = date1
//                            }else{
//                                if let dateArray = Dict["days"] as? NSArray{
//                                    print(dateArray.count)
//                                    for index in 0..<dateArray.count{
//
//                                        if let date2 = dateArray[index] as? String{
//
//                                            var stringArry:[String] = []
//                                            stringArry.append(date2)
//
//                                            swapDate = stringArry.joined(separator: ", ")
//
//                                        }
//
//
//                                    }
//                                }
//                            }
//
//                            if let departments = Dict["departments"] as? String{
//
//                                swapDeps = departments
//                            }
//
//                            if let start_time = Dict["start_time"] as? String{
//
//                                swapStart = start_time
//                            }
//
//                            if let end_time = Dict["end_time"] as? String{
//
//                                swapEnd = end_time
//                            }
//                            if let Did = Dict["id"] as? Int{
//
//                                let nid:String! = "\(Did)"
//                                swapID = nid
//                            }
//
//                            if let type = Dict["shift_type"] as? String{
//
//                                swapType = type
//                            }
//
//                            let obj = History(swapDate: swapDate, swapDeps: swapDeps, swapStart: swapStart, swapEnd: swapEnd, swapID: swapID, swapType: swapType)
//
//                            self.history_Array.add(obj)
//                        }
//
//                        self.tabelview.delegate = self
//                        self.tabelview.dataSource = self
//                        self.tabelview.reloadData()
//                    }else{
//
//                        self.tabelview.delegate = self
//                        self.tabelview.dataSource = self
//                        self.tabelview.reloadData()
//
//
//                    }
//                }
//
//        }
//                }
                
            case .failure(let error):
                
                print(error)
                
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                self.alertModule(title:"Error",msg:error.localizedDescription)
                
                
            }
        })
        
        
        
   /*     guard let url = URL(string: "http:app.pyprentals.com/api/shifts/get_history/user/"+UserDefaults.standard.string(forKey: "uid")!) else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
            }
        }.resume()
        */ 
        
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
