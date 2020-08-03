//
//  ClientConfiguration.swift
//  XCUITestLiveReset-Base-Client
//
//  Created by Darren Lai on 7/27/20.
//

import Foundation
import XCTest

public struct LiveResetClientConfiguration {
    public weak var delegate: LiveResetClientDelegate?
    public weak var app: XCUIApplication!
    public var defaultTimeout: Double = 15.0
    public var reconfigureSharedInstance: Bool = false
    public var launchArguments: [String] = []
    public var launchEnvironment: [String: String] = [:]
}

public struct LiveResetClientBuilder {
    let config: LiveResetClientConfiguration

    public func build() -> LiveResetClient {
        let instance = LiveResetClient()
        instance.configureInstance(withConfiguration: config)
        return instance
    }

    @discardableResult
    public func share() -> LiveResetClient {
        let instance = LiveResetClient.shared
        instance.configureInstance(withConfiguration: config)
        return instance
    }
}

extension LiveResetClient {
    public static func with(_ populator: (inout LiveResetClientConfiguration) -> Void) -> LiveResetClientBuilder {
        var config = LiveResetClientConfiguration()
        populator(&config)
        return LiveResetClientBuilder(config: config)
    }
}
