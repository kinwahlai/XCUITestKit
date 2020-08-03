//
//  main.swift
//  XCUITestKit_Example
//
//  Created by Darren Lai on 8/3/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

/// ref: https://marcosantadev.com/fake-appdelegate-unit-testing-swift/

var appDelegateClass: String = ""

if #available(iOS 13.0, *) {
    appDelegateClass = NSStringFromClass(AppDelegateWithScene.self)
} else {
    appDelegateClass = NSStringFromClass(AppDelegate.self)
}

let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
