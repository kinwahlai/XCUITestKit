//
//  gRPCHost.swift
//  XCUITestLiveReset-Base-Host
//
//  Created by Darren Lai on 7/27/20.
//

import Foundation
import GRPC
import NIO

// swiftlint:disable:next type_name
class gRPCHost {
    @DelayedMutable
    private var server: EventLoopFuture<Server>
    private(set) var isServerStarted: Bool = false

    init(port: Int, callHandler: CallHandlerProvider, group: EventLoopGroup) {
        _server.set { () -> EventLoopFuture<Server> in
            Server.insecure(group: group).withServiceProviders([callHandler])
                .bind(host: "localhost", port: port)
        }
    }

    deinit {
        print("👉 deinit \(#file.lastPathComponent)")
        shutdown()
    }

    func shutdown() {}

    func acceptRequest() {
        server.map {
            $0.channel.localAddress
        }.whenSuccess { [weak self] address in
            print("server started on port \(address!.port!)")
            self?.isServerStarted = true
        }
    }
}
