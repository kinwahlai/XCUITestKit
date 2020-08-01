//
//  NetServiceWrapper.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/1/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation

final public class NetServiceHost: NSObject {
    private let _service: NetService
    var completion: NetServiceCompletion?

    public init(domain: String = "local.", type: String = "_grpc._tcp.", name: String) {
        _service = NetService(domain: domain, type: type, name: name)
        super.init()
        _service.delegate = self
    }

    public func broadcast(completion: NetServiceCompletion? = nil) {
        self.completion = completion
        _service.publish(options: .listenForConnections)
    }

    deinit {
        print("👉 deinit \(#file.lastPathComponent)")
        shutdown()
    }

    public func shutdown() {
        _service.stop()
    }
}

extension NetServiceHost: NetServiceDelegate {
    public func netServiceDidPublish(_ sender: NetService) {
        completion?(.success(sender.port))
    }
    public func netService(_ sender: NetService, didNotPublish errorDict: [String: NSNumber]) {
        completion?(.failure(.notPublish(errorDict)))
    }
}


