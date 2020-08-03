//
//  RequestHandler.swift
//  XCUITestLiveReset-Base-Host
//
//  Created by Darren Lai on 7/26/20.
//

import Foundation
import GRPC
import NIO

protocol RequestHandlerForwarder: AnyObject {
    func didReceiveReset()
    func didReceiveSettings(_ setttings: ServiceSettings)
}

final class RequestHandler {
    weak var delegate: RequestHandlerForwarder?

    init(delegate: RequestHandlerForwarder) {
        self.delegate = delegate
    }
}

extension RequestHandler: XCUITestKit_LiveResetProvider {
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
