
//
//  AppDelegate.swift
//  Kogen
//
//  Created by Kogen on 7/21/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import CoreData
import FacebookCore
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    var radioPlayerMain: MPMoviePlayerController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
//FireBase
        FirebaseApp.configure()
        let notificationTypes : UIUserNotificationType = [UIUserNotificationType.alert,UIUserNotificationType.badge,UIUserNotificationType.sound]
        
        let notificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        application.registerForRemoteNotifications()
        application.registerUserNotificationSettings(notificationSettings)
        
        
        //print(application.applicationState)
        
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        //application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
//

        
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "radio_stream_play")
        
        
        
        //        let aps = userInfo[AnyHashable("aps")]!
        
        //
        //        var section = userInfo[AnyHashable("section")]!
        

        // 1
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            

            // 2
            let aps = notification["aps"] as! [String: AnyObject]
            var section = notification["section"] as! [String: AnyObject]
            var section1 = String(describing: section)
            
            let defaults = UserDefaults.standard
            defaults.set("affiche", forKey: "sectionPush")
            defaults.synchronize()
            
        }
        
        
        
        
//        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().delegate = self
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
//                if (granted) {
//                    UIApplication.shared.registerForRemoteNotifications()
//                } else{
//                    print("Notification permissions not granted")
//                }
//            })
//        } else {
//            // Fallback on earlier versions
//        }
        
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let defaults = UserDefaults.standard
        defaults.set("affiche", forKey: "sectionPush")
        defaults.synchronize()
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Firebase notification received
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
        
        // custom code to handle push while app is in the foreground
        print("Handle push from foreground\(notification.request.content.userInfo)")
        
        let dict = notification.request.content.userInfo["aps"] as! NSDictionary
        let d : [String : Any] = dict["alert"] as! [String : Any]
        let body : String = d["body"] as! String
        let title : String = d["title"] as! String
        print("Title:\(title) + body:\(body)")
        self.showAlertAppDelegate(title: title,message:body,buttonTitle:"ok",window:self.window!)
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background
        print("Handle push from background or closed\(response.notification.request.content.userInfo)")
    }
    
    func showAlertAppDelegate(title: String,message : String,buttonTitle: String,window: UIWindow){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        window.rootViewController?.present(alert, animated: false, completion: nil)
    }
    // Firebase ended here
    
    
    
   
 
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//        // If you are receiving a notification message while your app is in the background,
//        // this callback will not be fired till the user taps on the notification launching the application.
//        // TODO: Handle data of notification
//        
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//        
//        // Print message ID.
//
//        
//        // Print full message.
//        print(1)
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.

        
        // Print full message.
        //print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//        print("Received Notification in didReceiveRemoteNotification \(userInfo)")
//        
//        
//        print(userInfo)
//        
//        // display the alert body
//        if let notification = userInfo["aps"] as? NSDictionary,
//            let alert = notification["alert"] as? NSDictionary,
//            let body = alert["body"] as? String {
//            showAlert(body)
//        }
//        
 
//        var section1 = String(describing: section)
//        
//        
//        let defaults = UserDefaults.standard
//        defaults.set(section1, forKey: "sectionPush")
//        defaults.synchronize()
//        
//        
////        let defaults = UserDefaults.standard
////        defaults.set(section1, forKey: "sectionPush")
////        defaults.synchronize();
//        
//        
//        /*
//         NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
//         NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
//         NSUserDefaults.standardUserDefaults().setObject(userRepeatPassword, forKey: "userRepeatPassword");
//         
//         NSUserDefaults.standardUserDefaults().synchronize();
//         */
//        
//    }
    
    func showAlert(_ message: String) {
        let alertDialog = UIAlertController(title: "Push Notification", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertDialog.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        
        window!.rootViewController?.present(alertDialog, animated: true, completion: nil)
    }
    
 /*
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(24)
        
        
        //print("MessageID : \(userInfo["gcm_message_id"]!)")
        //print(userInfo)
        
//        let aps = userInfo[AnyHashable("aps")]!

//        
//        var section = userInfo[AnyHashable("section")]!
//        var section1 = String(describing: section)

        //var alert: AnyObject? = userInfo["aps"] as AnyObject
        
        
        
        /*
        let aps = userInfo[AnyHashable("aps")]! as! NSDictionary
        var message = ""
        if userInfo["google.c.a.c_l"] != nil
        {
            message = (userInfo["google.c.a.c_l"] as? String)!
        }

        let alert = aps["alert"]! as! NSDictionary
        let body = alert["body"] as! String
        let title = alert["title"] as! String
        self.showAlertAppDelegate(title: title, message: message, buttonTitle:"ok", window:self.window!)
        */
        
        
 //       print(section1)
//        //let myMasterViewController = MasterViewController()
//        //print(myMasterViewController.afficheBadgeLabel.text)
//        
//        let defaults = UserDefaults.standard
//        defaults.set(1, forKey: "sectionPush")
//
        //let defaults = UserDefaults.standard
       // defaults.set(section1, forKey: "sectionPush")
        
        

        
//        if section {
//            
//            //let myMasterViewController = MasterViewController()
//            //myMasterViewController.afficheBadgeLabel.isHidden = false
//        }


        
    }
*/
    
    
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        //Handle the notification
//        print("did receive")
//        let body = response.notification.request.content.body
//        completionHandler()
//        
//    }
    
}

