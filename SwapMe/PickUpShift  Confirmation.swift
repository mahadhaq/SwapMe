//
//  File.swift
//  SwapMe
//
//  Created by Mr. Nabeel on 12/5/19.
//  Copyright © 2019 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PickUpShiftConfirmation: UIViewController {
    
    let x = UIScreen.main.bounds.size.width
    let y = UIScreen.main.bounds.size.height
    
    // for header
    let bkimage = UI4()
    let header = UI4()
    let menubtn = UI4()
    let notificationbtn = UI4()
    
    // for content
    var userNotificationCenter = UNUserNotificationCenter.current()

    let bodyscroll = UI4()
    let group = UI4()
    let label = [UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4()]
    let permanent = UI4()
    let day = UI4()
    var daynames:[String] = []
    let date = UI4()
    let department = UI4()
    var departmentnames:[String] = []
    let startTime = UI4()
    let endTime = UI4()
    let deleteShiftdays = UI4()

    // for footer
    let backbtn = UI4()
    let findbtn = UI4()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Header
        //////////////////////////////////////
        //////////////////////////////////////
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bkimage.Backgroundimage(src: "bk", view: view)
        header.Image(x: 0, y: 0, width: x, height: 120, src: "header", view: view)
        header.Label(x: x/2 - 150, y: 45, width: 300, height: 40, txt: "Confirm Swap Details", fontsize: 22, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: view)
        menubtn.clickableimage(x: 30, y: 60, width: 20, height: 15, image: UIImage(named: "menu"), function: #selector(menuButton(_:)), any: self, view: view)
        notificationbtn.clickableimage(x: x-55, y: 55, width: 25, height: 30, image: UIImage(named: "notification"), function: #selector(notificationButton(_:)), any: self, view: view)
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Content
        //////////////////////////////////////
        //////////////////////////////////////
        bodyscroll.ScrollView(x: 0, y: 120, width: x, height: y-250, bkcolor: UIColor.clear, contentwidth: x, contentheight: y, view: view)
        label[0].Label(x: 20, y: 10, width: 150, height: 40, txt: "Request Details:", fontsize: 20, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: .black, view: bodyscroll.scrollview)
        
        group.View(x: 20, y: label[0].label.frame.maxY, width: x-40, height: (30*8)+20, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 20, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        // 1st goroup label
        label[1].Label(x: 10, y: 10, width: 80, height: 30, txt: "Your Shift:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        label[2].Label(x: 10, y: label[1].label.frame.maxY, width: 100, height: 30, txt: "-Permanent:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        permanent.Label(x: label[2].label.frame.maxX, y: label[1].label.frame.maxY, width: 200, height: 30, txt: "\(PickupShiftvar.Static.permanent)", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        
        label[3].Label(x: 10, y: label[2].label.frame.maxY, width: 65, height: 30, txt: "-Day(s):", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        day.ScrollView(x: label[3].label.frame.maxX, y: label[2].label.frame.maxY, width: group.view.frame.size.width-label[2].label.frame.size.width-20, height: 30, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), contentwidth: group.view.frame.size.width, contentheight: 30, view: group.view)
        var d = ""
        for a in PickupShiftvar.Static.days {
            d+="'"+a+"'  ";
            daynames.append(a);
        }
        day.AutoSizeLabel(x: 0, y: 0, height: 30, txt: d, fontsize: 18, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 0, view: day.scrollview)
        day.scrollview.contentSize.width = day.autoSizelabel.frame.size.width
        
        
        
        label[4].Label(x: 10, y: label[3].label.frame.maxY, width: 55, height: 30, txt: "-Date:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        date.Label(x: label[4].label.frame.maxX, y: label[3].label.frame.maxY, width: 200, height: 30, txt: PickupShiftvar.Static.date, fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        
        label[5].Label(x: 10, y: label[4].label.frame.maxY, width: 125, height: 30, txt: "-Department(s):", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        department.ScrollView(x: label[5].label.frame.maxX, y: label[4].label.frame.maxY, width: group.view.frame.size.width-label[5].label.frame.size.width-20, height: 30, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), contentwidth: group.view.frame.size.width, contentheight: 30, view: group.view)
        var d1 = ""
        for a1 in PickupShiftvar.Static.departmentName {
            d1+="'"+a1+"'  ";
            departmentnames.append(a1);
        }
        department.AutoSizeLabel(x: 0, y: 0, height: 30, txt: d1, fontsize: 18, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 0, view: department.scrollview)
        department.scrollview.contentSize.width  = department.autoSizelabel.frame.size.width
        
        
        label[6].Label(x: 10, y: label[5].label.frame.maxY, width: 90, height: 30, txt: "-Start time:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        startTime.Label(x: label[6].label.frame.maxX, y: label[5].label.frame.maxY, width: 200, height: 30, txt: "\(PickupShiftvar.Static.starttime[0])-\(PickupShiftvar.Static.starttime[1])", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        label[7].Label(x: 10, y: label[6].label.frame.maxY, width: 80, height: 30, txt: "-End time:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        endTime.Label(x: label[7].label.frame.maxX, y: label[6].label.frame.maxY, width: 200, height: 30, txt: "\(PickupShiftvar.Static.endtime[0])-\(PickupShiftvar.Static.endtime[1])", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        label[8].Label(x: 10, y: label[7].label.frame.maxY, width: 230, height: 30, txt: "-Delete this shift request after:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        deleteShiftdays.Label(x: label[8].label.frame.maxX, y: label[7].label.frame.maxY, width: 30, height: 30, txt: "\(PickupShiftvar.Static.deleteShiftdays)", fontsize: 16, bold: true, cornerRadius: 5, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), txtcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), view: group.view)
        label[9].Label(x: deleteShiftdays.label.frame.maxX+3, y: label[7].label.frame.maxY, width: 50, height: 30, txt: "Day(s)", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group.view)
        bodyscroll.scrollview.contentSize.height = group.view.frame.maxY
        
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Footer
        //////////////////////////////////////
        //////////////////////////////////////
        backbtn.Button(x: 40, y: y-120, width: 100, height: 50, title: "BACK", any: self, function: #selector(backButton(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: view)
        findbtn.Button(x: x-180, y: y-120, width: 150, height: 50, title: "FIND MY MATCH", any: self, function: #selector(findButton(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: view)
        
    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func menuButton(_ btn:UIButton){
        print("clicked menu button")
    }

    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func notificationButton(_ btn:UIButton){
        print("clicked notification button")
    }
    
    
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func backButton(_ btn:UIButton){
        print("clicked back button")
        self.dismiss(animated: true, completion: nil)
    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func findButton(_ btn:UIButton){
        print("clicked find button")
        PickupShiftApi()
    }
    
    
    
    func PickupShiftApi(){
        print("-----------------------------------------")
        print("nabeel is here DetailPickViewController")
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        var perama:String! = "0"
        
        if(PickupShiftvar.Static.permanent){perama = "1"}else{perama = "0"}
        var days = ""
        for d in PickupShiftvar.Static.days {
            days += d
        }
        print("validation date: \(PickupShiftvar.Static.date)")
        
        
        let url : String = "http://app.pyprentals.com/api/shifts/pick"
        
        let parameter:[String:Any]?  = ["trade_name":"Default trade",
                                        "user_id":UserDefaults.standard.string(forKey:"uid")!,
                                        "is_permanent":perama!,
                                        "days":days,
                                        "date":PickupShiftvar.Static.date,
                                        "departments":PickupShiftvar.Static.departmentName,
                                        "start_time":PickupShiftvar.Static.starttime[0]+"-"+PickupShiftvar.Static.starttime[1],
                                        "end_time":PickupShiftvar.Static.endtime[0]+"-"+PickupShiftvar.Static.endtime[0]]
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        print(parameter!)
        
        
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
                    
                    let notificationContent = UNMutableNotificationContent()
                    notificationContent.title = "SwapMe"
                    notificationContent.body = message
                    notificationContent.badge = NSNumber(value: 1)
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                                    repeats: false)
                    let request = UNNotificationRequest(identifier: "testNotification",
                                                        content:notificationContent,
                                                        trigger: trigger)
                    
                    self.userNotificationCenter.add(request) { (error) in
                        if let error = error {
                            print("Notification Error: ", error)
                        }
                    }
                    
                    let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                        
                        self.dismiss(animated:true, completion: nil)
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
    
    func alertModule(title:String,msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    
}
