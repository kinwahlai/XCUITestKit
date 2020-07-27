//
//  NetServiceExtension.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation

public typealias NetServiceCompletion = ((Result<Int, NetServiceError>) -> Void)

public enum NetServiceError: Error {
    case notResolve([String: NSNumber])
    case notPublish([String: NSNumber])
    case unknownError
}

public enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case error(Failure)
}
