//
//  Linker.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/16/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import UIKit
import CoreFoundation

open class Linker: NSObject {
    
    open class func handle(_ url: URL, closure: @escaping (_ url: URL) -> Void) {
        _ = swizzleOnce
        let key = url.key()
        closuresDict[key] = closure
    }
    
    fileprivate static var handlingURL : URL?
    
    fileprivate static func models(execution: @escaping ExecutionClosureType) -> [LNModel] {
        return Array(arrayLiteral:
            LNModel(clss:type(of: UIApplication.shared),
                         selector:NSSelectorFromString("openURL:options:completionHandler:"),
                         execution: execution),
                     LNModel(clss:type(of: UIApplication.shared),
                                  selector:NSSelectorFromString("openURL:"),
                                  execution: execution),
                     LNModel(clss:type(of: UIApplication.shared.delegate!),
                                  selector:NSSelectorFromString("application:openURL:options:"),
                                  execution: execution),
                     LNModel(clss:type(of: UIApplication.shared.delegate!),
                                  selector:NSSelectorFromString("application:openURL:sourceApplication:annotation:"),
                                  execution: execution),
                     LNModel(clss:type(of: UIApplication.shared.delegate!),
                                  selector:NSSelectorFromString("application:handleOpenURL:"),
                                  execution: execution)
        )}
    
    internal static func swizzleFunc(clss: AnyClass, selector: Selector, execution: Any) -> Void{
        
        let replaceMethod = class_getInstanceMethod(Linker.self, #selector(Linker.fakeMethod))
        var method: Method? = class_getInstanceMethod(clss, selector)
        if method == nil {
            class_addMethod(clss, selector, method_getImplementation(replaceMethod!), nil)
            method = class_getInstanceMethod(clss, selector)
        }
        
        let executionIMP : IMP?
        let argumentsCount = selector.argumentsCount() + 1//- because val0 always object which recieve a message
        
        switch argumentsCount {
        case 2:
            let closure: ObjcBlockType_2 = {val0, val1 in
                (execution as! (AnyObject, AnyObject) -> Void)(val0, val1)
            }
            executionIMP = imp_implementationWithBlock(closure)
        case 3:
            let closure: ObjcBlockType_3 = {val0, val1, val2 in
                (execution as! (AnyObject, AnyObject, AnyObject) -> Void)(val0, val1, val2)
            }
            executionIMP = imp_implementationWithBlock(closure)
        case 4:
            let closure: ObjcBlockType_4 = {val0, val1, val2, val4 in
                (execution as! (AnyObject, AnyObject, AnyObject, AnyObject) -> Void)(val0, val1, val2, val4)
            }
            executionIMP = imp_implementationWithBlock(closure)
        case 5:
            let closure: ObjcBlockType_5 = {val0, val1, val2, val4, val5 in
                (execution as! (AnyObject, AnyObject, AnyObject, AnyObject, AnyObject) -> Void)(val0, val1, val2, val4, val5)
            }
            executionIMP = imp_implementationWithBlock(closure)
        default:
            assert(true, "method has more then 4 arguments")
            return
        }
        
        method_setImplementation(replaceMethod!, executionIMP!)
        method_exchangeImplementations(method!, replaceMethod!)
    }
    
    fileprivate static var swizzleOnce: Void = {
        
        let execution: (URL) -> (URL?) =  {url in
            return Linker.handle(url)
        }
        for  swizzleClosure in models(execution: execution) {
            swizzleFunc(clss: swizzleClosure.clss, selector: swizzleClosure.selector, execution: swizzleClosure.execution as Any)
        }
    }()
    
    @objc fileprivate func fakeMethod() -> Void {
    }
    
    static fileprivate var closuresDict: [String : LinkerClosureType] = {
        return [:] }()
    

    fileprivate class func handle(_ url: URL) -> URL? {
        
        let urlStringKey: String = url.key()
        let closure: LinkerClosureType? = closuresDict[urlStringKey]
        
        guard let execution = closure else {
            return url
        }
        
        if self.handlingURL != nil {
            if url == self.handlingURL! {
                return nil
            }
        }
        self.handlingURL = url
        self.handleIfAppIsLoaded(withConmplitionBlock: {() -> Void in
            execution(url)
        })
        return nil
    }
    
    fileprivate class func handleIfAppIsLoaded(withConmplitionBlock complitionBlock: @escaping () -> ()) {
        if UIApplication.shared.applicationState == .active {
            self.handlingURL = nil
            complitionBlock()
        } else {
            var observer : Any? = nil
             observer = NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main, using: {(_ note: Notification) -> Void in
                    self.handlingURL = nil
                    complitionBlock()
                    NotificationCenter.default.removeObserver(observer!)
                    observer = nil
            })
        }
    }
}
