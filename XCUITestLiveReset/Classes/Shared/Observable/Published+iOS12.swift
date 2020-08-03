//
//  Published+iOS12.swift
//  Pods
//
//  Created by Darren Lai on 8/3/20.
//

import Foundation

/// Thanks to John Sundell
/// https://www.swiftbysundell.com/articles/published-properties-in-swift/

@available(iOS, deprecated: 14.0, obsoleted: 14.2, message: "Replace with Published from Combine framework after iOS 14 released")
@propertyWrapper
public struct Published<Value> {
    public var projectedValue: Published { self }
    public var wrappedValue: Value { didSet { valueDidChange() } }

    private var observations = Reference(value: List<(Value) -> Void>())

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

private extension Published {
    func valueDidChange() {
        for closure in observations.value {
            closure(wrappedValue)
        }
    }
}

extension Published {
    public func observe(with closure: @escaping (Value) -> Void) -> Cancellable {
        // To further mimmic Combine's behaviors, we'll call
        // each observation closure as soon as it's attached to
        // our property:
        closure(wrappedValue)

        let node = observations.value.append(closure)

        return Cancellable { [weak observations] in
            observations?.value.remove(node)
        }
    }
}
