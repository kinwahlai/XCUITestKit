//
//  gRPCHost.swift
//  XCUITestLiveReset-Base-Host
//
//  Created by Darren Lai on 7/27/20.
//

import Foundation
import NIO
import GRPC

class gRPCHost {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    @DelayedMutable
    private var server: EventLoopFuture<Server>
    private(set) var isServerStarted: Bool = false
    
    init(port: Int, callHandler: CallHandlerProvider) {
        _server.set { [unowned self] () -> EventLoopFuture<Server> in
            Server.insecure(group: self.group).withServiceProviders([callHandler])
                .bind(host: "localhost", port: port)
        }
    }
    
    deinit {
        print(("👉 deinit \(#file.lastPathComponent)"))
        shutdown()
    }
    
    func shutdown() {
        try! server.eventLoop.syncShutdownGracefully()
        try! group.syncShutdownGracefully()
    }
    
    func acceptRequest() {
        server.map {
            $0.channel.localAddress
        }.whenSuccess { [weak self] address in
            print("server started on port \(address!.port!)")
            self?.isServerStarted = true
        }
    }
}
