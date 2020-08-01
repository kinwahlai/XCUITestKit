//
//  AppDelegate.swift
//  XCUITestKit
//
//  Created by Darren Lai on 07/01/2020.
//  Copyright (c) 2020 Darren Lai. All rights reserved.
//

import UIKit
import XCUITestLiveReset

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let _ = ProcessInfo.processInfo.environment["NetServiceName"] {
            LiveResetHost.shared.delegate = self
            LiveResetHost.shared.start()
            reset()
        } else {
            reset()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: LiveResetHostDelegate {
    func didReceiveReset() {
        reset()
    }
    
    func didReceiveSettings(_ setttings: ServiceSettings) {
        print("received settings")
    }
    
    
    @available(iOS 13.0, *)
    @discardableResult
    func replaceWindow(_ windowScene: UIWindowScene? = nil) -> UIWindow {
        let main = UIStoryboard(name: "Main", bundle: nil)
        main.instantiateInitialViewController()
        let window: UIWindow
        if let scene = windowScene {
            window = UIWindow(frame: scene.coordinateSpace.bounds)
            window.windowScene = scene
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        window.rootViewController = main.instantiateInitialViewController()
        window.makeKeyAndVisible()
        return window
    }
}

// Credit to Kassem Wridan: https://www.matrixprojects.net/p/live-reset-for-ui-testing/
extension AppDelegate {
    func reset() {
        tearDown()
        
//        Make and create AppDependencies if needed
        
        if #available(iOS 13.0, *) {
            window = injectNewRootViewController(to: createWindow(withScene: nil))
        } else {
            window = injectNewRootViewController(to: createWindow())
        }
    }

    func tearDown() {
        window?.rootViewController = nil
        window?.isHidden = true
        window = nil
    }

    @available(iOS 13.0, *)
    func createWindow(withScene windowScene: UIWindowScene? = nil) -> UIWindow {
        let window: UIWindow
        if let scene = windowScene {
            window = UIWindow(frame: scene.coordinateSpace.bounds)
            window.windowScene = scene
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        return window
    }
    
    func createWindow() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    func injectNewRootViewController(to window: UIWindow) -> UIWindow {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        window.makeKeyAndVisible()
        return window
    }
}
