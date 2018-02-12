//
//  LNModel.swift
//  Linker
//
//  Created by Maksim Kurpa on 1/23/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import Foundation

struct LNModel {
    
    init(clss: AnyClass, selector: Selector, execution:@escaping ExecutionClosureType ) {
        
        let method: Method? = class_getInstanceMethod(clss, selector);
        var originalIMP : IMP? = nil
        if let originalMethod = method {
            originalIMP = method_getImplementation(originalMethod);
        }
        
        let argumentsCount = selector.argumentsCount() + 1 //because first parament is always self object
        let sourceParameterIndex = selector.indexOfArgument(withName: "URL")

        switch argumentsCount {
        case 2:
            let closure: ClosureType_2 =  {val0, val1 in
                
                let urlDidntHandle = execution(val1 as! URL)
                if let _ = urlDidntHandle, let _ = originalIMP{
                    let curriedImplementation = unsafeBitCast(originalIMP, to: FuncCType_2.self)
                    curriedImplementation(val0, selector,val1)
                }
            }
            self._execution = closure as AnyObject
        case 3:
            let closure: ClosureType_3 =  {val0, val1, val2 in
                guard let sourceIndex = sourceParameterIndex else {
                    return
                }
                let urlDidntHandle = execution(sourceIndex == 0 ? val1 as! URL : val2 as! URL)
                if let _ = urlDidntHandle, let _ = originalIMP{
                    let curriedImplementation = unsafeBitCast(originalIMP, to: FuncCType_3.self)
                    curriedImplementation(val0, selector,val1, val2)
                }
            }
            self._execution = closure as AnyObject
        case 4:
            let closure: ClosureType_4 =  {val0, val1, val2, val3 in
                guard let sourceIndex = sourceParameterIndex else {
                    return
                }
                let urlDidntHandle = execution(sourceIndex == 0 ? val1 as! URL : sourceIndex == 1 ? val2 as! URL : val3 as! URL)
                if let _ = urlDidntHandle, let _ = originalIMP{
                    let curriedImplementation = unsafeBitCast(originalIMP, to: FuncCType_4.self)
                    curriedImplementation(val0, selector,val1, val2, val3)
                }
            }
            self._execution = closure as AnyObject
        case 5:
            let closure: ClosureType_5 =  {val0, val1, val2, val3, val4 in
                guard let sourceIndex = sourceParameterIndex else {
                    return
                }
                let urlDidntHandle = execution(sourceIndex == 0 ? val1 as! URL : sourceIndex == 1 ? val2 as! URL : sourceIndex == 2 ? val3 as! URL : val4 as! URL)
                if let _ = urlDidntHandle, let _ = originalIMP{
                    let curriedImplementation = unsafeBitCast(originalIMP, to: FuncCType_5.self)
                    curriedImplementation(val0, selector,val1, val2, val3, val4)
                }
            }
            self._execution = closure as AnyObject
        default:
            self._execution = nil
        }
        _clss = clss
        _selector = selector
    }
    
    //MARK: - Properties
    
    var selector: Selector {
        return _selector
    }
    var clss: AnyClass {
        return _clss
    }
    var execution: AnyObject? {
        return _execution
    }
    
    private var _selector: Selector;
    private var _clss: AnyClass
    private var _execution: AnyObject?;
}
