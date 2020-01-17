//
//  MyProfile.swift
//  SwapMe
//
//  Created by Mr. Nabeel on 12/5/19.
//  Copyright © 2019 Mr. Nabeel. All rights reserved.
//

import Foundation
import UIKit


class MyProfileViewController: UIViewController {
    
    
    let x = UIScreen.main.bounds.size.width
    let y = UIScreen.main.bounds.size.height
    
    // for header
    let bkimage = profileUI()
    let header = profileUI()
    let menubtn = profileUI()
    let notificationbtn = profileUI()
    let check = profileUI()
    
    // for content
    let bodyscroll = profileUI()
    let profileimage = profileUI()
    let username = profileUI()
    let phone = profileUI()
    let email = profileUI()
    let updatebtn = profileUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Header
        //////////////////////////////////////
        //////////////////////////////////////
        
        bkimage.Backgroundimage(src: "bk2", view: view)
        header.Image(x: 0, y: 0, width: x, height: 120, src: "header", view: view)
        header.Label(x: x/2 - 150, y: 45, width: 300, height: 40, txt: "Confirm Swap Details", fontsize: 22, bold: true, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .center, bkcolor: .clear, txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: view)
        menubtn.clickableimage(x: 30, y: 60, width: 20, height: 15, image: UIImage(named: "menuicon"), function: #selector(menuButton(_:)), any: self, view: view)
        notificationbtn.clickableimage(x: x-55, y: 55, width: 25, height: 30, image: UIImage(named: "notiicon"), function: #selector(notificationButton(_:)), any: self, view: view)
        
        
        //////////////////////////////////////
        //////////////////////////////////////
        // Content
        //////////////////////////////////////
        //////////////////////////////////////
        
        bodyscroll.ScrollView(x: 0, y: 120, width: x, height: y-120, bkcolor: UIColor.clear, contentwidth: x, contentheight: y, view: view)
        profileimage.Image(x: x/2 - 75, y: 10, width: 150, height: 150, src: "profile", view: bodyscroll.scrollview)
        profileimage.Button(x: x/2 - 75, y: profileimage.imag.frame.maxY+10, width: 150, height: 50, title: "Chnage photo", any: self, function: #selector(changephoto(_:)), fontsize: 16, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: bodyscroll.scrollview)
        check.CheckBox(x: 30, y: profileimage.button.frame.maxY+30, width: 25, height: 25, isChecked: false, id: 1, view: bodyscroll.scrollview)
        check.Label(x: 55, y: profileimage.button.frame.maxY+25, width: x-85, height: 50, txt: "Share my ocntact information with other users", fontsize: 16, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: bodyscroll.scrollview)
        // username
        username.Label(x: 30, y: check.label.frame.maxY, width: 150, height: 40, txt: "Username", fontsize: 22, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: bodyscroll.scrollview)
        username.Textfield(x: 30, y: username.label.frame.maxY, width: x-60, height: 40, placeholder: "Enter Username", border: 0, borderRadius: 0, txtAlign: .left, bordercolor: UIColor.clear.cgColor, keyboard: .default, textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bkcolor: UIColor.clear.cgColor, view: bodyscroll.scrollview)
        username.View(x: 30, y: username.txtfield.frame.maxY, width: x-60, height: 1, bkcolor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), cornerRadius: 0, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        
        // phone
        phone.Label(x: 30, y: username.view.frame.maxY, width: 150, height: 40, txt: "Phone", fontsize: 22, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: bodyscroll.scrollview)
        phone.Textfield(x: 30, y: phone.label.frame.maxY, width: x-60, height: 40, placeholder: "Enter Phone", border: 0, borderRadius: 0, txtAlign: .left, bordercolor: UIColor.clear.cgColor, keyboard: .default, textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bkcolor: UIColor.clear.cgColor, view: bodyscroll.scrollview)
        phone.View(x: 30, y: phone.txtfield.frame.maxY, width: x-60, height: 1, bkcolor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), cornerRadius: 0, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        
        // Email
        email.Label(x: 30, y: phone.view.frame.maxY, width: 150, height: 40, txt: "Email", fontsize: 22, bold: false, cornerRadius: 0, border: 0, borderColor: UIColor.clear.cgColor, alignment: .left, bkcolor: .clear, txtcolor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view: bodyscroll.scrollview)
        email.Textfield(x: 30, y: email.label.frame.maxY, width: x-60, height: 40, placeholder: "Enter Email Address", border: 0, borderRadius: 0, txtAlign: .left, bordercolor: UIColor.clear.cgColor, keyboard: .default, textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), bkcolor: UIColor.clear.cgColor, view: bodyscroll.scrollview)
        email.View(x: 30, y: email.txtfield.frame.maxY, width: x-60, height: 1, bkcolor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), cornerRadius: 0, border: 0, borderColor: .clear, view: bodyscroll.scrollview)
        
        // update button
        updatebtn.Button(x: 30, y: email.view.frame.maxY+50, width: x-60, height: 50, title: "UpDate", any: self, function: #selector(profileButton(_:)), fontsize: 22, cornerRadius: 15, bordercolor: UIColor.clear.cgColor, bkcolor: #colorLiteral(red: 0.5994448066, green: 0.8181087971, blue: 0.5273263454, alpha: 1), txtcolor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), view: bodyscroll.scrollview)
        
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
    @objc func changephoto(_ btn:UIButton){
        print("clicked changephoto button")
    }
    
    //////////////////////////////////////
    //////////////////////////////////////
    // Button
    //////////////////////////////////////
    //////////////////////////////////////
    @objc func profileButton(_ btn:UIButton){
        print("clicked profileButton button")
    }
    
    
    
}






class profileUI: UIView {
    /*Variable declaration*/
        let view = UIView.init()
        let imag = UIImageView()
        let scrollview = UIScrollView.init()
        let clickableimg = UIButton.init()
        let label = UILabel()
        let button = UIButton.init(type: UIButton.ButtonType.roundedRect)
    let checkbox = UIButton.init()
    var ischeckboxSelected = false
    let txtfield = UITextField.init()

    ////////////////////////////////////////////////
    func Textfield(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, placeholder:String,border:CGFloat,borderRadius:CGFloat,txtAlign:NSTextAlignment, bordercolor: CGColor,keyboard:UIKeyboardType,textColor:UIColor, bkcolor:CGColor, view:UIView ) {
        txtfield.frame = CGRect(x: x, y: y, width: width, height: height)
        txtfield.textAlignment = txtAlign
        txtfield.textColor = textColor
        txtfield.placeholder = placeholder
        txtfield.layer.borderWidth = border
        txtfield.layer.borderColor = bordercolor
        txtfield.layer.backgroundColor = bkcolor
        txtfield.layer.cornerRadius = borderRadius
        txtfield.keyboardType = keyboard
        view.addSubview(txtfield)
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
    ////////////////////////////////////////////////
    func CheckBox(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,isChecked:Bool,id:Int,view:UIView) {
        checkbox.frame = CGRect(x: x, y: y, width: width, height: height)
        if isChecked==true {
            checkbox.setBackgroundImage(UIImage(named: "greenchecktrue"), for: .normal)
        }
        else{
            checkbox.setBackgroundImage(UIImage(named: "greencheckfalse"), for: .normal)
        }
        checkbox.tag = id
        checkbox.addTarget(self, action: #selector(checkboxButtonClick(_:)), for: .touchUpInside)
        view.addSubview(checkbox)
    }
    @objc func checkboxButtonClick(_ btn:UIButton){
        if checkbox.currentBackgroundImage == UIImage(named: "greenchecktrue") {
            checkbox.setBackgroundImage(UIImage(named: "greencheckfalse"), for: .normal)
            ischeckboxSelected = false
        }
        else{
            checkbox.setBackgroundImage(UIImage(named: "greenchecktrue"), for: .normal)
            ischeckboxSelected = true
        }
    }
}
