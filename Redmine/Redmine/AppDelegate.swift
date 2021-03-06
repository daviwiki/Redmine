//
//  AppDelegate.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        customizeNavigationBars()
        customizeBarButtonItems()
        
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
    }


}

// MARK: NSURLSession
private var appDelegateSessionKey : UInt8 = 0

extension AppDelegate : URLSessionTaskDelegate {
    
    private var session : URLSession? {
        get {
            return objc_getAssociatedObject(self, &appDelegateSessionKey) as? URLSession
        }
        set (newValue) {
            objc_setAssociatedObject(self, &appDelegateSessionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var defaultConfiguration : URLSessionConfiguration {
        get {
            return URLSessionConfiguration.default
        }
    }
    
    var defaultSession : URLSession {
        get {
            if session != nil {
                return session!
            }
            
            session = URLSession(configuration:defaultConfiguration, delegate: self, delegateQueue: nil)
            return session!
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
//        print("\(metrics)")
    }
}

extension AppDelegate {
    
    func customizeNavigationBars() {
        let appearance = UINavigationBar.appearance()
        let font = UIFont(name: "SFUIText-Regular", size: 18)!
        appearance.titleTextAttributes = [
            NSForegroundColorAttributeName : #colorLiteral(red: 0, green: 0.9182831645, blue: 0.7645309567, alpha: 1),
            NSFontAttributeName : font
        ]
    }
    
    func customizeBarButtonItems() {
        let appearance = UIBarButtonItem.appearance()
        let font = UIFont(name: "SFUIText-Regular", size: 16)!
        appearance.setTitleTextAttributes(
            [
                NSForegroundColorAttributeName : #colorLiteral(red: 0, green: 0.9182831645, blue: 0.7645309567, alpha: 1),
                NSFontAttributeName : font
            ],
            for: UIControlState.normal)
    }
    
}
