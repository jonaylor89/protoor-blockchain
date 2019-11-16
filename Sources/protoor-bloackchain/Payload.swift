//
//  Payload .swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

import Utils

public struct Payload {
    public let value: Int
    public let account: String
}

extension Payload: Codable {}

extension Payload: CustomStringConvertible {
    var description: String {
        return string
    }
}

extension Payload: Equatable {}

func == (lhs: Payload, rhs: Payload) -> Bool {
    return lhs.description == rhs.description
}
