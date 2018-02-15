//
//  LNApplication.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/26/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

class LNApplication: UIApplication {
    
    override func openURL(_ url: URL) -> Bool {
        print("openURL original method")
        return true
    }
    
    override func open(_ url: URL, options: [String : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        print("openURL original method")
    }
}
