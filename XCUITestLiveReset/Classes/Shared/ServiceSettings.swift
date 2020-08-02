//
//  ServiceSettings.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/3/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation

public struct ServiceSettings {

    public typealias DictionaryType = [String: ValueTypes]

    private var contents = DictionaryType()

    init() {}

    init(contents: DictionaryType) {
        self.contents = contents
    }
}

extension ServiceSettings: Collection {
    public typealias Index = DictionaryType.Index
    public typealias Element = DictionaryType.Element

    public var startIndex: DictionaryType.Index { contents.startIndex }
    public var endIndex: DictionaryType.Index { contents.endIndex }

    public subscript(position: DictionaryType.Index) -> DictionaryType.Element {
        precondition(indices.contains(position), "out of bounds")
        return contents[position]
    }

    public func index(after i: Index) -> Index {
        return contents.index(after: i)
    }
}

extension ServiceSettings {
    subscript(key: String) -> String {
        get {
            if case .stringValue(let v)? = contents[key] {return v}
            return String()
        }
        set { contents[key] = .stringValue(newValue)}
    }

    subscript(key: String) -> Int {
        get {
            if case .intValue(let v)? = contents[key] {return v}
            return 0
        }
        set { contents[key] = .intValue(newValue)}
    }

    subscript(key: String) -> Double {
        get {
            if case .doubleValue(let v)? = contents[key] {return v}
            return 0
        }
        set { contents[key] = .doubleValue(newValue)}
    }

    subscript(key: String) -> Bool {
        get {
            if case .boolValue(let v)? = contents[key] {return v}
            return false
        }
        set { contents[key] = .boolValue(newValue)}
    }
}

extension ServiceSettings: ExpressibleByDictionaryLiteral {
    public typealias Key = String
    public typealias Value = ValueTypes

    public init(dictionaryLiteral elements: (String, ValueTypes)...) {
        for (key, value) in elements {
            contents[key] = value
        }
    }
}

// GRPC - XCUITestKit_OneOf specify
extension ServiceSettings {
    init(_ input: [String: XCUITestKit_OneOf]) {
        input.forEach { key, value in
            if let valid = ValueTypes(value) {
                contents[key] = valid
            } else {
                print("Failed to convert to ValueTypes from GRPC type \(value.debugDescription)")
            }
        }
    }

    public func transform() -> [String: XCUITestKit_OneOf] {
        contents.mapValues({ $0.convert() })
    }
}

extension ServiceSettings: CustomDebugStringConvertible {
    @DescriptionBuilder public var debugDescription: String {
        "ServiceSettings:"
        "==================="
        sorted(by: { $0.key < $1.key }).map { "\($0.key): \($0.value.description)" }
        "==================="
    }
}
