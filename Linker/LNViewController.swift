//
//  LNViewController.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/16/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

class LNViewController: UIViewController {
    let url = URL(string: "linker://viewcontroller?title=ExampleAlert&description=ExampleDescriptionAlert")!

    @IBAction func action(_ sender: Any) {
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        UIApplication.shared .openURL(url)
        
//        UIApplication.shared.delegate!.application!(UIApplication.shared, open: url, options: [:])
//        UIApplication.shared.delegate!.application!(UIApplication.shared, handleOpen: url)
//        UIApplication.shared.delegate!.application!(UIApplication.shared, open: url, sourceApplication: nil, annotation: "sd")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Linker.handle(url) { url in
            print("URL handled")
        }
    }
}
