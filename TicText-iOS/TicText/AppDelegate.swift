//
//  AppDelegate.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/6/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //initializeParse()
        
        let navigationController = UINavigationController(rootViewController: TTRootViewController())
        navigationController.navigationBarHidden = true
        
        self.window?.rootViewController = navigationController
        self.window?.tintColor = UIColor(red: 130.0/255.0, green: 100.0/255.0, blue: 200.0/255.0, alpha: 0.0)
        self.window?.makeKeyAndVisible()
        
        handlePushNotificationWithApplication(application, launchOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func initializeParse() {
        
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("otEYQUdVy98OBM9SeUs8Zc1PrMy27EGMvEy80WaL", clientKey: "qfTOvPp03kY8uSYVu3FkL72UWwW37Tx2B6L6Ppq9")
        
        PFFacebookUtils.initializeFacebook()
        
        PFUser.enableRevocableSessionInBackground()
    }
    
    private func handlePushNotificationWithApplication(application: UIApplication, launchOptions: [NSObject: AnyObject]?) {
        
    }

}

