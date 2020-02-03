//
//  AppDelegate.swift
//  SwapMe
//
//  Created by Rao Mudassar on 20/08/2019.
//  Copyright © 2019 Rao Mudassar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import PushNotifications
import UserNotifications
import PusherSwift

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,PusherDelegate  {

    var window: UIWindow?
    
    var LastViewController:UIViewController?
    var homeViewController:HomeViewController?
    
    var pusher : Pusher!
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.registerForRemoteNotifications()
        IQKeyboardManager.shared.enable = true
        
        if(UserDefaults.standard.string(forKey:"uid") == nil || UserDefaults.standard.string(forKey:"uid") == ""){
            
            
            
        }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController:SWRevealViewController = (storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController)!
            self.window?.rootViewController = tabViewController
            self.window?.makeKeyAndVisible()
        }
      
        
        self.userNotificationCenter.delegate = self
        
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenparts = deviceToken.map{data in
            return String(format:"%02.2hhx", data)
    }
        let token = tokenparts.joined()
        print("device token\(token)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func SubscribetoPusher()  {
        self.PushershiftstatusResponce()
        self.PusherNotificationResponce()
        self.PushershiftrequestResponce()
        self.PushershiftrequestnomoreResponce()
    }
    
    func PusherNotificationResponce(){
        let options = PusherClientOptions(
            authMethod: AuthMethod.endpoint(authEndpoint: "http://app.pyprentals.com/api/auth"),
            host: .cluster("ap2")
        )
        
        pusher = Pusher(key: "0b6389c92afdc83c6e18", options: options)

        print(pusher.connection.url);
        //
        let userid : String = UserDefaults.standard.string(forKey:"uid")!
        print(userid)
        let channel = pusher.subscribe("private-user."+userid+".notifications")
        
        
        let _ = channel.bind(eventName: "Notification", callback: { (data: Any?) -> Void in
            
            if let data = data as? [String : AnyObject] {
                print(data)
                let alertController = UIAlertController(title: "Success", message: "Testing1", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                    
                    alertController.dismiss(animated: true, completion: nil)
                })
                
                alertController.addAction(alertAction)
                
//                self.present(alertController, animated: true, completion: nil)
            }
        })
        pusher.connection.delegate = self
        pusher.connect()
    }
    
    func PushershiftrequestResponce(){
        let options = PusherClientOptions(
            authMethod: AuthMethod.endpoint(authEndpoint: "http://app.pyprentals.com/api/auth"),
            host: .cluster("ap2")
        )
        
        pusher = Pusher(key: "0b6389c92afdc83c6e18", options: options)
        pusher.connection.delegate = self
        
        //
        let userid : String = UserDefaults.standard.string(forKey:"uid")!
        print(userid)
        let channel = pusher.subscribe("private-user."+userid+".notifications")
        
        
        let _ = channel.bind(eventName: "shift_request", callback: { (data: Any?) -> Void in
            
            if let data = data as? [String : AnyObject] {
                print(data)
                let alertController = UIAlertController(title: "Success", message: "Accept/Reject", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                    
                    alertController.dismiss(animated: true, completion: nil)
                })
                
                alertController.addAction(alertAction)
                
//                self.present(alertController, animated: true, completion: nil)
            }
        })
        
        pusher.connect()
        print(pusher.connection.url);
    }
    
    func PushershiftstatusResponce(){
        let options = PusherClientOptions(
            authMethod: AuthMethod.endpoint(authEndpoint: "http://app.pyprentals.com/api/auth"),
            host: .cluster("ap2")
        )
        
        pusher = Pusher(key: "0b6389c92afdc83c6e18", options: options)
        pusher.connection.delegate = self
        
        //
        let userid : String = UserDefaults.standard.string(forKey:"uid")!
        print(userid)
        let channel = pusher.subscribe("private-user."+userid+".notifications")
        
        let _ = channel.bind(eventName: EVENT_NAME_SHIFT_REQUEST_STATUS_NOTIFICATION, eventCallback: { (event: PusherEvent) in
            
            if let data = event.data {
              // you can parse the data as necessary
              print(data)
            }
        })
        
//        let _ = channel.bind(eventName: "shift_status", callback: { (data: Any?) -> Void in
//
//            if let data = data as? [String : AnyObject] {
//                print(data)
//
//                let alertController = UIAlertController(title: "Success", message: "Testing2", preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
//
//                    alertController.dismiss(animated: true, completion: nil)
//                })
//
//                alertController.addAction(alertAction)
//
////                self.present(alertController, animated: true, completion: nil)
//
//            }
//        })
        pusher.connect()
        print(pusher.connection.url);
    }
    
    func PushershiftrequestnomoreResponce(){
        let options = PusherClientOptions(
            authMethod: AuthMethod.endpoint(authEndpoint: "http://app.pyprentals.com/api/auth"),
            host: .cluster("ap2")
        )
        
        pusher = Pusher(key: "0b6389c92afdc83c6e18", options: options)
        pusher.connection.delegate = self
        //
        let userid : String = UserDefaults.standard.string(forKey:"uid")!
        print(userid)
        let channel = pusher.subscribe("private-user."+userid+".notifications")
        
        
        let _ = channel.bind(eventName: "shift_request_no_more", callback: { (data: Any?) -> Void in
            
            if let data = data as? [String : AnyObject] {
                
                let alertController = UIAlertController(title: "Success", message: "Testing3", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
                    
                    alertController.dismiss(animated: true, completion: nil)
                })
                
                alertController.addAction(alertAction)
                
//                self.present(alertController, animated: true, completion: nil)
                print(data)
                
            }
        })
        
        pusher.connect()
        print(pusher.connection.url);
    }


}

