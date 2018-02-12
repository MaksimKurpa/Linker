//
//  LinkerTypes.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/26/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import Foundation

typealias LinkerClosureType = (_ url: URL) -> Void
typealias ExecutionClosureType = (URL) -> (URL?)?

typealias ClosureType_2 = (AnyObject, AnyObject) -> Void
typealias ClosureType_3 = (AnyObject, AnyObject, AnyObject) -> Void
typealias ClosureType_4 = (AnyObject, AnyObject, AnyObject, AnyObject) -> Void
typealias ClosureType_5 = (AnyObject, AnyObject, AnyObject, AnyObject, AnyObject) -> Void

typealias FuncCType_2 = @convention(c) (AnyObject, Selector ,AnyObject) -> Void
typealias FuncCType_3 = @convention(c) (AnyObject, Selector ,AnyObject, AnyObject) -> Void
typealias FuncCType_4 = @convention(c) (AnyObject, Selector ,AnyObject, AnyObject, AnyObject) -> Void
typealias FuncCType_5 = @convention(c) (AnyObject, Selector ,AnyObject, AnyObject, AnyObject, AnyObject) -> Void

typealias ObjcBlockType_2 = @convention(block) (AnyObject, AnyObject) -> Void
typealias ObjcBlockType_3 = @convention(block) (AnyObject, AnyObject, AnyObject) -> Void
typealias ObjcBlockType_4 = @convention(block) (AnyObject, AnyObject, AnyObject, AnyObject) -> Void
typealias ObjcBlockType_5 = @convention(block) (AnyObject, AnyObject, AnyObject, AnyObject, AnyObject) -> Void
