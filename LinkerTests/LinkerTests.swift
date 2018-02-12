//
//  Tests.swift
//  Tests
//
//  Created by Maksim Kurpa on 1/26/18.
//  Copyright © 2018 Maksim Kurpa. All rights reserved.
//

import XCTest
import Foundation
@testable import Linker

extension SwizzleMockObject {
    @objc dynamic func test1(URL url: URL) -> Void {
        describe("testURL1", closure: {
            $0.it("original function with one parameter", closure: {
                throw failure("Called")
            })
        })
    }
    @objc dynamic func test2(_ val0: String?, URL url: URL) -> Void {
        describe("testURL2", closure: {
            $0.it("original function with two parameters", closure: {
                throw failure("Called")
            })
        })
    }
    @objc dynamic func test3(_ val0: String?, URL url: URL, _ val1: String?) -> Void {
        describe("testURL3", closure: {
            $0.it("original function with three parameters", closure: {
                throw failure("Called")
            })
        })
    }
    @objc dynamic func test4(_ val0: String?, _ val1: String?,URL url: URL, _ val2: String?) -> Void {
        describe("testURL4", closure: {
            $0.it("original function with four parameters", closure: {
                throw failure("Called")
            })
        })
    }
    @objc dynamic func succesTest4(_ val0: String?, _ val1: String?,URL url: URL, _ val2: String?) -> Void {
        describe("succesTest4", closure: {
            $0.it("original function with four parameters", closure: {
                try expect(true).beTrue()
            })
        })
    }
}

class Tests: XCTestCase {
    
    func test() {
        utilsTest()
        modelTest()
        businessLogicTest()
    }
    
    
    func businessLogicTest() {
        let urlToHandleOriginalIMP: URL = URL(string:"successURL://")!
        let objectToSwizzle = SwizzleMockObject()
        
        let execution: ExecutionClosureType = {url in
            describe("Swizzled closure called", closure: {
                $0.it(url.absoluteString, closure: {
                    try expect(true).to.beTrue()
                })
            })
            if url == urlToHandleOriginalIMP {
                return url
            }
            return nil
        }
        func testModels(execution: @escaping ExecutionClosureType) -> [LNModel] {
            let clss = SwizzleMockObject.self
            return Array(arrayLiteral:
            LNModel(clss:clss, selector: #selector(SwizzleMockObject.test1(URL:)),
                         execution: execution),
            LNModel(clss:clss,
                          selector:#selector(SwizzleMockObject.test2(_:URL:)),
                                      execution: execution),
            LNModel(clss:clss,selector: #selector(SwizzleMockObject.test3(_:URL:_:)),
                          execution: execution),
            LNModel(clss:clss, selector:#selector(SwizzleMockObject.test4(_:_:URL:_:)),
                          execution: execution),
                LNModel(clss:clss, selector:#selector(SwizzleMockObject.succesTest4(_:_:URL:_:)),
                             execution: execution)
            )}
        
        let models = testModels(execution: execution)
        for model in models {
            Linker.swizzleFunc(clss: model.clss.self, selector: model.selector, execution: model.execution as Any)
        }
        
        objectToSwizzle.test1(URL: URL(string: "swizzleWith1parameter://")!)
        objectToSwizzle.test2(nil, URL: URL(string: "swizzleWith2parameters://")!)
        objectToSwizzle.test3(nil,URL: URL(string: "swizzleWith3parameters://")!, nil);
        objectToSwizzle.test4(nil, nil, URL: URL(string: "swizzleWith4parameters://")!, nil)
        objectToSwizzle.succesTest4(nil, nil, URL: urlToHandleOriginalIMP, nil)
    }
    
    func utilsTest() {
        describe("Utils") {
            $0.it("func parse bad selector", closure: {
                let selector = NSSelectorFromString("badSelector")
                try expect(selector.argumentsCount()) == 0
                try expect(selector.indexOfArgument(withName: "URL")).beNil()
            })
            $0.it("func parse good selector", closure: {
                let selector = NSSelectorFromString("application:openURL:sourceApplication:annotation:")
                try expect(selector.argumentsCount()) == 4
                try expect(selector.indexOfArgument(withName: "annotation")) == 3
            })
        }
    }
    
    func modelTest() {
        
        describe("Application Model Test") {
            $0.it("UIApplication openURL:", closure: {
                let clss = ApplicationMock.self
                
                let selector = NSSelectorFromString("openURL:")
                let execution: ExecutionClosureType = {url in
                    return url
                }
                let model = LNModel(clss: clss, selector: selector, execution: execution)

                try expect(model.selector) == selector
                try expect(model.clss).to.beOfType(type(of: clss))
                try expect(expression: { () -> Bool in
                    model.execution != nil ? true : false
                }) == true
            })
            
            $0.it("UIApplication openURL:options:completionHandler:", closure: {
                let clss = ApplicationMock.self
                let selector = NSSelectorFromString("openURL:options:completionHandler:")
                let execution: ExecutionClosureType = {url in
                    return url
                }
                let model = LNModel(clss: clss, selector: selector, execution: execution)
                
                try expect(model.selector) == selector
                try expect(model.clss).to.beOfType(type(of: clss))
                try expect(expression: { () -> Bool in
                    model.execution != nil ? true : false
                }) == true
            })
        }
        
        describe("Application Delegate Model Test", closure: {
            $0.it("UIApplicationDelegate application:openURL:options:", closure: {
                
                let clss = AppDelegateMock.self
                let selector = NSSelectorFromString("application:openURL:options:")
                let execution: ExecutionClosureType = {url in
                return url
                }
                let model = LNModel(clss: clss, selector: selector, execution: execution)
                
                try expect(model.selector) == selector
                try expect(model.clss).to.beOfType(type(of: clss))
                try expect(expression: { () -> Bool in
                    model.execution != nil ? true : false
                }) == true
                })
            
            $0.it("UIApplicationDelegate application:openURL:sourceApplication:annotation:", closure: {
                
                let clss = AppDelegateMock.self
                let selector = NSSelectorFromString("application:openURL:sourceApplication:annotation:")
                let execution: ExecutionClosureType = {url in
                    return url
                }
                let model = LNModel(clss: clss, selector: selector, execution: execution)
                
                try expect(model.selector) == selector
                try expect(model.clss).to.beOfType(type(of: clss))
                try expect(expression: { () -> Bool in
                    model.execution != nil ? true : false
                }) == true
            })
            $0.it("UIApplicationDelegate application:handleOpenURL:", closure: {
                
                let clss = AppDelegateMock.self
                let selector = NSSelectorFromString("application:handleOpenURL:")
                let execution: ExecutionClosureType = {url in
                    return url
                }
                let model = LNModel(clss: clss, selector: selector, execution: execution)
                
                try expect(model.selector) == selector
                try expect(model.clss).to.beOfType(type(of: clss))
                try expect(expression: { () -> Bool in
                    model.execution != nil ? true : false
                }) == true
            })
        })
    }
}
