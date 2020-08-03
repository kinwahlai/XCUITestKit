//
//  ValueTypes.swift
//  GRPC_Bonjour_LiveReset
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 kinwahlai.com. All rights reserved.
//

import Foundation
// TODO: Proper documentation and generated by Jazzy

public enum ValueTypes {
    case stringValue(String)
    case boolValue(Bool)
    case doubleValue(Double)
    case intValue(Int)
}

extension ValueTypes: Equatable {
    public static func ==(lhs: ValueTypes, rhs: ValueTypes) -> Bool {
        switch (lhs, rhs) {
            case (let .stringValue(lhsString), let .stringValue(rhsString)):
                return lhsString == rhsString
            case (let .boolValue(lhsBool), let .boolValue(rhsBool)):
                return lhsBool == rhsBool
            case (let .doubleValue(lhsDouble), let .doubleValue(rhsDouble)):
                return lhsDouble == rhsDouble
            case (let .intValue(lhsInt), let .intValue(rhsInt)):
                return lhsInt == rhsInt
            default:
                return false
        }
    }
}

extension ValueTypes {
    init?(_ input: XCUITestKit_OneOf) {
        guard let valueTypes = input.types else { return nil }
        switch valueTypes {
            case .boolValue(let b):
                self = .boolValue(b)
            case .doubleValue(let d):
                self = .doubleValue(d)
            case .intValue(let i):
                self = .intValue(Int(i))
            case .stringValue(let s):
                self = .stringValue(s)
        }
    }
}

extension ValueTypes {
    func convert() -> XCUITestKit_OneOf {
        var output: XCUITestKit_OneOf = XCUITestKit_OneOf()
        switch self {
            case .boolValue(let b):
                output.types = .boolValue(b)
            case .doubleValue(let d):
                output.types = .doubleValue(d)
            case .intValue(let i):
                output.types = .intValue(Int32(i))
            case .stringValue(let s):
                output.types = .stringValue(s)
        }
        return output
    }
}

extension ValueTypes: CustomStringConvertible, CustomDebugStringConvertible {
    public var debugDescription: String {
        description
    }

    public var description: String {
        switch self {
            case .boolValue(let b):
                return "\(b)"
            case .doubleValue(let d):
                return "\(d)"
            case .intValue(let i):
                return "\(i)"
            case .stringValue(let s):
                return "\(s)"
        }
    }
}
