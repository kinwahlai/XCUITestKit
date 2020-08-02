//
//  LiveResetHost.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation
import GRPC
import NIO

public enum LiveResetHostError: Error {
    case serverFailedToStart
    case liveResetModuleNotAvailble
    case failedToResolvePort

    public var localizedDescription: String {
        switch self {
            case .liveResetModuleNotAvailble:
                return "LiveResetHostDelegate must be set before calling start(), please configure with +[LiveResetHost set]"
            case .serverFailedToStart:
                return "gRPC server failed to start"
            case .failedToResolvePort:
                return "Failed to resolve port with the NetServiceName, please verify the NetServiceName"
        }
    }
}

// implement by class that replace the RootViewController and UIWindow, either AppDelegate, SceneDelegate
public protocol LiveResetHostDelegate: AnyObject {
    func didReceiveReset()
}

public class LiveResetHost {
    private let group: EventLoopGroup
    public var defaultTimeout: Double = 10.0
    public weak var delegate: LiveResetHostDelegate?
    public private(set) var port: Int = 0

    @DelayedMutable
    private var netServiceHost: NetServiceHost

    @DelayedMutable({ LiveResetHost() })
    public static var shared: LiveResetHost

    @DelayedMutable
    private var grpcHost: gRPCHost

    public private(set) var netServiceName: String = "defaultName"

    internal var netServiceBroadcasted: Bool = false

    private var settingsPromise: EventLoopPromise<ServiceSettings>
    public var serviceSettings: EventLoopFuture<ServiceSettings> {
        settingsPromise.futureResult
    }

    private init() {
        group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        settingsPromise = group.next().makePromise()
        if let bonjourName = ProcessInfo.processInfo.environment[SharedKey.NetServiceName] {
            netServiceName = bonjourName
        }
        _grpcHost.set { [unowned self] () -> gRPCHost in
            gRPCHost(port: self.port, callHandler: LiveResetProvider(delegate: self), group: self.group)
        }
        _netServiceHost.set { [unowned self] () -> NetServiceHost in
            NetServiceHost(name: self.netServiceName)
        }
    }

    deinit {
        print("👉 deinit \(#file.lastPathComponent)")
        do {
            try group.syncShutdownGracefully()
        } catch {
            print(error.localizedDescription)
        }
    }

    @discardableResult
    public func startIfAvailable() -> Result<Int, LiveResetHostError> {
        guard LiveResetHost.isAvailable else {
            return .failure(.liveResetModuleNotAvailble)
        }
        guard netServiceBroadcasted == false, port == 0 else {
            return .success(port)
        }
        broadcast(timeout: defaultTimeout)
        return waitForServerReady()
    }

    public func set<T>(_ keyPath: ReferenceWritableKeyPath<LiveResetHost, T>, _ value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }

    private func broadcast(timeout: Double) {
        netServiceHost.broadcast { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let port):
                    self.netServiceBroadcasted = true
                    self.port = port
                    print(">>>>>>>>>>> port \(self.netServiceName)")
                    print(">>>>>>>>>>> port \(self.port)")
                    self.acceptRequest()
                case .failure(let err):
                    print("Failed to resolve NetService \(err.localizedDescription)")
                // FIXME: how to handle this?
                // Shutdown?
            }
        }
    }

    private func acceptRequest() {
        grpcHost.acceptRequest()
    }

    private func waitForServerReady() -> Result<Int, LiveResetHostError> {
        for _ in 0..<Int(defaultTimeout) {
            if netServiceBroadcasted, grpcHost.isServerStarted {
                return .success(port)
            }
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
        }
        // host is not ready, it is a fatal error
        return .failure(.serverFailedToStart)
    }
}

extension LiveResetHost: CallHandlerForwarder {
    func didReceiveReset() {
        delegate?.didReceiveReset()
    }

    func didReceiveSettings(_ setttings: ServiceSettings) {
        settingsPromise.succeed(setttings)
    }
}

extension LiveResetHost {
    public static var isAvailable: Bool {
        guard let serviceName = ProcessInfo.processInfo.environment[SharedKey.NetServiceName],
            let _ = ProcessInfo.processInfo.environment[SharedKey.LiveResetVersion] else { return false }
        return serviceName.hasPrefix(SharedKey.NetServicePrefix)
    }
}
