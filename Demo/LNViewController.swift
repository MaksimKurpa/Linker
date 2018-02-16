//
//  LNViewController.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/16/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit

class LNViewController: UIViewController {
    
    let sourceURL = URL(string: "linker://viewcontroller?title=ExampleAlert&description=ExampleDescriptionAlert")!

    @IBAction func action(_ sender: Any) {
        UIApplication.shared.open(sourceURL, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Linker.handle(sourceURL) { url in
        
            guard let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems! else {
                return }
            var title : String? = nil
            var description: String? = nil
            
            for item in queryItems {
                if item.name == "title" {
                    title = item.value
                }
                if item.name == "description" {
                    description = item.value;
                }
            }
            
            if let name = title, let message = description {
                let alertVC = UIAlertController(title: name, message: message, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {action in
                    alertVC.dismiss(animated: true, completion: nil)
                }))
                self.present(alertVC, animated: false, completion: nil)
            }
        }
    }
}
