//
//  LNAppDelegate.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/16/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

class LNAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let launchURL = URL(string: "linker://launchURL")!
        Linker.handle(launchURL, closure: { url in
            print("Your URL has been handle!")
        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print("original IMP")
        return true
    }
}

