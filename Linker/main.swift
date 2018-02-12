//
//  main.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/26/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(LNApplication.self),
    NSStringFromClass(LNAppDelegate.self)
)
