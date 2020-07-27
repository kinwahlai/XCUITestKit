//
//  LiveResetClient.swift
//  GRPC_Bonjour_LiveResetUITests
//
//  Created by Darren Lai on 7/3/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation
import XCTest
import NIO
import GRPC
import Combine

public protocol LiveResetClientDelegate: class { // implement by XCTest class
    func clientShutdown(withFatalError error: Error)
    func clientOperationFailed(withError error: Error)
}

public enum LiveResetClientError: Error {
    case hostOrAppNotReady
}

public class LiveResetClient {
    // configurable values
    public weak var delegate: LiveResetClientDelegate?
    public weak var app: XCUIApplication!
    public var defaultTimeout: Double = 10.0

    @DelayedMutable
    public var netServiceName: String

//    singleton to make the client instance stay over multiple test suites
    @DelayedMutable({ LiveResetClient() })
    public static var shared: LiveResetClient
    
    @DelayedMutable
    private var netServiceClient: NetServiceClient
    
    @DelayedMutable
    private var grpcClient: gRPCCLient
    
    internal var netServiceResolved: Bool = false
    private var sharedInstanceConfigured: Bool = false
    private(set) var port: Int = 0
    private let group: EventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    
    private init() {
        _netServiceName.set {
            String.init(format: "com.darrenlai.grpc.%d.%.0f",  ProcessInfo.processInfo.processIdentifier, Date().timeIntervalSince1970 * 100_000)
        }
        _netServiceClient.set { [unowned self] in
            NetServiceClient(name: self.netServiceName)
        }
        _grpcClient.set { [unowned self] in
            gRPCCLient(port: self.port, group: self.group)
        }
    }
    
    deinit {
        print(("👉 deinit \(#file.lastPathComponent)"))
        do {
            try group.syncShutdownGracefully()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func shutdown(_ error: Error? = nil) {
        netServiceClient.shutdown()
        grpcClient.shutdown()
        if let error = error {
            delegate?.clientShutdown(withFatalError: error)
        }
        resetState()
    }

    private func resetState() {
        netServiceResolved = false
        sharedInstanceConfigured = false
        port = 0
        _grpcClient.reset()
        _netServiceClient.reset()
        _netServiceName.reset()
    }
    
    public func resetOrLaunch() {
        precondition(delegate != nil, "Delegate must be there to accept ready to launch call")
        if netServiceResolved == false {
            resolve(timeout: defaultTimeout)
            app.launch()
            waitForHostReady()
        } else {
            waitForHostReady()
            reset()
        }
    }
    
    func configureInstance(withConfiguration config: LiveResetClientConfiguration) {
        if !sharedInstanceConfigured || config.reconfigureSharedInstance {
            config.app.launchArguments.append(contentsOf: config.launchArguments)
            config.launchEnvironment.forEach({ config.app.launchEnvironment[$0] =  $1 })
            config.app.launchEnvironment["netServiceName"] = netServiceName
            app = config.app
            delegate = config.delegate
            defaultTimeout = config.defaultTimeout
            sharedInstanceConfigured = true
        }
    }
    
    private func waitForHostReady() {
        for _ in (0..<Int(defaultTimeout)) {
            if netServiceResolved, grpcClient.isConnectionEstablished {
                return
            }
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
        }
        // host is not ready, it is a fatal error
        shutdown(LiveResetClientError.hostOrAppNotReady)
    }
    
    private func resolve(timeout: Double) {
        netServiceClient.resolve(timeout: timeout) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .success(let port):
                    self.netServiceResolved = true
                    self.port = port
                    print(">>>>>>>>>>> port \(self.netServiceName)")
                    print(">>>>>>>>>>> port \(self.port)")
                case .error(let err):
                    print("Failed to resolve NetService \(err.localizedDescription)")
                    self.delegate?.clientShutdown(withFatalError: err)
            }
        }
    }
    
    private func reset() {
        precondition(netServiceResolved == true, "NetService resolve must be called first")
        switch grpcClient.reset() {
            case .success(let message):
                print("Reset operation completed \(message)")
            case .error(let err):
                print("gRPC Reset operation failed \(err.localizedDescription)")
                self.delegate?.clientOperationFailed(withError: err)
        }
    }
    
    // MARK: - Client Operations
    public func configure(settings: ServiceSettings) {
        precondition(netServiceResolved == true, "NetService resolve must be called first")
        switch grpcClient.configure(settings: settings) {
            case .success(let message):
                print("Configure operation completed \(message)")
            case .error(let err):
                print("gRPC Configure operation failed \(err.localizedDescription)")
                self.delegate?.clientOperationFailed(withError: err)
        }
    }
}

extension LiveResetClient: CustomDebugStringConvertible {
    @DescriptionBuilder public var debugDescription: String {
        "LiveResetClient:"
        "==================="
        "NetService resolved: \(netServiceResolved)"
        "NetService name: \(netServiceName)"
        "Port operate on: \(port)"
        "Default timeout: \(defaultTimeout)"
        "XCUIApplication set: \(app != nil)"
        "Delegate set: \(delegate != nil)"
        "==================="
    }
}
