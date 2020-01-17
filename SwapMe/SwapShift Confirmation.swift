//
//  ConfirmSwapDetail.swift
//  SwapMe
//
//  Created by Mr. Nabeel on 12/5/19.
//  Copyright © 2019 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SwapShiftConfirmation: UIViewController,UITextFieldDelegate {
    
    let x = UIScreen.main.bounds.size.width
    let y = UIScreen.main.bounds.size.height
    
    // for header
    let bkimage = UI4()
    let header = UI4()
    let menubtn = UI4()
    let notificationbtn = UI4()
    // for content
    let bodyscroll = UI4()
    let group = [UI4(),UI4()]
    let label = [UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4(),UI4()]
    let permanent = [UI4(),UI4()]
    let day = [UI4(),UI4()]
    var daynames:[String] = []
    var daynames1:[String] = []
    var departmentnames:[String] = []
    let date = [UI4(),UI4()]
    let department = [UI4(),UI4()]
    let startTime = [UI4(),UI4()]
    let endTime = [UI4(),UI4()]
    let deleteShift = UI2()
    let deleteShiftlable = [UI2(),UI2()]
    // for footer
    let backbtn = UI4()
    let findbtn = UI4()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Header
        //////////////////////////////////////
        //////////////////////////////////////
        
        bkimage.Backgroundimage(src: "bk2", view: view)
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
        
        group[0].View(x: 20, y: label[0].label.frame.maxY, width: x-40, height: (30*7)+20, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 20, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        group[1].View(x: 20, y: group[0].view.frame.maxY+10, width: x-40, height: (30*7)+20, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: 20, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        // 1st goroup label
        label[1].Label(x: 10, y: 10, width: 80, height: 30, txt: "Your Shift:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        label[2].Label(x: 10, y: label[1].label.frame.maxY, width: 100, height: 30, txt: "-Permanent:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        permanent[0].Label(x: label[2].label.frame.maxX, y: label[1].label.frame.maxY, width: 200, height: 30, txt: "\(PostShiftvar.Static.permanent)", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        
        label[3].Label(x: 10, y: label[2].label.frame.maxY, width: 65, height: 30, txt: "-Day(s):", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        day[0].ScrollView(x: label[3].label.frame.maxX, y: label[2].label.frame.maxY, width: group[0].view.frame.size.width-label[3].label.frame.size.width-20, height: 30, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), contentwidth: group[0].view.frame.size.width, contentheight: 30, view: group[0].view)
        var d = ""
        for a in PostShiftvar.Static.days {
            d+="'"+a+"'  ";
            daynames.append(a);
        }
        day[0].AutoSizeLabel(x: 0, y: 0, height: 30, txt: d, fontsize: 18, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 0, view: day[0].scrollview)
        day[0].scrollview.contentSize.width = day[0].autoSizelabel.frame.size.width
        
        
        label[4].Label(x: 10, y: label[3].label.frame.maxY, width: 55, height: 30, txt: "-Date:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        date[0].Label(x: label[4].label.frame.maxX, y: label[3].label.frame.maxY, width: 200, height: 30, txt: PostShiftvar.Static.date, fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        
        label[5].Label(x: 10, y: label[4].label.frame.maxY, width: 125, height: 30, txt: "-Department(s):", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        department[0].Label(x: label[5].label.frame.maxX, y: label[4].label.frame.maxY, width: 200, height: 30, txt: PostShiftvar.Static.departmentName, fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        label[6].Label(x: 10, y: label[5].label.frame.maxY, width: 90, height: 30, txt: "-Start time:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        startTime[0].Label(x: label[6].label.frame.maxX, y: label[5].label.frame.maxY, width: 200, height: 30, txt: "\(PostShiftvar.Static.starttime[0])-\(PostShiftvar.Static.starttime[1])", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        label[7].Label(x: 10, y: label[6].label.frame.maxY, width: 80, height: 30, txt: "-End time:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        endTime[0].Label(x: label[7].label.frame.maxX, y: label[6].label.frame.maxY, width: 200, height: 30, txt: "\(PostShiftvar.Static.starttime[0])-\(PostShiftvar.Static.starttime[1])", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[0].view)
        
        
        
        
        
        
        
        
        // 2nd goroup label
        label[8].Label(x: 10, y: 10, width: 80, height: 30, txt: "Swap with:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        
        label[9].Label(x: 10, y: label[1].label.frame.maxY, width: 100, height: 30, txt: "-Permanent:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        permanent[1].Label(x: label[2].label.frame.maxX, y: label[1].label.frame.maxY, width: 200, height: 30, txt: "\(PickupShiftvar.Static.permanent)", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        
        label[10].Label(x: 10, y: label[9].label.frame.maxY, width: 65, height: 30, txt: "-Day(s):", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        day[1].ScrollView(x: label[10].label.frame.maxX, y: label[9].label.frame.maxY, width: group[1].view.frame.size.width-label[10].label.frame.size.width-20, height: 30, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), contentwidth: group[1].view.frame.size.width, contentheight: 30, view: group[1].view)
        var d1 = ""
        for a1 in PickupShiftvar.Static.days {
            d1+="'"+a1+"'  ";
            daynames1.append(a1);
        }
        print(daynames1)
        day[1].AutoSizeLabel(x: 0, y: 0, height: 30, txt: d1, fontsize: 18, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 0, view: day[1].scrollview)
        day[1].scrollview.contentSize.width = day[1].autoSizelabel.frame.size.width

        label[11].Label(x: 10, y: label[10].label.frame.maxY, width: 55, height: 30, txt: "-Date:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        date[1].Label(x: label[4].label.frame.maxX, y: label[3].label.frame.maxY, width: 200, height: 30, txt: PickupShiftvar.Static.date, fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)

        label[12].Label(x: 10, y: label[11].label.frame.maxY, width: 125, height: 30, txt: "-Department(s):", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        department[1].Label(x: label[5].label.frame.maxX, y: label[4].label.frame.maxY, width: 200, height: 30, txt: "...", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        department[1].ScrollView(x: label[5].label.frame.maxX, y: label[4].label.frame.maxY, width: group[1].view.frame.size.width-label[5].label.frame.size.width-20, height: 30, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), contentwidth: group[1].view.frame.size.width, contentheight: 30, view: group[1].view)
        var d3 = ""
        for a3 in PickupShiftvar.Static.departmentName {
            d3+="'"+a3+"'  ";
            departmentnames.append(a3);
        }
        print(daynames1)
        department[1].AutoSizeLabel(x: 0, y: 0, height: 30, txt: d3, fontsize: 18, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 0, view: department[1].scrollview)
        department[1].scrollview.contentSize.width  = department[1].autoSizelabel.frame.size.width
        
        label[13].Label(x: 10, y: label[12].label.frame.maxY, width: 90, height: 30, txt: "-Start time:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        startTime[1].Label(x: label[6].label.frame.maxX, y: label[5].label.frame.maxY, width: 200, height: 30, txt: "\(PickupShiftvar.Static.starttime[0])-\(PickupShiftvar.Static.starttime[1])", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)

        label[14].Label(x: 10, y: label[13].label.frame.maxY, width: 80, height: 30, txt: "-End time:", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)
        endTime[1].Label(x: label[7].label.frame.maxX, y: label[6].label.frame.maxY, width: 200, height: 30, txt: "\(PickupShiftvar.Static.endtime[0])-\(PickupShiftvar.Static.endtime[1])", fontsize: 16, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: group[1].view)

        // delete shift
        deleteShift.View(x: 20, y: group[1].view.frame.maxY+10, width: x-40, height: 50, bkcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cornerRadius: 20, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        deleteShiftlable[0].Label(x: 10, y: 0, width: 230, height: 50, txt: "Delete This Shift Request After", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: deleteShift.view)
        deleteShift.Textfield(x: deleteShift.view.frame.maxX-145, y: 0, width: 50, height: 50, placeholder: "", border: 0, borderRadius: 0, txtAlign: .center, bordercolor: UIColor.clear.cgColor, keyboard: .numberPad, textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bkcolor: UIColor.clear.cgColor, view: deleteShift.view)
        if deleteShiftlable[0].label.frame.maxX > deleteShift.txtfield.frame.minX {
            deleteShiftlable[0].label.frame.size.width = deleteShift.txtfield.frame.minX-deleteShift.view.frame.minX+20
        }
        deleteShiftlable[1].Label(x: deleteShift.view.frame.maxX-90, y: 0, width: 60, height: 50, txt: "Days(s)", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: UIColor.clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: deleteShift.view)
        deleteShift.txtfield.text = "30"
        deleteShiftlable[0].View(x: deleteShift.txtfield.frame.minX, y: deleteShift.txtfield.frame.maxY-10, width: deleteShift.txtfield.frame.size.width, height: 2, bkcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cornerRadius: 0, border: 0, borderColor: .clear, view: deleteShift.view)
        bodyscroll.scrollview.contentSize.height = deleteShift.view.frame.maxY
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Footer
        //////////////////////////////////////
        //////////////////////////////////////
        backbtn.Button(x: 40, y: y-120, width: 100, height: 50, title: "BACK", any: self, function: #selector(backButton(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: view)
        findbtn.Button(x: x-180, y: y-120, width: 150, height: 50, title: "FIND MY MATCH", any: self, function: #selector(findButton(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: view)
        
            /////////////////////////////////////////////////
            ////////  KeyBoard
            ////////////////////////////////////////////////
         /// hide keyboard when click on view (outside of textfield)
        bodyscroll.scrollview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TaponView(_:))))
        
        //////////////////////////////////////
        //////////////////////////////////////
        // keyboard will hide / show
        //////////////////////////////////////
        //////////////////////////////////////
        deleteShift.txtfield.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillshow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillhide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
        ////////////// Hide Keyboard
           @objc func TaponView(_: UITapGestureRecognizer){
            bodyscroll.scrollview.endEditing(true)
           }
    
    //////////////////////////////////////
    //////////////////////////////////////
    // keyboard will hide / show
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func keyboardwillshow(noti:NSNotification){
        print("show")
    }
    @objc func keyboardwillhide(noti:NSNotification){
        print("hide")
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
        SwapShiftApi()
    }
    
    
    
    func SwapShiftApi(){
        
        print("-----------------------------------------")
        print("nabeel is here DetailSwapViewController")
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        // Your Shift
        var perama:String! = "0"
        if(PostShiftvar.Static.permanent){perama = "1"}
        else{perama = "0"}
        
        var days = ""
        for d in PostShiftvar.Static.days {days += d}
        
        let parameter1:[String:Any]?  = ["days":days,
                                         "date":PostShiftvar.Static.date,
                                         "departments":PostShiftvar.Static.departmentName,
                                         "start_time":PostShiftvar.Static.starttime[0],
                                         "end_time":PostShiftvar.Static.endtime[0]]
        
        
        // Desired Shift
        var peramaPick:String! = "0"
        if(PickupShiftvar.Static.permanent){peramaPick = "1"}
        else{peramaPick = "0"}
        
        var daysPick = ""
        for d in PickupShiftvar.Static.days {daysPick += d}
        
        let parameter2:[String:Any]?  = ["days":daysPick,
                                         "date":PickupShiftvar.Static.date,
                                         "departments":PickupShiftvar.Static.departmentName,
                                         "start_time":PickupShiftvar.Static.starttime[0]+"-"+PickupShiftvar.Static.starttime[1],
                                         "end_time":PickupShiftvar.Static.endtime[0]+"-"+PickupShiftvar.Static.endtime[1]]
        
       
        
        
        
        let url : String = "http://app.pyprentals.com/api/shifts/post/pickup"
        
        
        
//        let parameter:[String:Any]?  = ["is_permanent":perama!,
//                                        "trade_type":"0",
//                                        "trade_name":"Default trade",
//                                        "user_id":"237",
//                                        "post":parameter1!,
//                                        "pickup":parameter2!]
        let parameter:[String:Any]? = [
            "user_id":UserDefaults.standard.string(forKey:"uid")!,
            "is_permanent":perama!,
            "trade_type":0,
            "trade_name":"Default trade",
            "post[days]":days,
            "post[date]":PostShiftvar.Static.date,
            "post[department]":PostShiftvar.Static.departmentName,
            "post[start_time]":PostShiftvar.Static.starttime[0]+"-"+PostShiftvar.Static.starttime[1],
            "post[end_time]":PostShiftvar.Static.endtime[0]+"-"+PostShiftvar.Static.endtime[1],
            "pickup[days]":daysPick,
            "pickup[departments]":PickupShiftvar.Static.departmentName,
            "pickup[date]":PickupShiftvar.Static.date,
            "pickup[start_time]":PickupShiftvar.Static.starttime[0]+"-"+PickupShiftvar.Static.starttime[1],
            "pickup[end_time]":PickupShiftvar.Static.endtime[0]+"-"+PickupShiftvar.Static.endtime[1],
            "delete_after_days":deleteShift.txtfield.text!]
        
        let header: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        print(url)
        
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameter,
                          encoding:URLEncoding.default,
                          headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
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




































//////////////////////////////////////
//////////////////////////////////////
// UI Elements
//////////////////////////////////////
//////////////////////////////////////


class UI4: UIView {
    /*Variable declaration*/
    let view = UIView.init()
    let imag = UIImageView()
    let scrollview = UIScrollView.init()
    let clickableimg = UIButton.init()
    let label = UILabel()
    let button = UIButton.init(type: UIButton.ButtonType.roundedRect)
    let autoSizelabel = UILabel()
    
    
    
    
    
    func AutoSizeLabel(x:CGFloat,y:CGFloat,height:CGFloat,txt:String,fontsize:CGFloat,bkcolor:UIColor,txtcolor:UIColor,cornerRadius:CGFloat,view:UIView) {
        autoSizelabel.frame.origin = CGPoint(x: x, y: y)
        autoSizelabel.backgroundColor = bkcolor
        autoSizelabel.text = txt
        autoSizelabel.numberOfLines = 0
        autoSizelabel.font = UIFont.systemFont(ofSize: fontsize)
        autoSizelabel.textColor = txtcolor
        autoSizelabel.textAlignment = .center
        autoSizelabel.layer.cornerRadius = cornerRadius
        autoSizelabel.layer.masksToBounds = true
        autoSizelabel.sizeToFit()
        autoSizelabel.frame.size.width = autoSizelabel.frame.size.width + 20
        autoSizelabel.frame.size.height = height
        view.addSubview(autoSizelabel)
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
     func Backgroundimage(src:String ,view: UIView) {
           imag.image = UIImage(named: src)
           imag.contentMode = .scaleToFill
           imag.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(imag)
           
           
           imag.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           imag.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           imag.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           imag.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    ////////////////////////////////////////////////
    func Image(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat, src: String, view:UIView){
        imag.image = UIImage(named: src)
        imag.frame = CGRect(x: x, y: y, width: width, height: height)
        view.addSubview(imag)
        
    }
    ////////////////////////////////////////////////
    func clickableimage(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat,image: UIImage?, function:Selector, any:Any, view:UIView ) {
        clickableimg.setBackgroundImage(image, for: .normal)
        clickableimg.frame = CGRect(x: x, y: y, width: width, height: height)
        clickableimg.addTarget(any, action: function, for: .touchUpInside)
        view.addSubview(clickableimg)
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
    func ScrollView(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, bkcolor:UIColor, contentwidth:CGFloat, contentheight:CGFloat, view:UIView) {
        scrollview.frame = CGRect(x: x, y: y, width: width, height: height)
        scrollview.backgroundColor = bkcolor
        scrollview.contentSize.width = contentwidth
        scrollview.contentSize.height = contentheight
        view.addSubview(scrollview)
    }
}
