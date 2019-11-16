//
//  Block.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

struct Block: Codable {
    let hash: UUID().uuidString()
    let payload: Payload
    let transaction: String
    let previous: String
    let index: Int
}

extension Block: Codable {}


