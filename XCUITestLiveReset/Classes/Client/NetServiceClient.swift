//
//  NetServiceClient.swift
//  GRPC_Bonjour_LiveResetUITests
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation

final class NetServiceClient: NSObject {
    private let _service: NetService
    var completion: NetServiceCompletion?
    
    init(domain: String = "local.", type: String = "_grpc._tcp.", name: String) {
        _service = NetService(domain: domain, type: type, name: name)
        super.init()
        _service.delegate = self
    }
    
    func resolve(timeout: Double = 10.0, completion: NetServiceCompletion? = nil) {
        self.completion = completion
        _service.resolve(withTimeout: timeout)
    }
    
    deinit {
        print(("👉 deinit \(#file.lastPathComponent)"))
        shutdown()
    }
    
    func shutdown() {
        _service.stop()
    }
}

extension NetServiceClient: NetServiceDelegate {
    func netServiceDidResolveAddress(_ sender: NetService) {
        completion?(.success(sender.port))
    }
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        completion?(.error(.notResolve(errorDict)))
    }
}
