//
//  LiveResetProvider.swift
//  XCUITestLiveReset-Base-Host
//
//  Created by Darren Lai on 7/26/20.
//

import Foundation
import NIO
import GRPC

protocol CallHandlerForwarder: class {
    // TODO: use Combine for subscribe?
    func didReceiveReset()
    func didReceiveSettings(_ setttings: ServiceSettings)
}

class LiveResetProvider {
    weak var delegate: CallHandlerForwarder?
    
    init(delegate: CallHandlerForwarder) {
        self.delegate = delegate
    }
}

extension LiveResetProvider: XCUITestKit_LiveResetProvider {
    func heartbeat(request: XCUITestKit_Echo, context: StatusOnlyCallContext) -> EventLoopFuture<XCUITestKit_Echo> {
        print("heartbeat check received -> \(request.message)")
        let response = XCUITestKit_Echo.with { $0.message = request.message }
        print("heartbeat response sent")
        return context.eventLoop.makeSucceededFuture(response)
    }
    
    func configure(request: XCUITestKit_Settings, context: StatusOnlyCallContext) -> EventLoopFuture<XCUITestKit_Ack> {
        let settings: ServiceSettings = ServiceSettings(request.setting)
        delegate?.didReceiveSettings(settings)
        let response = XCUITestKit_Ack.with { $0.message = "accepted" }
        return context.eventLoop.makeSucceededFuture(response)
    }
    
    func reset(request: XCUITestKit_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<XCUITestKit_Ack> {
        DispatchQueue.main.sync {
            delegate?.didReceiveReset()
        }
        print("GRPC reset call accepted in host")
        let response = XCUITestKit_Ack.with { $0.message = "accepted" }
        return context.eventLoop.makeSucceededFuture(response)
    }
}
