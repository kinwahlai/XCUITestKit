//
//  LinkedList.swift
//  Pods
//
//  Created by Darren Lai on 8/3/20.
//

import Foundation

/// Thanks to John Sundell
/// https://www.swiftbysundell.com/articles/combining-value-and-reference-types-in-swift/
public class Reference<Value> {
    var value: Value

    init(value: Value) {
        self.value = value
    }
}

/// Thanks to John Sundell
/// https://www.swiftbysundell.com/articles/picking-the-right-data-structure-in-swift/
struct List<Value> {
    private(set) var firstNode: Node?
    private(set) var lastNode: Node?
}

extension List {
    class Node {
        var value: Value
        fileprivate(set) weak var previous: Node?
        fileprivate(set) var next: Node?

        init(value: Value) {
            self.value = value
        }
    }
}

extension List: Sequence {
    func makeIterator() -> AnyIterator<Value> {
        var node = firstNode

        return AnyIterator {
            // Iterate through all of our nodes by continuously
            // moving to the next one and extract its value:
            let value = node?.value
            node = node?.next
            return value
        }
    }
}

extension List {
    @discardableResult
    public mutating func append(_ value: Value) -> Node {
        let node = Node(value: value)
        node.previous = lastNode

        lastNode?.next = node
        lastNode = node

        if firstNode == nil {
            firstNode = node
        }

        return node
    }
}

extension List {
    public mutating func remove(_ node: Node) {
        node.previous?.next = node.next
        node.next?.previous = node.previous

        // Using "triple-equals" we can compare two class
        // instances by identity, rather than by value:
        if firstNode === node {
            firstNode = node.next
        }

        if lastNode === node {
            lastNode = node.previous
        }

        // Completely disconnect the node by removing its
        // sibling references:
        node.next = nil
        node.previous = nil
    }
}
