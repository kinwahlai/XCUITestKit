//
//  gRPCClient.swift
//  GRPC_Bonjour_LiveResetUITests
//
//  Created by Darren Lai on 7/3/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation
import GRPC
import NIO

// swiftlint:disable:next type_name
enum gRPCOperationError: Error {
    case resetFailed(Error)
    case configureFailed(Error)
    case connectionLost(Error)
}

// swiftlint:disable:next type_name
class gRPCCLient {
    private let client: XCUITestKit_LiveResetClient

    var isConnectionEstablished: Bool {
        if case .success(let result) = heartbeat(), result == .orderedSame {
            return true
        }
        return false
    }

    init(_ host: String = "localhost", port: Int, timeoutInSeconds timeout: Int64 = 10, group: EventLoopGroup) {
        var options = CallOptions()
        options.timeout = GRPCTimeout.seconds(rounding: Int(timeout))
        let channel = ClientConnection.insecure(group: group)
            .connect(host: host, port: port)
        client = XCUITestKit_LiveResetClient(channel: channel, defaultCallOptions: options)
    }

    deinit {
        print("👉 deinit \(#file.lastPathComponent)")
        shutdown()
    }

    func shutdown() {
        client.channel.close().whenSuccess {
            print("Client channel closed success")
        }
    }

    private func heartbeat() -> Result<ComparisonResult, gRPCOperationError> {
        let message: String = String(format: "%.0f", Date().timeIntervalSince1970 * 1_000_000)
        let request = client.heartbeat(XCUITestKit_Echo.with { $0.message = message })
        do {
            let response = try request.response.wait()
            return .success(response.message.compare(message))
        } catch {
            return .failure(.connectionLost(error))
        }
    }

    func reset() -> Result<String, gRPCOperationError> {
        let request = client.reset(XCUITestKit_Empty())
        do {
            let response = try request.response.wait()
            return .success(response.message)
        } catch {
            return .failure(.resetFailed(error))
        }
    }

    func configure(settings: ServiceSettings) -> Result<String, gRPCOperationError> {
        var argument: XCUITestKit_Settings = XCUITestKit_Settings()
        argument.setting = settings.transform()
        let request = client.configure(argument)
        do {
            let response = try request.response.wait()
            return .success(response.message)
        } catch {
            return .failure(.configureFailed(error))
        }
    }
}
