//
//  Response.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

protocol Response: Codable, CustomStringConvertible {
    var response: String { get }
    func transact(transaction: Transaction) -> Response
    func create(payload: Payload, transaction: String) -> Response
}

extension Response {
    var description: String {
        return string
    }
}

extension Response {
    func create(payload: Payload, transaction: String) -> Response {
        return self
    }
    
    func transact(transaction: Transaction) -> Response {
        return self
    }
}
