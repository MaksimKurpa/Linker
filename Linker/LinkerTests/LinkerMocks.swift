//
//  Mocks.swift
//  Tests
//
//  Created by Maksim Kurpa on 2/2/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit
import XCTest

protocol AppDelegateURLProtocol {
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] ) -> Bool
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
}

class AppDelegateMock: NSObject, AppDelegateURLProtocol {
    
     func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
     func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return true
    }
    
     func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
}

protocol ApplicationURLProtocol {
    func openURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [String : Any], completionHandler completion: ((Bool) -> Void)?)
}

class ApplicationMock: NSObject, ApplicationURLProtocol {
    
    func openURL(_ url: URL) -> Bool {
        return true
    }
    
    func open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
    }
}


class SwizzleMockObject: NSObject {
}

