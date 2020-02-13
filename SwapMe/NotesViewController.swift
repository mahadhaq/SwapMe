//
//  NotesViewController.swift
//  SwapMe
//
//  Created by Rao Mudassar on 05/09/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import Alamofire


class NotesViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var btn_menu: UIButton!
    
    @IBOutlet weak var search: UISearchBar!
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var filtered:NSMutableArray = []
    var searchActive : Bool = false
    
    var notesArray:NSMutableArray = []
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.search.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        if self.revealViewController() != nil {
            btn_menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }

       tableview.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.GetNotesApi()
        
        
        StaticData.obj.isNew = "yes"
        delegate.LastViewController = delegate.homeViewController
        
    }
    
    func GetNotesApi(){
        
        
        
        let  sv = LoginViewController.displaySpinner(onView: self.view)
        
        
        
        let url : String = "http://app.pyprentals.com/api/notes"
        
        let parameter:[String:Any]?  = ["user_id":UserDefaults.standard.string(forKey: "uid")!]
        
        
        let header: HTTPHeaders = [
            
            "Accept": "application/json"
        ]
        
        print(url)
        print(parameter!)
        
        Alamofire.request(url, method: .get, parameters: parameter, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
            
            respones in
            
            switch respones.result {
            case .success( let value):
                
                self.notesArray = []
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
                   
                    
                        
                        let id = Dict["id"] as? Int
                        
                        let nid:String! = "\(id ?? 0)"
                        
                        let title = Dict["title"] as? String
                        
                        let descri = Dict["description"] as? String
                        
                        let updated_at = Dict["updated_at"] as? String
                    
                        let obj = Note(nid: nid, title: title, descri: descri,updated_at:updated_at)
                        
                        self.notesArray.add(obj)
                    }
                    
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
                }else{
                    
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
                    
                    //let message = dic["message"] as! String
                    //self.alertModule(title:"Error", msg:message)
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
    
    func alertModule(title:String,msg:String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive == true){
            return self.filtered.count
        }else{
           return self.notesArray.count
        }
        

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(searchActive == true){
         let cell:NotesTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! NotesTableViewCell
        
        
        
        let obj = self.filtered[indexPath.row] as! Note
        
        cell.notes_title.text = obj.title
        cell.notes_des.text = "Last Updated:"+obj.updated_at
        
        return cell
        }else{
            let cell:NotesTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell03") as! NotesTableViewCell
            
            
            
            let obj = self.notesArray[indexPath.row] as! Note
            
            cell.notes_title.text = obj.title
            cell.notes_des.text = "Last Updated:"+obj.updated_at
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 73
    }
  
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            var uuid:String! = "0"
            
            if(self.searchActive == true){
                let obj = self.filtered[indexPath.row] as! Note
                uuid = obj.nid
            }else{
                
                let obj = self.notesArray[indexPath.row] as! Note
                uuid = obj.nid
            }
            
            let  sv = LoginViewController.displaySpinner(onView: self.view)
            
           
            
            let url : String = "http://app.pyprentals.com/api/notes/"+uuid
            
      
            
            
            let header: HTTPHeaders = [
                
                "Accept": "application/json"
            ]
            
            print(url)
           
            
            Alamofire.request(url, method: .delete, parameters: nil, encoding:URLEncoding.default, headers:header).validate(statusCode: 200..<600).responseJSON(completionHandler: {
                
                respones in
                
                switch respones.result {
                case .success( let value):
                    
                    self.notesArray = []
                    let json  = value
                    LoginViewController.removeSpinner(spinner: sv)
                    self.view.isUserInteractionEnabled = true
                    print(json)
                    let dic = json as! NSDictionary
                    let code = dic["status"] as! NSNumber
                    print(code)
                    if(code == 200){
                        
                        self.GetNotesApi()
                      
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
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            
            if(self.searchActive == true){
                let obj = self.filtered[indexPath.row] as! Note
                StaticData.obj.isNew = "no"
                StaticData.obj.title = obj.title
                StaticData.obj.desc = obj.descri
                StaticData.obj.nnid = obj.nid
            }else{
                
                let obj = self.notesArray[indexPath.row] as! Note
                StaticData.obj.isNew = "no"
                StaticData.obj.title = obj.title
                StaticData.obj.desc = obj.descri
                StaticData.obj.nnid = obj.nid
            }
            
           
            
//            self.performSegue(withIdentifier:"gotocreate", sender: self)
            
            self.delegate.LastViewController = self
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let createNotesVC = sb.instantiateViewController(withIdentifier: "CreateNoteViewController") as! CreateNoteViewController
            
            self.revealViewController()?.setFront(createNotesVC, animated: true)
            
          
        }
        edit.backgroundColor = UIColor.init(red:243/255, green: 111/255, blue: 54/255, alpha: 1.0)
        
        let config = UISwipeActionsConfiguration(actions: [delete,edit])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        searchActive = false;
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchActive = false;
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
        searchBar.showsCancelButton = true
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = []
        searchActive = true;
        
        if((self.notesArray.count) > 0){
            for i in 0...(notesArray.count)-1{
                let obj = notesArray[i] as! Note
                if obj.title!.lowercased().range(of:searchText.lowercased()) != nil {
                    
                    self.filtered.add(obj)
                    
                }
            }
        }
        
        
        print(filtered)
        
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableview.reloadData()
        
    }
    
    
    @IBAction func CreateNoteBtn_Click(_ sender: Any) {
        self.delegate.LastViewController = self
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let createNotesVC = sb.instantiateViewController(withIdentifier: "CreateNoteViewController") as! CreateNoteViewController
        
        self.revealViewController()?.setFront(createNotesVC, animated: true)
    }
    

}
