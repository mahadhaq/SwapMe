//
//  SwapViewController.swift
//  SwapMe
//
//  Created by Mr. Nabeel on 12/3/19.
//  Copyright © 2019 Mr. Nabeel. All rights reserved.
//




/*
 line 290:   selectDepartmentButton function
 */
import Foundation
import UIKit
import Alamofire


let x = UIScreen.main.bounds.size.width
let y = UIScreen.main.bounds.size.height

class SwapShiftViewController1: UIViewController {

    
    
    
    var dataSource = DepartmentResponse()
    
    
    //--------------------------------------------- get Api----------------------------------
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
              
                let json  = value
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
              
                do {
                             
                    let jsonDecoder = JSONDecoder()
                    self.dataSource = try jsonDecoder.decode(DepartmentResponse.self, from: respones.data!)
                    print(self.dataSource)
                             
                    }
                catch {
                    print("Json Mapping Error")
                }
                
            case .failure(let error):
                
                print(error)
                
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                self.alertModule(title:"Error",msg:error.localizedDescription)
            
            }
        })
    }
    
    //------------------------------------ Alert Module ---------------------------------------
    func alertModule(title:String,msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    //--------------------------------------------- get Api----------------------------------
    
    

    //for header
    let header = UI1()
    let menubtn = UI1()
    let heading = UI1()
    let notificationbtn = UI1()
    //for content
    let body = UI1()
    let one = UI1()
    let onelabel = UI1()
    let check = UI1(), datepicker = UI1(),daypicker = UI1()
    let day = [UI1(),UI1(),UI1(),UI1(),UI1(),UI1(),UI1()]
    let dayname = ["M","T","W","T","F","S","S"]
    var daynameSelect = [false,false,false,false,false,false,false]
    let line1 = UI1()
    let department = UI1(), departmentlabel = UI1()
    let line2 = UI1()
    let three = UI1()
    let threelabel = UI1()
    let two = UI1()
    let twolabel = UI1()
    let starttime = UI1(), starttimeTrue = UI1(), starttimeFalse = UI1(), starttimeTruelabel = [UI1(),UI1(),UI1(),UI1(),UI1()], starttimeFalselabel = [UI1(),UI1()]
    let starttimepicker = UI1(), starttimelabel = UI1(), starttimebutton = [UI1(),UI1()]
    var starttimeRadios:[Int:Bool] = [1:false,2:false,3:false,4:false]
    let endtime = UI1(), endtimeTrue = UI1(), endtimeFalse = UI1(), endtimeTruelabel = [UI1(),UI1(),UI1(),UI1(),UI1()], endtimeFalselabel = [UI1(),UI1()]
    var endtimeRadios:[Int:Bool] = [1:false,2:false,3:false,4:false]
    let note = UI1()
    let line3 = UI1()
    let toast = UI1()
    //for footer
    let footer = UI1()
    let backbtn = UI1()
    let continuebtn = UI1()

    let delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3131641746, green: 0.3097496033, blue: 0.3063026071, alpha: 1)

        
        GetDepartmentApi()

        //////////////////////////////////////
        //////////////////////////////////////
        // Header
        //////////////////////////////////////
        //////////////////////////////////////

        header.View(x: 0, y: 40, width: x, height: 50, bkcolor: #colorLiteral(red: 0.3131641746, green: 0.3097496033, blue: 0.3063026071, alpha: 1)
            , cornerRadius: 0, border: 0, borderColor: .clear, view: view)
        menubtn.clickableimage(x: 30, y: 20, width: 20, height: 15, image: UIImage(named: "menu"), function: #selector(menuButton(_:)), any: self, view: header.view)

        if self.revealViewController() != nil {
            menubtn.clickableimg.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        heading.Label(x: (x/2)-105, y: 0, width: 210, height: 50, txt: "ENTER SHIFT \nYOU WANT TO GIVE AWAY", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: header.view)

        notificationbtn.clickableimage(x: x-55, y: 10, width: 25, height: 30, image: UIImage(named: "notification"), function: #selector(notificationButton(_:)), any: self, view: header.view)



        //////////////////////////////////////
        //////////////////////////////////////
        // Content
        //////////////////////////////////////
        //////////////////////////////////////

        body.ScrollView(x: 0, y: header.view.frame.maxY+1, width: x, height: y-240, bkcolor: #colorLiteral(red: 0.3131641746, green: 0.3097496033, blue: 0.3063026071, alpha: 1), contentwidth: x, contentheight: y+100, view: view)
        one.Label(x: 30, y: 30, width: 40, height: 40, txt: "1", fontsize: 16, bold: false, cornerRadius: 20, border: 1, borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), alignment: .center, bkcolor: #colorLiteral(red: 0.5995008349, green: 0.8179860711, blue: 0.5239533782, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)

        onelabel.Label(x: one.label.frame.maxX+10, y: 30, width: 100, height: 40, txt: "DAY/DATE", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        check.checkBox(x: 35, y: one.label.frame.maxY+20, width: 20, height: 20, isChecked: false, view: body.scrollview)
        check.Label(x: check.checkbox.frame.maxX+10, y: one.label.frame.maxY+15, width: 250, height: 30, txt: "MAKE THIS SWAP PERMANENT", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        selectDate_or_Day()
        selectDate_or_Day_Change()
        checkboxonClick.function = selectDate_or_Day_Change

        //////////////////////////////////////////

        line1.View(x: 30, y: datepicker.view.frame.maxY, width: x-60, height: 1, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 0, border: 0, borderColor: .clear, view: body.scrollview)
        two.Label(x: 30, y: line1.view.frame.maxY+10, width: 40, height: 40, txt: "2", fontsize: 16, bold: false, cornerRadius: 20, border: 1, borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), alignment: .center, bkcolor: #colorLiteral(red: 0.5995008349, green: 0.8179860711, blue: 0.5239533782, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        twolabel.Label(x: two.label.frame.maxX+10, y: line1.view.frame.maxY+10, width: 110, height: 40, txt: "DEPARTMENT", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        department.Label(x: 30, y: twolabel.label.frame.maxY, width: 150, height: 30, txt: "Select Department", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        department.View(x: 30, y: department.label.frame.maxY+10, width: x-60, height: 50, bkcolor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), cornerRadius: 20, border: 0, borderColor: .clear, view: body.scrollview)
        departmentlabel.Label(x: 20, y: 0, width: x-10, height: 50, txt: "MainLine Departments", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), view: department.view)
        department.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectDepartmentButton(_:)) ))
        /////////////////////////////////////////

        line2.View(x: 30, y: department.view.frame.maxY+10, width: x-60, height: 1, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 0, border: 0, borderColor: .clear, view: body.scrollview)
        three.Label(x: 30, y: line2.view.frame.maxY+10, width: 40, height: 40, txt: "3", fontsize: 16, bold: false, cornerRadius: 20, border: 1, borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), alignment: .center, bkcolor: #colorLiteral(red: 0.5995008349, green: 0.8179860711, blue: 0.5239533782, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        threelabel.Label(x: three.label.frame.maxX+10, y: line2.view.frame.maxY+10, width: 110, height: 40, txt: "Time", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        starttime.Label(x: 30, y: three.label.frame.maxY+10, width: 180, height: 30, txt: "Show Start Time Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        starttime.Switch_(x: x-90, y: three.label.frame.maxY+10, width: 60, height: 30, color: #colorLiteral(red: 0.5995008349, green: 0.8179860711, blue: 0.5239533782, alpha: 1), onbkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        starttime.Switch.addTarget(self, action: #selector(starttimeSwitchButton(_:)), for: .valueChanged)
        starttimeSelcted_or_unSelected()
        radiobuttonClick.startTimefunction = startTimeRadiobuttonUpdater

        endtime.Label(x: 30, y: starttimeFalse.view.frame.maxY+10, width: 180, height: 30, txt: "Show End Time Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        endtime.Switch_(x: x-90, y: starttimeFalse.view.frame.maxY+10, width: 60, height: 30, color: #colorLiteral(red: 0.5995008349, green: 0.8179860711, blue: 0.5239533782, alpha: 1), onbkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: body.scrollview)
        endtime.Switch.addTarget(self, action: #selector(endtimeSwitchButton(_:)), for: .valueChanged)
        endtimeSelcted_or_unSelected()
        radiobuttonClick.endTimefunction = endTimeRadiobuttonUpdater

        note.Label(x: 30, y: endtimeFalse.view.frame.maxY, width: x-60, height: 50, txt: "ALL SHIFTS MUST BE EXACT TIMES OR YOU WILL NOT RECEIVE A MATCH!!!", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left
            , bkcolor: .clear, txtcolor: #colorLiteral(red: 0.5995008349, green: 0.8179860711, blue: 0.5239533782, alpha: 1), view: body.scrollview)
        note.label.lineBreakMode = .byWordWrapping
        line3.View(x: 30, y: note.label.frame.maxY+10, width: x-60, height: 1, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 0, border: 0, borderColor: .clear, view: body.scrollview)
        body.scrollview.contentSize.height = line3.view.frame.maxY+10


        //////////////////////////////////////
        //////////////////////////////////////
        // Footer
        //////////////////////////////////////
        //////////////////////////////////////

        footer.View(x: 0, y: y-150, width: x, height: 100, bkcolor: #colorLiteral(red: 0.3131641746, green: 0.3097496033, blue: 0.3063026071, alpha: 1), cornerRadius: 0, border: 0, borderColor: .clear, view: view)

        backbtn.Button(x: 40, y: 25, width: 100, height: 50, title: "BACK", any: self, function: #selector(backButton(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: footer.view)
        continuebtn.Button(x: x-140, y: 25, width: 100, height: 50, title: "CONTINUE", any: self, function: #selector(continueButton(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: footer.view)

    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        checkboxonClick.isChecked = false
        checkboxonClick2.isChecked = false
        checkboxonClick3.isChecked = false
        checkboxonClick5.isChecked = false

    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func menuButton(_ btn:UIButton){
        print("clicked menu button")
        //////// validation end
    }

    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
     var popoverController:UIPopoverPresentationController?
            @objc func notificationButton(_ btn:UIButton){
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let notesVC = sb.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
    //            notesVC.PickupSwapVC = self
        //        notesVC.isManualSegue = true
                notesVC.preferredContentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
                notesVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        
                        popoverController = notesVC.popoverPresentationController
        //                popoverController?.delegate = self
                popoverController?.sourceView = self.view
                popoverController?.sourceRect = self.view.bounds
                        popoverController?.permittedArrowDirections = .up
                        
                self.present(notesVC, animated: true, completion: nil)

            }
            
            func dismisspopover() {
                popoverController?.presentedViewController.dismiss(animated: true, completion: nil)
                popoverController = nil
            }

    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func backButton(_ btn:UIButton){
////        self.dismiss(animated: true, completion: nil)
//        revealViewController()?.navigationController?.popViewController(animated: true)
//        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        
        revealViewController()?.setFront(delegate.LastViewController, animated: true)
    }
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func continueButton(_ btn:UIButton){
        print("clicked continue button")
        print("-----------")
        print(checkboxonClick.isChecked) // bool
        print(datepicker.selectedDate) // string
        print(daynameSelect)  // array of bool
        
        print(departmentlabel.label.text!) //string
        
        print(starttime.Switch.isOn)
        print(starttimeFalselabel[1].label.text!)
        print(starttimeRadios)
        
        print(endtime.Switch.isOn)
        print(endtimeFalselabel[1].label.text!)
        print(endtimeRadios)
        print("-----------")
        
        
        
        if validation() {
            print(PostShiftvar.Static.permanent)
            print(PostShiftvar.Static.days)
            print(PostShiftvar.Static.date)
            print(PostShiftvar.Static.departmentName)
            print("\(PostShiftvar.Static.starttime[0]) - \(PostShiftvar.Static.starttime[1])")
            print("\(PostShiftvar.Static.endtime[0]) - \(PostShiftvar.Static.endtime[1])")
            
            let vc = SwapShiftViewController2()
            
            vc.swapshift1 = self
            
            delegate.LastViewController = self
            revealViewController()?.setFront(vc, animated: true)
//            self.present(SwapShiftViewController2(), animated: true, completion: nil)
        }


        
    }
    
    
    /////////////////////////////////////////////
    /////////////////////////////////////////////
    ////     Validation
    /////////////////////////////////////////////
    ////////////////////////////////////////////
    
    func validation() -> Bool {
        
        ////////////// day or date validation
        var showtoast = false
        var toastmessage = ""
        resetPostShiftvar()
        if checkboxonClick.isChecked == true {
            PostShiftvar.Static.permanent = checkboxonClick.isChecked
            var selected = false
            var index = 0
            for d in daynameSelect {
                if d == true {
                    selected = true;
                    PostShiftvar.Static.days.append(dayfullname[index])
                }
                index+=1
            }
            if selected == false {
                print("Pick at least one day: Notification")
                showtoast = true
                toastmessage = "Pick at least one day"
            }
            else{
                PostShiftvar.Static.permanent = checkboxonClick.isChecked
            }
        }
        else if checkboxonClick.isChecked == false {
            PostShiftvar.Static.permanent = checkboxonClick.isChecked
            PostShiftvar.Static.date = datepicker.selectedDate
        }
        
        
        ////////////// department validation
        if departmentlabel.label.text! == "MainLine Departments" || departmentlabel.label.text! == "Regional Departments" {
            print("Select a Department: Notification")
            showtoast = true
            toastmessage = "Select a Department"
        }else{
            PostShiftvar.Static.departmentName = departmentlabel.label.text!
            
        }
        
        /////////////// startTime validation
        if starttime.Switch.isOn == true {
            if starttimeRadios[1]! {
                PostShiftvar.Static.starttime[0] = "11:47"
                PostShiftvar.Static.starttime[1] = "11:47"
            }
            if starttimeRadios[2]! {
                PostShiftvar.Static.starttime[0] = "11:49"
                PostShiftvar.Static.starttime[1] = "11:49"
            }
            if starttimeRadios[3]! {
                PostShiftvar.Static.starttime[0] = "23:51"
                PostShiftvar.Static.starttime[1] = "23:51"
            }
            if starttimeRadios[4]! {
                PostShiftvar.Static.starttime[0] = "23:53"
                PostShiftvar.Static.starttime[1] = "23:53"
            }
            var selected = false
            for i in 1...4 {if starttimeRadios[i] == true {selected = true}}
            if selected == false {
                print("Select Partial option: Notification")
                showtoast = true
                toastmessage = "Select Partial option"
            }
        }
        else{
            if starttimeFalselabel[1].label.text! == "0h:0m" {
                print("Select StartTime: Notification")
                showtoast = true
                toastmessage = "Select StartTime"
            }
            else{
                PostShiftvar.Static.starttime[0] = starttimeFalselabel[1].label.text!
                PostShiftvar.Static.starttime[1] = starttimeFalselabel[1].label.text!
            }
            
        }
        
        ///////////////////// endTime validation
        if endtime.Switch.isOn == true {
            if endtimeRadios[1]! {
                PostShiftvar.Static.endtime[0] = "11:47"
                PostShiftvar.Static.endtime[1] = "11:47"
            }
            if endtimeRadios[2]! {
                PostShiftvar.Static.endtime[0] = "11:49"
                PostShiftvar.Static.endtime[1] = "11:49"
            }
            if endtimeRadios[3]! {
                PostShiftvar.Static.endtime[0] = "23:51"
                PostShiftvar.Static.endtime[1] = "23:51"
            }
            if endtimeRadios[4]! {
                PostShiftvar.Static.endtime[0] = "23:53"
                PostShiftvar.Static.endtime[1] = "23:53"
            }
            var selected = false
            for i in 1...4 {if endtimeRadios[i] == true {selected = true}}
            if selected == false {
                print("Select Partial option: Notification")
                
                showtoast = true
                toastmessage = "Select Partial option"
            }
            
        }
        else{
            if endtimeFalselabel[1].label.text! == "0h:0m" {
                print("Select EndTime: Notification")
                showtoast = true
                toastmessage = "Select EndTime"
            }
            else{
                PostShiftvar.Static.endtime[0] = endtimeFalselabel[1].label.text!
                PostShiftvar.Static.endtime[1] = endtimeFalselabel[1].label.text!
            }
        }
        
        ///////////////////////////////////// Validation end
        var ret = false
        if showtoast {
            toast.Toastmessage(y: y-150, toastmessage, txtColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bkColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), fontsize: 18, view: view)
        }
        else{ret = true}
        
        
        return ret
    }
    
    
    
    
    
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func starttimeSwitchButton(_ btn:UISwitch){
        if btn.isOn {
            starttimeTrue.view.isHidden = false
            starttimeFalse.view.isHidden = true
        }
        else{
            starttimeTrue.view.isHidden = true
            starttimeFalse.view.isHidden = false
        }
        onClickLayoutUpdater()
    }
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func endtimeSwitchButton(_ btn:UISwitch){
        if btn.isOn {
            endtimeTrue.view.isHidden = false
            endtimeFalse.view.isHidden = true
        }
        else{
            endtimeTrue.view.isHidden = true
            endtimeFalse.view.isHidden = false
        }
        onClickLayoutUpdater()
    }


    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    let departmentScroll = UI2()
    var departmentlist:[UI2] = []
    @objc func selectDepartmentButton(_ tap:UITapGestureRecognizer){
        print("select department button")
        
        // create departmentList
        addDepartmentListDynamic(mainlineDepartments: (dataSource.data?.mainlineDepartments?.map({$0.name}))!,
                                 regionalDepartments: (dataSource.data?.regionalDepartments?.map({$0.name}))!)
        
    }
    
    ////////////// addDepartmentList dynamically userinterface
    func addDepartmentListDynamic(mainlineDepartments:Any,regionalDepartments:Any) {
        departmentScroll.View(x: 0, y: 0, width: x, height: y, bkcolor: .clear, cornerRadius: 0, border: 0, borderColor: .clear, view: view)
        departmentScroll.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidelist(_:))))
        departmentScroll.ScrollView(x: 30, y: 200, width: x-60, height: y-200, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), contentwidth: x-60, contentheight: y-200, view: departmentScroll.view)
        departmentScroll.view.isHidden = false
        body.scrollview.contentOffset.y = department.view.frame.minY-100
        
        
        // create dynamic list
        var index = 0,listy = 0
        
        departmentlist.append(UI2())
        departmentlist[index].Button(x: 0, y: CGFloat(listy), width: x-60, height: 40, title: "MainLine Departments", any: self, function: #selector(selectlist(btn:)), fontsize: 22, cornerRadius: 0, bordercolor: UIColor.clear.cgColor, bkcolor: UIColor.clear.cgColor, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: departmentScroll.scrollview)
        departmentlist[index].button.tag = index
        departmentScroll.scrollview.contentSize.height = departmentlist[index].button.frame.maxY
        listy+=45
        index+=1
        for i in mainlineDepartments as! [String] {
            departmentlist.append(UI2())
            departmentlist[index].Button(x: 0, y: CGFloat(listy), width: x-60, height: 40, title: "\(i)", any: self, function: #selector(selectlist(btn:)), fontsize: 16, cornerRadius: 0, bordercolor: UIColor.clear.cgColor, bkcolor: UIColor.clear.cgColor, txtcolor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), view: departmentScroll.scrollview)
            departmentlist[index].button.tag = index
            departmentScroll.scrollview.contentSize.height = departmentlist[index].button.frame.maxY
            listy+=45
            index+=1
        }
        
        departmentlist.append(UI2())
        departmentlist[index].Button(x: 0, y: CGFloat(listy), width: x-60, height: 40, title: "Regional Departments", any: self, function: #selector(selectlist(btn:)), fontsize: 22, cornerRadius: 0, bordercolor: UIColor.clear.cgColor, bkcolor: UIColor.clear.cgColor, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: departmentScroll.scrollview)
        departmentlist[index].button.tag = index
        departmentScroll.scrollview.contentSize.height = departmentlist[index].button.frame.maxY
        listy+=45
        index+=1
        
        for i in regionalDepartments as! [String] {
            departmentlist.append(UI2())
            departmentlist[index].Button(x: 0, y: CGFloat(listy), width: x-60, height: 40, title: "\(i)", any: self, function: #selector(selectlist(btn:)), fontsize: 16, cornerRadius: 0, bordercolor: UIColor.clear.cgColor, bkcolor: UIColor.clear.cgColor, txtcolor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), view: departmentScroll.scrollview)
            departmentlist[index].button.tag = index
            departmentScroll.scrollview.contentSize.height = departmentlist[index].button.frame.maxY
            listy+=45
            index+=1
        }
    }
    
    ///////////////////////////////////////////
    
    @objc func hidelist(_ tap:UITapGestureRecognizer){
        departmentScroll.view.isHidden = true
        departmentlist.removeAll()
    }
    @objc func selectlist(btn:UIButton){
        departmentScroll.view.isHidden = true
        departmentlist.removeAll()
        departmentlabel.label.text = btn.titleLabel!.text!
    }
    

    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func SelectStartTimeButton(_ tap:UITapGestureRecognizer){
        print("select starttime button")
        startTimePicker(id: tap.view!.tag)
    }
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func SelectEndTimeButton(_ tap:UITapGestureRecognizer){
        print("select endtime button")
        startTimePicker(id: tap.view!.tag)
    }






    func starttimeSelcted_or_unSelected() {
        //is off
        starttimeFalse.View(x: 30, y: starttime.label.frame.maxY+10, width: x-60, height: 50, bkcolor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), cornerRadius: 20, border: 0, borderColor: .clear, view: body.scrollview)
        starttimeFalse.view.tag = 1
        starttimeFalse.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectStartTimeButton(_:)) ))
        starttimeFalselabel[0].Label(x: 20, y: 0, width: (x-100)/2, height: 50, txt: "Select Start Time", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: starttimeFalse.view)
        
        starttimeFalselabel[1].Label(x: starttimeFalselabel[0].label.frame.maxX, y: 0, width: (x-100)/2, height: 50, txt: "0h:0m", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: starttimeFalse.view)

        //is ON
        starttimeTrue.View(x: 30, y: starttime.label.frame.maxY+10, width: x-60, height: 150, bkcolor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), cornerRadius: 20, border: 0, borderColor: .clear, view: body.scrollview)
        starttimeTrue.view.isHidden = true
        starttimeTruelabel[0].Label(x: 10, y: 10, width: x-80, height: 75, txt: "Partial times are not the exact same for every shift. Therefore, to enter a partial shift, you must enter shift start or end thime that is standard and known", fontsize: 14, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), view: starttimeTrue.view)
        starttimeTruelabel[1].Radio(x: 10, y: starttimeTruelabel[0].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 1, view: starttimeTrue.view)
        starttimeTruelabel[1].Label(x: starttimeTruelabel[1].radio.frame.maxX+5, y: starttimeTruelabel[0].label.frame.maxY+10, width: 160, height: 25, txt: "AM Front End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: starttimeTrue.view)

        starttimeTruelabel[2].Radio(x: 10, y: starttimeTruelabel[1].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 1, view: starttimeTrue.view)
        starttimeTruelabel[2].Label(x: starttimeTruelabel[2].radio.frame.maxX+5, y: starttimeTruelabel[1].label.frame.maxY+10, width: 160, height: 25, txt: "AM Back End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: starttimeTrue.view)

        starttimeTruelabel[3].Radio(x: 10, y: starttimeTruelabel[2].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 1, view: starttimeTrue.view)
        starttimeTruelabel[3].Label(x: starttimeTruelabel[3].radio.frame.maxX+5, y: starttimeTruelabel[2].label.frame.maxY+10, width: 160, height: 25, txt: "PM Front End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: starttimeTrue.view)

        starttimeTruelabel[4].Radio(x: 10, y: starttimeTruelabel[3].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 1, view: starttimeTrue.view)
        starttimeTruelabel[4].Label(x: starttimeTruelabel[4].radio.frame.maxX+5, y: starttimeTruelabel[3].label.frame.maxY+10, width: 160, height: 25, txt: "PM Back End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: starttimeTrue.view)

        starttimeTrue.view.frame.size.height = starttimeTruelabel[4].radio.frame.maxY+60 - starttimeTrue.view.frame.minX
    }
    
    
    
    

    func endtimeSelcted_or_unSelected() {
        //is off
        endtimeFalse.View(x: 30, y: endtime.label.frame.maxY+10, width: x-60, height: 50, bkcolor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), cornerRadius: 20, border: 0, borderColor: .clear, view: body.scrollview)
        endtimeFalse.view.tag = 2
        endtimeFalse.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectEndTimeButton(_:)) ))
        endtimeFalselabel[0].Label(x: 20, y: 0, width: (x-100)/2, height: 50, txt: "Select End Time", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: endtimeFalse.view)
        endtimeFalselabel[1].Label(x: endtimeFalselabel[0].label.frame.maxX, y: 0, width: (x-100)/2, height: 50, txt: "0h:0m", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: endtimeFalse.view)
        //is ON
        endtimeTrue.View(x: 30, y: endtime.label.frame.maxY+10, width: x-60, height: 150, bkcolor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), cornerRadius: 20, border: 0, borderColor: .clear, view: body.scrollview)
        endtimeTrue.view.isHidden = true
        endtimeTruelabel[0].Label(x: 10, y: 10, width: x-80, height: 75, txt: "Partial times are not the exact same for every shift. Therefore, to enter a partial shift, you must enter shift start or end thime that is standard and known", fontsize: 14, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), view: endtimeTrue.view)
        endtimeTruelabel[1].Radio(x: 10, y: endtimeTruelabel[0].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 2, view: endtimeTrue.view)
        endtimeTruelabel[1].Label(x: endtimeTruelabel[1].radio.frame.maxX+5, y: endtimeTruelabel[0].label.frame.maxY+10, width: 160, height: 25, txt: "AM Front End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: endtimeTrue.view)

        endtimeTruelabel[2].Radio(x: 10, y: endtimeTruelabel[1].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 2, view: endtimeTrue.view)
        endtimeTruelabel[2].Label(x: endtimeTruelabel[2].radio.frame.maxX+5, y: endtimeTruelabel[1].label.frame.maxY+10, width: 160, height: 25, txt: "AM Back End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: endtimeTrue.view)

        endtimeTruelabel[3].Radio(x: 10, y: endtimeTruelabel[2].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 2, view: endtimeTrue.view)
        endtimeTruelabel[3].Label(x: endtimeTruelabel[3].radio.frame.maxX+5, y: endtimeTruelabel[2].label.frame.maxY+10, width: 160, height: 25, txt: "PM Front End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: endtimeTrue.view)

        endtimeTruelabel[4].Radio(x: 10, y: endtimeTruelabel[3].label.frame.maxY+10, width: 25, height: 25, isChecked: false, id: 2, view: endtimeTrue.view)
        endtimeTruelabel[4].Label(x: endtimeTruelabel[4].radio.frame.maxX+5, y: endtimeTruelabel[3].label.frame.maxY+10, width: 160, height: 25, txt: "PM Back End Partial", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: endtimeTrue.view)

        endtimeTrue.view.frame.size.height = endtimeTruelabel[4].radio.frame.maxY+60 - endtimeTrue.view.frame.minX
    }

    func selectDate_or_Day() {
        //select day
        daypicker.View(x: 30, y: check.checkbox.frame.maxY+10, width: x-60, height: 80, bkcolor: .clear, cornerRadius: 0, border: 0, borderColor: .clear, view: body.scrollview)
        daypicker.Label(x: 0, y: 0, width: 100, height: 30, txt: "Pick Day(s)", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: daypicker.view)
        var xpadding:CGFloat = 0
        for i in 0...6 {
           day[i].Button(x: xpadding, y: daypicker.label.frame.maxY+10, width: 40, height: 40, title: dayname[i], any: self, function: #selector(daypickerButton(_:)), fontsize: 16, cornerRadius: 20, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.7999292016, green: 0.8000452518, blue: 0.7999039292, alpha: 1).cgColor, txtcolor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), view: daypicker.view)
            xpadding+=40+((x-60-(40*7))/6)
            day[i].button.tag = i

        }
        // select date
        datepicker.View(x: 30, y: check.checkbox.frame.maxY+10, width: x-60, height: 240, bkcolor: UIColor.clear, cornerRadius: 0, border: 0, borderColor: .clear, view: body.scrollview)
        datepicker.Label(x: 0, y: 0, width: 100, height: 30, txt: "Select Date", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: datepicker.view)
        datepicker.DatePicker(x: 0, y: 0, width: x-60, height: 200, bkcolor: UIColor.clear, mode: .date, formatisDate: true, view: datepicker.view)

    }
    @objc func daypickerButton(_ btn:UIButton){
        if btn.backgroundColor == #colorLiteral(red: 0.8522390723, green: 0.2041666806, blue: 0.193234235, alpha: 1) {
            btn.backgroundColor = #colorLiteral(red: 0.7999292016, green: 0.8000452518, blue: 0.7999039292, alpha: 1)
            btn.tintColor = #colorLiteral(red: 0.8522390723, green: 0.2041666806, blue: 0.193234235, alpha: 1)
            daynameSelect[btn.tag] = false

        }
        else{
            btn.backgroundColor = #colorLiteral(red: 0.8522390723, green: 0.2041666806, blue: 0.193234235, alpha: 1)
            btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            daynameSelect[btn.tag] = true
        }
    }

    func selectDate_or_Day_Change() {
        if checkboxonClick.isChecked {
            daypicker.view.isHidden = false
            datepicker.view.isHidden = true
        }
        else{
            datepicker.view.isHidden = false
            daypicker.view.isHidden = true
        }
        onClickLayoutUpdater()
    }

    ////////////////////////////////// Start Time Funciton update
    func startTimeRadiobuttonUpdater() {
        if starttimeTruelabel[1].isRadioSelected != starttimeRadios[1] {
            starttimeRadios[1] = true
            starttimeRadios[2] = false
            starttimeRadios[3] = false
            starttimeRadios[4] = false
            starttimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            starttimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[1].isRadioSelected = true
            starttimeTruelabel[2].isRadioSelected = false
            starttimeTruelabel[3].isRadioSelected = false
            starttimeTruelabel[4].isRadioSelected = false

        }
        else if starttimeTruelabel[2].isRadioSelected != starttimeRadios[2] {
            starttimeRadios[1] = false
            starttimeRadios[2] = true
            starttimeRadios[3] = false
            starttimeRadios[4] = false
            starttimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            starttimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[1].isRadioSelected = false
            starttimeTruelabel[2].isRadioSelected = true
            starttimeTruelabel[3].isRadioSelected = false
            starttimeTruelabel[4].isRadioSelected = false

        }
        else if starttimeTruelabel[3].isRadioSelected != starttimeRadios[3] {
            starttimeRadios[1] = false
            starttimeRadios[2] = false
            starttimeRadios[3] = true
            starttimeRadios[4] = false
            starttimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            starttimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[1].isRadioSelected = false
            starttimeTruelabel[2].isRadioSelected = false
            starttimeTruelabel[3].isRadioSelected = true
            starttimeTruelabel[4].isRadioSelected = false

        }
        else if starttimeTruelabel[4].isRadioSelected != starttimeRadios[4] {
            starttimeRadios[1] = false
            starttimeRadios[2] = false
            starttimeRadios[3] = false
            starttimeRadios[4] = true
            starttimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            starttimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            starttimeTruelabel[1].isRadioSelected = false
            starttimeTruelabel[2].isRadioSelected = false
            starttimeTruelabel[3].isRadioSelected = false
            starttimeTruelabel[4].isRadioSelected = true

        }
    }



    ////////////////////////////////// End Time Funciton update
    func endTimeRadiobuttonUpdater() {
        if endtimeTruelabel[1].isRadioSelected != endtimeRadios[1] {
            endtimeRadios[1] = true
            endtimeRadios[2] = false
            endtimeRadios[3] = false
            endtimeRadios[4] = false
            endtimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            endtimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[1].isRadioSelected = true
            endtimeTruelabel[2].isRadioSelected = false
            endtimeTruelabel[3].isRadioSelected = false
            endtimeTruelabel[4].isRadioSelected = false

        }
        else if endtimeTruelabel[2].isRadioSelected != endtimeRadios[2] {
            endtimeRadios[1] = false
            endtimeRadios[2] = true
            endtimeRadios[3] = false
            endtimeRadios[4] = false
            endtimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            endtimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[1].isRadioSelected = false
            endtimeTruelabel[2].isRadioSelected = true
            endtimeTruelabel[3].isRadioSelected = false
            endtimeTruelabel[4].isRadioSelected = false

        }
        else if endtimeTruelabel[3].isRadioSelected != endtimeRadios[3] {
            endtimeRadios[1] = false
            endtimeRadios[2] = false
            endtimeRadios[3] = true
            endtimeRadios[4] = false
            endtimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            endtimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[1].isRadioSelected = false
            endtimeTruelabel[2].isRadioSelected = false
            endtimeTruelabel[3].isRadioSelected = true
            endtimeTruelabel[4].isRadioSelected = false

        }
        else if endtimeTruelabel[4].isRadioSelected != endtimeRadios[4] {
            endtimeRadios[1] = false
            endtimeRadios[2] = false
            endtimeRadios[3] = false
            endtimeRadios[4] = true
            endtimeTruelabel[1].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[2].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[3].radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            endtimeTruelabel[4].radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            endtimeTruelabel[1].isRadioSelected = false
            endtimeTruelabel[2].isRadioSelected = false
            endtimeTruelabel[3].isRadioSelected = false
            endtimeTruelabel[4].isRadioSelected = true

        }
    }



    //////////////////////////////////////
    //////////////////////////////////////
    // Start Time picker
    //////////////////////////////////////
    //////////////////////////////////////

    func startTimePicker(id:Int){
        starttimepicker.View(x: 0, y: 0, width: x, height: y, bkcolor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0), cornerRadius: 0, border: 0, borderColor: .clear, view: view)
        starttimepicker.view.isHidden = false
        starttimepicker.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideStartTimePicker(_:))))
        UIView.animate(withDuration: 0.3) {
            self.starttimepicker.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        }
        starttimelabel.View(x: x/2 - 150, y: y/2 - 155, width: 300, height: 300, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 0, border: 1, borderColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), view: starttimepicker.view)
        starttimepicker.DatePicker(x: 0, y: 50, width: 300, height: 200, bkcolor: .clear, mode: .time, formatisDate: false, view: starttimelabel.view)
        starttimelabel.Label(x: 0, y: 0, width: 300, height: 50, txt: starttimepicker.selectedDate, fontsize: 16, bold: true, cornerRadius: 0, border: 1, borderColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), view: starttimelabel.view)
        starttimebutton[0].Button(x: 0, y: 250, width: 150, height: 50, title: "Cancle", any: self, function: #selector(startTimePickerCancle(_:)), fontsize: 16, cornerRadius: 0, bordercolor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), view: starttimelabel.view)
        starttimebutton[1].Button(x: 150, y: 250, width: 150, height: 50, title: "OK", any: self, function: #selector(OkStartTimePicker(_:)), fontsize: 16, cornerRadius: 0, bordercolor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), view: starttimelabel.view)
        starttimebutton[1].button.tag = id
    }
    @objc func startTimePickerCancle(_ btn:UIButton){
        starttimepicker.view.isHidden = true
    }
    @objc func hideStartTimePicker(_ tap:UITapGestureRecognizer){
        starttimepicker.view.isHidden = true
    }
    @objc func OkStartTimePicker(_ btn:UIButton){
        if btn.tag == 1 {
            starttimeFalselabel[1].label.text = starttimepicker.selectedDate
            print("one")
        }
        if btn.tag == 2 {
            endtimeFalselabel[1].label.text = starttimepicker.selectedDate
            print("two")
        }
        starttimepicker.view.isHidden = true

    }

    ////////////////////////////////// Layout Update Funciton

    func onClickLayoutUpdater() {
        if daypicker.view.isHidden == false {
            line1.view.frame.origin.y = daypicker.view.frame.maxY+10
        }
        else{line1.view.frame.origin.y = datepicker.view.frame.maxY+10}
        two.label.frame.origin.y = line1.view.frame.maxY+10
        twolabel.label.frame.origin.y = line1.view.frame.maxY+10
        department.label.frame.origin.y = two.label.frame.maxY+10
        department.view.frame.origin.y = department.label.frame.maxY+10
        line2.view.frame.origin.y = department.view.frame.maxY+10
        three.label.frame.origin.y = line2.view.frame.maxY+10
        threelabel.label.frame.origin.y = line2.view.frame.maxY+10
        starttime.label.frame.origin.y = three.label.frame.maxY+10
        starttime.Switch.frame.origin.y = three.label.frame.maxY+10
        starttimeTrue.view.frame.origin.y = starttime.label.frame.maxY+10
        starttimeFalse.view.frame.origin.y = starttime.label.frame.maxY+10
        if starttimeFalse.view.isHidden == false {
            endtime.label.frame.origin.y = starttimeFalse.view.frame.maxY+10
            endtime.Switch.frame.origin.y = starttimeFalse.view.frame.maxY+10
        }
        else{
            endtime.label.frame.origin.y = starttimeTrue.view.frame.maxY+10
            endtime.Switch.frame.origin.y = starttimeTrue.view.frame.maxY+10
        }
        endtimeTrue.view.frame.origin.y = endtime.label.frame.maxY+10
        endtimeFalse.view.frame.origin.y = endtime.label.frame.maxY+10
        if endtimeFalse.view.isHidden == false {
            note.label.frame.origin.y = endtimeFalse.view.frame.maxY+10
        }
        else{note.label.frame.origin.y = endtimeTrue.view.frame.maxY+10}
        line3.view.frame.origin.y = note.label.frame.maxY+10
        body.scrollview.contentSize.height = line3.view.frame.maxY+10
    }



}

























































//////////////////////////////////////
//////////////////////////////////////
// UI Elements
//////////////////////////////////////
//////////////////////////////////////




class checkboxonClick {
    static var function:()->() = {}
    static var isChecked:Bool = false
}
class radiobuttonClick {
    static var startTimefunction:()->() = {}
    static var endTimefunction:()->() = {}
}
class UI1: UIView {

    /*Variable declaration*/
    let view = UIView.init()
    let scrollview = UIScrollView.init()
    let clickableimg = UIButton.init()
    let button = UIButton.init(type: UIButton.ButtonType.roundedRect)
    let label = UILabel()
    let imag = UIImageView()
    let checkbox = UIButton.init()
    let datePicker = UIDatePicker()
    var selectedDate: String = ""
    private var datePickerFormat = "yyyy-MM-dd"
    private var timePickerFormat = "HH:mm"
    private var datepick = false
    let Switch = UISwitch()
    let radio = UIButton.init()
    var isRadioSelected = false
    let toastmsg = UILabel()


    func Toastmessage(y:CGFloat,_ Text:String,txtColor:UIColor,bkColor:UIColor,fontsize:CGFloat,view:UIView) {
        toastmsg.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0.5, options: [], animations: {
            self.toastmsg.alpha = 1
        })
        
        toastmsg.text = Text
        toastmsg.textColor = txtColor
        toastmsg.backgroundColor = bkColor
        toastmsg.layer.cornerRadius = 20
        toastmsg.numberOfLines = 10
        toastmsg.layer.masksToBounds = true
        toastmsg.font = UIFont.systemFont(ofSize: fontsize)
        toastmsg.textAlignment = .center
        toastmsg.sizeToFit()
        if toastmsg.frame.size.width > (view.frame.size.width - 20) {
            toastmsg.frame.size.width = view.frame.size.width - 20
            toastmsg.sizeToFit()
        }
        else{
            toastmsg.frame.size.width = toastmsg.frame.size.width + 20
        }
        toastmsg.frame.size.height = toastmsg.frame.size.height + 20
        toastmsg.frame.origin.x = view.frame.midX - toastmsg.frame.size.width/2
        toastmsg.frame.origin.y = y
        view.addSubview(toastmsg)
        view.bringSubviewToFront(toastmsg)
        
        time.delay(milliSec: 2500) {
            UIView.animate(withDuration: 1) {self.toastmsg.alpha = 0}
            time.delay(milliSec: 1000, code: {self.toastmsg.removeFromSuperview()})
        }
        
    }
    ////////////////////////////////////////////////
    func View(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, bkcolor:UIColor,cornerRadius:CGFloat,border:CGFloat,borderColor:UIColor, view:UIView){
        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
        self.view.backgroundColor = bkcolor
        self.view.layer.cornerRadius = cornerRadius
        self.view.layer.borderWidth = border
        self.view.layer.borderColor = borderColor.cgColor
        view.addSubview(self.view)

    }
    ////////////////////////////////////////////////
    func ScrollView(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, bkcolor:UIColor, contentwidth:CGFloat, contentheight:CGFloat, view:UIView) {
        scrollview.frame = CGRect(x: x, y: y, width: width, height: height)
        scrollview.backgroundColor = bkcolor
        scrollview.contentSize.width = contentwidth
        scrollview.contentSize.height = contentheight
        view.addSubview(scrollview)
    }
    ////////////////////////////////////////////////
    func clickableimage(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat,image: UIImage?, function:Selector, any:Any, view:UIView ) {
        clickableimg.setBackgroundImage(image, for: .normal)
        clickableimg.frame = CGRect(x: x, y: y, width: width, height: height)
        clickableimg.addTarget(any, action: function, for: .touchUpInside)
        view.addSubview(clickableimg)
    }
    ////////////////////////////////////////////////
    func Button(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, title:String, any: Any, function:Selector,fontsize:CGFloat,cornerRadius:CGFloat, bordercolor:CGColor, bkcolor:CGColor, txtcolor:UIColor, view:UIView) {
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.setTitle(title, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = bordercolor
        button.layer.backgroundColor = bkcolor
        button.layer.cornerRadius = cornerRadius
        button.addTarget(any, action: function, for: .touchUpInside)
        button.tintColor = txtcolor
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontsize)
        view.addSubview(button)
    }
    ////////////////////////////////////////////////
    func Label(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, txt:String, fontsize:CGFloat, bold:Bool, cornerRadius:CGFloat,border:CGFloat,borderColor:CGColor, alignment:NSTextAlignment, bkcolor:UIColor, txtcolor:UIColor, view:UIView) {
           label.frame = CGRect(x: x, y: y, width: width, height: height)
           label.backgroundColor = bkcolor
           label.text = txt
           label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = cornerRadius;
        label.layer.borderColor = borderColor;
        label.layer.borderWidth = border;
        if bold {label.font = .boldSystemFont(ofSize: fontsize)}
        else{label.font = UIFont.systemFont(ofSize: fontsize)}
           label.textColor = txtcolor
           label.textAlignment = alignment
           view.addSubview(label)
       }
       ////////////////////////////////////////////////
    func Image(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat, src: String, view:UIView){
        imag.image = UIImage(named: src)
        imag.frame = CGRect(x: x, y: y, width: width, height: height)
        view.addSubview(imag)

    }

    ////////////////////////////////////////////////
    // dependent on class 'checkboxonClick'
    func checkBox(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,isChecked:Bool,view:UIView) {
        checkbox.frame = CGRect(x: x, y: y, width: width, height: height)
        if isChecked==true {
            checkbox.setBackgroundImage(UIImage(named: "checkboxTrue"), for: .normal)
        }
        else{
            checkbox.setBackgroundImage(UIImage(named: "checkboxFalse"), for: .normal)
        }
        checkbox.addTarget(self, action: #selector(checkboxClick(_btn:)), for: .touchUpInside)
        view.addSubview(checkbox)
    }
    @objc func checkboxClick(_btn:UIButton){
        if checkboxonClick.isChecked == true {
            checkbox.setBackgroundImage(UIImage(named: "checkboxFalse"), for: .normal)
            checkboxonClick.isChecked=false
        }
        else{
            checkbox.setBackgroundImage(UIImage(named: "checkboxTrue"), for: .normal)
            checkboxonClick.isChecked=true
        }
        checkboxonClick.function()
    }

    ////////////////////////////////////////////////
    func DatePicker(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,bkcolor:UIColor,mode:UIDatePicker.Mode,formatisDate:Bool,view:UIView) {
        datePicker.frame = CGRect(x: x, y: y, width: width, height: height)
        datePicker.timeZone = NSTimeZone.local
        datePicker.datePickerMode = mode
        datePicker.backgroundColor = bkcolor
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)

        let dateFormatter: DateFormatter = DateFormatter()

        if formatisDate {
            self.datepick = true
            dateFormatter.dateFormat = datePickerFormat
        }
        else{
            dateFormatter.dateFormat = timePickerFormat
            datePicker.minuteInterval = 15
            //For 24 Hrs
//                        datePicker.locale = Locale(identifier: "en_GB")
                        //For 12 Hrs
            //            datePicker.locale = Locale(identifier: "en_US")
        }

        selectedDate = dateFormatter.string(from: datePicker.date)
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        // "MM/dd/yyyy hh:mm a"
        let dateFormatter: DateFormatter = DateFormatter()
        if datepick {
            dateFormatter.dateFormat = self.datePickerFormat
        }else{
            dateFormatter.dateFormat = self.timePickerFormat
            
        }
        selectedDate = dateFormatter.string(from: sender.date)
        print("\(selectedDate)")
    }

    ////////////////////////////////////////////////
    func Switch_(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,color:UIColor,onbkcolor:UIColor,view:UIView) {
        Switch.frame = CGRect(x: x, y: y, width: width, height: height)
        Switch.onTintColor = onbkcolor
        Switch.thumbTintColor = color
        view.addSubview(Switch)
    }

    ////////////////////////////////////////////////
    func Radio(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,isChecked:Bool,id:Int,view:UIView) {
        radio.frame = CGRect(x: x, y: y, width: width, height: height)
        if isChecked==true {
            radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
        }
        else{
            radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
        }
        radio.tag = id
        radio.addTarget(self, action: #selector(radioButtonClick(_:)), for: .touchUpInside)
        view.addSubview(radio)
    }
    @objc func radioButtonClick(_ btn:UIButton){
        if radio.currentBackgroundImage == UIImage(named: "radioTrue") {
            radio.setBackgroundImage(UIImage(named: "radioFalse"), for: .normal)
            isRadioSelected = false
        }
        else{
            radio.setBackgroundImage(UIImage(named: "radioTrue"), for: .normal)
            isRadioSelected = true
        }
        if btn.tag == 1 {radiobuttonClick.startTimefunction()}
        if btn.tag == 2 {radiobuttonClick.endTimefunction()}
    }

}
