//
//  EyeDetailViewController.swift
//  SwapMe
//
//  Created by Shawal's Mac on 04/12/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire

class EyeDetailViewController: UIViewController {

    let obj : History? = nil
    
    @IBOutlet weak var deataillbl: UILabel!
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        
    }
    
    
    
    
   /* func apiget(){
         
         
         
         let  sv = LoginViewController.displaySpinner(onView: self.view)
         
         
         
         let url : String = "http://app.pyprentals.com/api/history/237"//+UserDefaults.standard.string(forKey: "uid")!

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
                         
                        
                         
                        
                     }
                 }
                 
                 
             case .failure(let error):
                 
                 print(error)
                 
                 
                 
             }
         })
         
         
     }

   */

}
