//
//  AppDelegate.swift
//  GuideViewExample
//
//  Created by ChuGuimin on 16/1/20.
//  Copyright © 2016年 cgm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Get the version number of current app
        let infoDictionary = Bundle.main.infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String

        // Get the version number saved last time
        let userDefaults = UserDefaults.standard
        let appVersion = userDefaults.string(forKey: "AppVersion")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let guideViewController = storyboard.instantiateViewController(withIdentifier: "Guide") as! GuideViewController

        // If appVersion is nil, it's the first time launch the app；if appVersion is not eaqual to currentAppVersion, the app has been updated
        if appVersion == nil || appVersion != currentAppVersion {
            // Save the current version number
            userDefaults.setValue(currentAppVersion, forKey: "AppVersion")

            self.window?.rootViewController = guideViewController
        } else {
            let nav = storyboard.instantiateViewController(withIdentifier: "navigation")
            // Display the launch page for 2 seconds.
            DispatchQueue.main.asyncAfter(deadline: 2, execute: {self.window?.rootViewController = nav})
        }
        
        return true
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


}

