//
//  Chat2ViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 25/10/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import JSQMessagesViewController
import Alamofire
import IQKeyboardManagerSwift


class Chat2ViewController:JSQMessagesViewController{
    var messages = NSMutableArray()
    var timearray = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.init(red:134/255, green: 215/255, blue: 128/255, alpha: 1.0))
 
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
       
        
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.init(red:109/255, green: 107/255, blue: 108/255, alpha: 1.0))
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SeenMessageApi()
        self.inputToolbar.contentView.textView.tintColor = UIColor.black
        self.inputToolbar.contentView.backgroundColor = UIColor.white
        self.inputToolbar.contentView.textView.font = UIFont(name: "Verdana", size:14)
        self.inputToolbar.contentView.rightBarButtonItem.setBackgroundImage(UIImage(named: "send-msg") as UIImage?, for:.normal)
        self.inputToolbar.contentView.rightBarButtonItem.setBackgroundImage(UIImage(named: "send-msg") as UIImage?, for:.disabled)
       
        self.inputToolbar.contentView.textView.layer.cornerRadius = self.inputToolbar.contentView.textView.frame.size.height/2
        self.inputToolbar.contentView.textView.clipsToBounds = true
        
        self.senderId = UserDefaults.standard.string(forKey:"uid")!
        senderDisplayName = ""
        //self.collectionView.backgroundColor = UIColor.init(red:249/255.0, green:249/255.0, blue:249/255.0, alpha: 1.0)
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
       
        
        
        //            let query = Constants.refs.databaseChats.child(UserDefaults.standard.string(forKey:"uid")!+"-"+UserDefaults.standard.string(forKey:"aid")!)
        //        let ref = Fir.database.reference().child("").child("Live").child("Global")
        
        
        //        childRef.observe(.childAdded) {(snapshot) in
        //            if snapshot.childrenCount > 0 {
        //                for artists in snapshot.children.allObjects as! [FIRDataSnapshot] {
        //_ = query.observe(.value, with: { [weak self] snapshot in
//        Constants.refs.databaseChats.child(UserDefaults.standard.string(forKey:"uid")!+"-"+"0").queryLimited(toLast:1000).observe(.childAdded) { (snapshot) in
//            
//            //let artistObject = artists.value as? [String: AnyObject]
//            
//            
//            
//            let data        = (snapshot).value as? NSDictionary
//            print(data!)
//            let id          = data!["sender_id"]
//            let name        = data!["sender_name"]
//            let text        = data!["text"]
//            let time        = data!["timestamp"]
//            let message = JSQMessage(senderId: id as! String , displayName: name as! String , text: text as! String )
//            self.timearray.add(time!)
//            self.messages.add(message!)
//            self.finishReceivingMessage()
//            
//        }
//        
        
        //}
        
        // }
        //                    !text.isEmpty
        //                {
        //                    if let message = JSQMessage(senderId: id as! String, displayName: name as! String, text: text as! String)
        //                    {
        //                        self.timearray.add(time as! String)
        //                        self.messages.add(message)
        //
        //                        self.finishReceivingMessage()
        //                    }
        //                }
        //                }
        //            }
        //}
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/messages"
        
        let parameter:[String:Any]?  = ["receiver_id":StaticData.obj.receiver_id!,"sender_id":UserDefaults.standard.string(forKey: "uid")!]
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
       
        
        
        Alamofire.request(url, method: .get, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                let json  = value
                 self.messages = []
                self.timearray = []
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
                            
                          var sid:String! = ""
                         var sName:String! = ""
                            
                            let message = Dict["message"] as? String
                            
                            let created_at = Dict["created_at"] as? String
                            
                            if let dic1 = Dict["sender"] as? NSDictionary{
                                
                                if let muid1 = dic1["id"] as? Int{
                                    
                                    let nid:String! = "\(muid1)"
                                    sid = nid
                                    
                                }
                                
                                sName = dic1["username"] as? String
                                
                                
                            }
                            
                            if let message = JSQMessage(senderId: sid, displayName: sName , text: message)
                                                {
                                                    self.timearray.add(created_at!)
                                                    self.messages.add(message)
                            
                                                    self.finishReceivingMessage()
                                                }
                        }
                    }
                
                    
                }else{
                    
                    let message = dic["message"] as! String
                    //self.alertModule(title:"Error", msg:message)
                }
                
                
                
            case .failure(let error):
                
                print(error)
                
                LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                //self.alertModule(title:"Error",msg:error.localizedDescription)
                
                
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.showMembersApi()
        
        IQKeyboardManager.shared.enable = false
        
        IQKeyboardManager.shared.disabledToolbarClasses = [Chat2ViewController.self]
        
    }
    
    
    func SeenMessageApi(){
              
        
              
              
              
        let url : String = "http://app.pyprentals.com/api/messages/"+StaticData.obj.msg_id!+"/read"
           

              
              let header: HTTPHeaders = [
                  
                  "Accept": "application/json"
              ]
              
              print(url)
             // print(parameter!)
              
              Alamofire.request(url, method: .put, parameters: nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                  
                  respones in
                  
                  switch respones.result {
                  case .success( let value):
               
                      let json  = value
             
                       print(json)
                    
                      
                      
                  case .failure(let error):
                      
                      print(error)
                
                      
                      
                  }
              })
              
              
          }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enable = true
    
        
    }
   
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item] as! JSQMessageData
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        
        return (messages[indexPath.item] as AnyObject).senderId == senderId ? outgoingBubble : incomingBubble
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return (messages[indexPath.item] as AnyObject).senderId == senderId ? nil : NSAttributedString(string:"")
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return (messages[indexPath.item] as AnyObject).senderId == senderId ? 10 : 10
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        
       // let  sv = LoginViewController.displaySpinner(onView: self.view)
        if let message = JSQMessage(senderId:senderId, displayName: UserDefaults.standard.string(forKey: "fname")!+" "+UserDefaults.standard.string(forKey: "lname")! , text: text)
        {
            
            
        
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = formatter.string(from: now)
        self.timearray.add(dateString)
        self.messages.add(message)
        }
        
        self.finishReceivingMessage()
        
        let url : String = "http://app.pyprentals.com/api/messages"
        
        let parameter:[String:Any]?  = ["receiver_id":StaticData.obj.receiver_id!,"sender_id":UserDefaults.standard.string(forKey: "uid")!,"message":text!,"shift_type":"SINGLE_SHIFT","shift_id":StaticData.obj.shift_id!]
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        print(parameter)
        
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                let json  = value
               // LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                print(json)
                let dic = json as! NSDictionary
                let code = dic["status"] as! NSNumber
                print(code)
                if(code == 200){
                    
                   
                   
                    
                }else{
                    
                    let message = dic["message"] as! String
                    //self.alertModule(title:"Error", msg:message)
                }
                
                
                
            case .failure(let error):
                
                print(error)
                
                //LoginViewController.removeSpinner(spinner: sv)
                self.view.isUserInteractionEnabled = true
                //self.alertModule(title:"Error",msg:error.localizedDescription)
                
                
            }
        })
        
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = self.messages[indexPath.item]
        
        var isOutgoing = false
        
        if (message as AnyObject).senderId == senderId{
            isOutgoing = true
        }
        
        if isOutgoing {
            
            cell.textView.textColor = UIColor.white
            
        } else {
            
            cell.textView.textColor = UIColor.white
            
        }
        cell.textView?.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        
        cell.cellTopLabel.font = UIFont(name: "Verdana", size:12)
        
        // cell.cellTopLabel.text =
        
        
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        
        //let message = self.messages[indexPath.item]
        if indexPath.item == 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let str = self.timearray[indexPath.item] as? String
            print(str!)
            let myDate = dateFormatter.date(from:str!)
            
            
            return
                JSQMessagesTimestampFormatter.shared().attributedTimestamp(for:myDate)
        }
        
        if indexPath.item -  1 > 0{
            let previousMessage = self.timearray[indexPath.row-1] as? String
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate2 = dateFormatter1.date(from:previousMessage!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let str = self.timearray[indexPath.row] as? String
            let myDate = dateFormatter.date(from:str!)
            if  ( ( (myDate?.timeIntervalSince(myDate2!))! / 60) > 1){
                return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: myDate)
            }
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.item == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        if indexPath.item -  1 > 0{
            let previousMessage = self.timearray[indexPath.row-1] as? String
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate2 = dateFormatter1.date(from:previousMessage!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let str = self.timearray[indexPath.row] as? String
            let myDate = dateFormatter.date(from:str!)
            if  (((myDate?.timeIntervalSince(myDate2!))! / 60) > 1){
                return kJSQMessagesCollectionViewCellLabelHeightDefault
            }
        }
        return 0.0
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        view.endEditing(true)
        let view1 = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:20))
        view1.backgroundColor = UIColor.init(red:190/255.0, green:44/255.0, blue:44/255.0, alpha: 1.0)
        self.navigationController?.view.addSubview(view1)
        
    }
    
}
