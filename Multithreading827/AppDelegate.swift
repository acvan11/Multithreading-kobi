//
//  AppDelegate.swift
//  Multithreading827
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? //the main screen of the application


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: MainViewController()) //embed into nav controller
        window?.rootViewController = navController
        window?.makeKeyAndVisible() //shows window
        
        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}

