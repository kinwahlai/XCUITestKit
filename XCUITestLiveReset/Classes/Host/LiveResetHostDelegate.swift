//
//  LiveResetHostDelegate.swift
//  XCUITestLiveReset-Base-Host
//
//  Created by Darren Lai on 8/3/20.
//

import UIKit

// implement by class that replace the RootViewController and UIWindow, either AppDelegate, SceneDelegate
public protocol LiveResetHostDelegate: AnyObject {
    var window: UIWindow? { get set }
    func didReceiveReset()
}

// Credit to Kassem Wridan: https://www.matrixprojects.net/p/live-reset-for-ui-testing/
extension LiveResetHostDelegate {
    // MARK: helper funtions

    public func tearDown() {
        window?.rootViewController = nil
        window?.isHidden = true
        window = nil
    }

    @available(iOS 13.0, *)
    public func createWindow(withScene windowScene: UIWindowScene?) -> UIWindow {
        let window: UIWindow
        if let scene = windowScene {
            window = UIWindow(frame: scene.coordinateSpace.bounds)
            window.windowScene = scene
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        return window
    }

    public func createWindow() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
}
