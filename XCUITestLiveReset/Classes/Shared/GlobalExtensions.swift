//
//  GlobalExtensions.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/4/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation

var LIVE_RESET_VERSION: String {
    guard let version = Bundle(identifier: "org.cocoapods.XCUITestLiveReset")?.infoDictionary?["CFBundleShortVersionString"] as? String else { return "0.0.0" }
    return version
}

public enum SharedKey {
    static let NetServiceName = "NetServiceName"
    static let LiveResetVersion = "LiveResetVersion"
    static let NetServicePrefix = "com.darrenlai.grpc"
}

extension String {
    public var fileURL: URL {
        URL(fileURLWithPath: self)
    }

    public var lastPathComponent: String {
        get { fileURL.lastPathComponent }
    }
}

@propertyWrapper
public struct DelayedMutable<Value> {
    public typealias Factory = () -> Value
    private var _value: Value? = nil
    private var _factory: Factory? = nil

    public var wrappedValue: Value {
        mutating get {
            guard let value = _value else {
                if let newValue = _factory?() {
                    _value = newValue
                    return newValue
                } else {
                    fatalError("property accessed before being initialized")
                }
            }
            return value
        }
        mutating set {
            _factory = { newValue }
        }
    }

    public init() {}
    public init(_ factory: Factory?) {
        _factory = factory
    }

    public mutating func set(Factory factory: Factory?) {
        _factory = factory
    }

    public mutating func reset() {
        _value = nil
    }
}

@_functionBuilder
public struct DescriptionBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }

    static func buildExpression(_ expression: @autoclosure () -> String) -> String {
        expression()
    }

    static func buildExpression(_ expression: [String]) -> String {
        expression.joined(separator: "\n")
    }
}

public extension Dictionary {
    /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
    /// values of the keys that are already set
    ///
    /// - parameter dictionaries: A comma seperated list of dictionaries
    mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
}
