//
//  Cancellable+iOS12.swift
//  Pods
//
//  Created by Darren Lai on 8/3/20.
//

import Foundation

@available(iOS, deprecated: 14.0, obsoleted: 14.2, message: "Replace with Published from Combine framework after iOS 14 released")
open class Cancellable {
    private var closure: (() -> Void)?

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    deinit {
        cancel()
    }

    func cancel() {
        closure?()
        closure = nil
    }
}

open class CollectionBag {
    private var cancellables: [Cancellable] = []

    public init() {}

    deinit {
        empty()
    }

    public func addCancellable(_ cancellable: Cancellable...) {
        cancellables.append(contentsOf: cancellable)
    }

    public func empty() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
        cancellables.removeAll()
    }
}
