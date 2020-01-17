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

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate  {

    var window: UIWindow?
    
    var LastViewController:UIViewController?
    var homeViewController:HomeViewController?
    
    
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
    
    


}

