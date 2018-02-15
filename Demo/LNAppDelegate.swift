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
        
        if let launchURL = launchOptions?[UIApplicationLaunchOptionsKey.url] as? URL {
            Linker.handle(launchURL, closure: { url in
                UIAlertView(title: "Hello", message: "world!", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "Cancel").show()
            })
            _ = [UIApplication.shared .open(launchURL, options: [:], completionHandler: nil)]
        }
        
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

