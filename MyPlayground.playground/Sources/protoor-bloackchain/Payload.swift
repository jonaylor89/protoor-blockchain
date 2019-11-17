//
//  Payload .swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

public struct Payload {
    public let value: Int
    public let account: String
}

extension Payload: Codable {}

extension Payload: CustomStringConvertible {
    public var description: String {
        return string
    }
}

extension Payload: Equatable {}

public func == (lhs: Payload, rhs: Payload) -> Bool {
    return lhs.description == rhs.description
}
