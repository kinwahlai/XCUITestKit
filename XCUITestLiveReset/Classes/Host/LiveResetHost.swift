//
//  LiveResetHost.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation
import NIO
import GRPC

public enum LiveResetHostError: Error {
    case serverFailedToStart
}

public protocol LiveResetHostDelegate: class { // implement by class that will handle the reset
        func didReceiveReset()
        func didReceiveSettings(_ setttings: ServiceSettings)
}

public class LiveResetHost {
    public var defaultTimeout: Double = 10.0
    public weak var delegate: LiveResetHostDelegate?
    
    private(set) var port: Int = 0
    
    @DelayedMutable
    private var netServiceHost: NetServiceHost
    
    @DelayedMutable({ LiveResetHost() })
    public static var shared: LiveResetHost
    
    @DelayedMutable
    private var grpcHost: gRPCHost
    
    private(set) var netServiceName: String = "defaultName"
    
    internal var netServiceBroadcasted: Bool = false
    
    private init() {
        if let bonjourName = ProcessInfo.processInfo.environment["netServiceName"] {
            self.netServiceName = bonjourName
        }
        _grpcHost.set { [unowned self] () -> gRPCHost in
            gRPCHost(port: self.port, callHandler: LiveResetProvider(delegate: self))
        }
        _netServiceHost.set { [unowned self] () -> NetServiceHost in
            NetServiceHost(name: self.netServiceName)
        }
        
        
    }
    
    deinit {
        print("👉 deinit \(#file.lastPathComponent)")
    }
    
    public func shutdown(_ error: Error? = nil) {
        print(error.debugDescription)
    }
    
    public func start() {
        guard netServiceBroadcasted == false && port == 0 else {
            return
        }
        broadcast(timeout: defaultTimeout)
        waitForServerReady()
    }
    
    private func broadcast(timeout: Double) {
        netServiceHost.broadcast { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .success(let port):
                    self.netServiceBroadcasted = true
                    self.port = port
                    print(">>>>>>>>>>> port \(self.netServiceName)")
                    print(">>>>>>>>>>> port \(self.port)")
                    self.acceptRequest()
                case .error(let err):
                    print("Failed to resolve NetService \(err.localizedDescription)")
                    // FIXME: how to handle this?
                    // Shutdown?
            }
        }
    }
    
    private func acceptRequest() {
        grpcHost.acceptRequest()
    }
    
    private func waitForServerReady() {
        for _ in (0..<Int(defaultTimeout)) {
            if netServiceBroadcasted, grpcHost.isServerStarted {
                return
            }
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
        }
        // host is not ready, it is a fatal error
        shutdown(LiveResetHostError.serverFailedToStart)
    }
}


extension LiveResetHost: CallHandlerForwarder {
    func didReceiveReset() {
        delegate?.didReceiveReset()
    }
    
    func didReceiveSettings(_ setttings: ServiceSettings) {
        delegate?.didReceiveSettings(setttings)
    }
    
    
}
