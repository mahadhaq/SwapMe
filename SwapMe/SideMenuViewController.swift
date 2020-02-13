//
//  SideMenuViewController.swift
//  WOW
//
//  Created by Rao Mudassar on 14/04/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var array:NSMutableArray = ["","DASHBOARD","MY PROFILE","CREATE SWAP","PENDING SWAP","SWAP HISTORY","NOTES","MESSAGES","SETTINGS","LOG OUT"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableview.tableFooterView = UIView()
//
//        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 80
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableview.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            
            let cell:TableViewCell01 = tableView.dequeueReusableCell(withIdentifier:"cell01", for: indexPath) as! TableViewCell01
            
            cell.profile_name.text = UserDefaults.standard.string(forKey: "fname")!+" "+UserDefaults.standard.string(forKey: "lname")!
            
            cell.profile_email.text = UserDefaults.standard.string(forKey: "uemail")!
            
          
            cell.profile_img.layer.masksToBounds = false
            cell.profile_img.layer.cornerRadius = cell.profile_img.frame.height/2
            cell.profile_img.clipsToBounds = true
           
            cell.profile_img.sd_setImage(with: URL(string:UserDefaults.standard.string(forKey:"profile_pic")!), placeholderImage: UIImage(named: "ic_profile_default"))
            
            
            return cell
        }
        else if (indexPath.row == 1){
            let cell:TableViewCell02 = tableView.dequeueReusableCell(withIdentifier:"cell02", for: indexPath) as! TableViewCell02
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.lbl_gen.text = "GENERAL"
            cell.lbl_gen.font = UIFont(name: "Plain", size:22);
            cell.gen_view.alpha = 0
            
            return cell
            
        }else if (indexPath.row == 2){
            let cell:TableViewCell03 = tableView.dequeueReusableCell(withIdentifier:"cell03", for: indexPath) as! TableViewCell03
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
           cell.gen_view.alpha = 1
            
            return cell
            
        }else if (indexPath.row == 3){
            let cell:TableViewCell02 = tableView.dequeueReusableCell(withIdentifier:"cell02", for: indexPath) as! TableViewCell02
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.lbl_gen.text = "SWAP"
            cell.lbl_gen.font = UIFont(name: "Plain", size:22);
            cell.gen_view.alpha = 0
            
            return cell
            
        }else if (indexPath.row == 4){
            
            let cell:TableViewCell03 = tableView.dequeueReusableCell(withIdentifier:"cell03", for: indexPath) as! TableViewCell03
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
         cell.gen_view.alpha = 0
            
            return cell
            
        }else if (indexPath.row == 5){
            let cell:TableViewCell03 = tableView.dequeueReusableCell(withIdentifier:"cell03", for: indexPath) as! TableViewCell03
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            //cell.menu_name.font = UIFont(name: "Bold", size:22);
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.gen_view.alpha = 1
            return cell
          
            
        }
        else if (indexPath.row == 6){
            
            let cell:TableViewCell02 = tableView.dequeueReusableCell(withIdentifier:"cell02", for: indexPath) as! TableViewCell02
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.lbl_gen.text = "OTHER"
            //cell.lbl_gen.font = UIFont(name: "Avenir", size:22);
            cell.lbl_gen.font = UIFont(name: "Plain", size:22);
            cell.gen_view.alpha = 0
            
            return cell
            
        }else if (indexPath.row == 7){
            
            let cell:TableViewCell03 = tableView.dequeueReusableCell(withIdentifier:"cell03", for: indexPath) as! TableViewCell03
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.gen_view.alpha = 0
            return cell
            
        }else{
            let cell:TableViewCell03 = tableView.dequeueReusableCell(withIdentifier:"cell03", for: indexPath) as! TableViewCell03
            
            cell.menu_name.text = self.array[indexPath.row] as? String
            cell.menu_name?.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.gen_view.alpha = 0
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 1){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
           
            revealViewController()?.pushFrontViewController(vc, animated: true)
        }else if(indexPath.row == 2){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MyProfileViewController") as! ProfileViewController
            
            revealViewController()?.pushFrontViewController(vc, animated: true)
        }else if(indexPath.row == 3){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CreateSwapViewController") as! CreateSwapViewController
            
            revealViewController()?.pushFrontViewController(vc, animated: true)
        }
        else if(indexPath.row == 4){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "PendingSwapViewController") as! PendingSwapViewController
            
            revealViewController()?.pushFrontViewController(vc, animated: true)
        }
        else if(indexPath.row == 5){
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SwapHistoryViewController") as! SwapHistoryViewController
            
            revealViewController()?.pushFrontViewController(vc, animated: true)
            
        }
        else if(indexPath.row == 6){
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
            
            revealViewController()?.pushFrontViewController(vc, animated: true)
            
        }
            else if(indexPath.row == 7){
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
                
                revealViewController()?.pushFrontViewController(vc, animated: true)
                
            }
       else if(indexPath.row == 8){
           
           let sb = UIStoryboard(name: "Main", bundle: nil)
           let vc = sb.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
           
           revealViewController()?.pushFrontViewController(vc, animated: true)
           
       }
           
        
        else if(indexPath.row == 9){
              
                      UserDefaults.standard.set("", forKey: "uid")
                      self.performSegue(withIdentifier:"gotonav", sender: self)
                  
              }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            
            return 142
        }else if(indexPath.row == 1){
            
            return 60
        }else if(indexPath.row == 3){
            
            return 60
        }else if(indexPath.row == 6){
            
            return 60
        }
        else{
            
            return 32
            
        }
        
    }
  
    
}
