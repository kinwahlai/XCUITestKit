//
//  EventLoopFuture+DispatchQueue.swift
//  Pods
//
//  Created by Darren Lai on 8/1/20.
//

import Foundation
import NIO


extension EventLoopFuture {
    public func whenSuccess(queue: DispatchQueue, _ callback: @escaping (Value) -> Void) {
        whenSuccess { v in
            queue.async {
                callback(v)
            }
        }
    }

    public func whenComplete(queue: DispatchQueue, _ callback: @escaping (Result<Value, Error>) -> Void) {
        whenComplete { result in
            queue.async {
                callback(result)
            }
        }
    }

    public func always(queue: DispatchQueue, _ callback: @escaping (Result<Value, Error>) -> Void) -> EventLoopFuture<Value> {
        whenComplete(queue: queue, callback)
        return self
    }
}
