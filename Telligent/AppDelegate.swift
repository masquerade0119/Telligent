//
//  AppDelegate.swift
//  Telligent
//
//  Created by MaLynn on 2017/7/18.
//  Copyright © 2017年 Telexpress_MaLynn. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        var myUserDefaults :UserDefaults!
//        
//        // 取得儲存的預設資料
//        myUserDefaults = UserDefaults.standard
//        if (myUserDefaults.object(forKey: "loginState") as! String) == "autologin" {
//            
//        }
        
//        var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
        
        if (UserDefaults.standard.object(forKey: "loginState") == nil) {
            print("key exist")
            
            UserDefaults.standard.set("applogin",forKey: "loginState")
            UserDefaults.standard.synchronize()
            
        }
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert,
                                                         UIUserNotificationType.badge,
                                                         UIUserNotificationType.sound]
        
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        
        application.registerForRemoteNotifications()
        
        return true
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    //MARK: - Push Notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        var pushToken = String(format: "%@", deviceToken as CVarArg)
        pushToken = pushToken.trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
        pushToken = pushToken.replacingOccurrences(of: " ", with: "")
        
        UserDefaults.standard.set(pushToken, forKey: "pushToken")
        UserDefaults.standard.synchronize()
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("notification userInfo",userInfo)
        
        UserDefaults.standard.set(userInfo, forKey: "apsInfo")
        let objectValue:Any? = UserDefaults.standard.object(forKey: "apsInfo")
        
        print(objectValue!)
        
        let dataInfo : NSDictionary = userInfo["data"] as! NSDictionary
        
        let notificationType : String = dataInfo.object(forKey: "Type") as! String
        
        if notificationType == "NewMsgNotice"{
            
            let localNotification = UILocalNotification()
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
            localNotification.alertTitle = dataInfo.object(forKey: "Title") as? String
            localNotification.alertBody = dataInfo.object(forKey: "Body") as? String
            localNotification.timeZone = NSTimeZone.default
            localNotification.applicationIconBadgeNumber = Int(dataInfo.object(forKey: "NotReadNum") as! String)!
            
//            UIApplication.sharedApplication.scheduleLocalNotification(localNotification)
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
            
        }
        else if  notificationType == "UpdateNotReadNum"{
            
            
            UIApplication.shared.applicationIconBadgeNumber = Int(dataInfo.object(forKey: "NotReadNum") as! String)!
        }
        else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: notificationType), object: self, userInfo: userInfo)
        }
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Telligent")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

