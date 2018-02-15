//
//  LinkerUtils.swift
//  Linker
//
//  Created by Maksim Kurpa on 2/2/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import Foundation

extension Selector {
    public func argumentsCount()-> Int {
        let stringSelector = NSStringFromSelector(self);
        if !stringSelector.contains(":") {
            return 0
        }
        let colons: String  = stringSelector.filter({
            return (":" == $0)
        })
        return colons.count
    }
    
    public func indexOfArgument(withName name: String) -> Int? {
        let subStrings = NSStringFromSelector(self).split(separator: ":", maxSplits: NSIntegerMax, omittingEmptySubsequences: false)
        for subString in subStrings {
            if (subString.contains(name)) {
                return subStrings.index(of: subString)
            }
        }
        return nil
    }
}

extension URL {
    public func key() -> String {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        return "\(components?.scheme ?? "")://\(components?.host ?? "")"
    }
}


