//
//  Transaction.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

enum Transaction {
    case creation(account: String, value: Int)
    case exchange(from: String, to: String, value: Int)
    case value(of: String)
}

extension Transaction {
    static let creationDescription = "creation"
    static let additionDescription = "addition"
    static let subtractionDescription = "subtraction"
    static let exchangeDescription = "exchange"
    static let valueDescription = "value"
    
    static func isValueTransaction(input: String) -> Bool {
        return [valueDescription, creationDescription].contains(input)
    }
}

extension Transaction: CustomStringConvertible {
    var description: String {
        switch self {
        case .creation: return Transaction.creationDescription
        case .exchange: return Transaction.exchangeDescription
        case .value: return Transaction.valueDescription
        }
    }
}
