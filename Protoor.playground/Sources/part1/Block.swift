//
//  Block.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

public struct Block: Codable {
    public let hash = UUID().uuidString;
    public let payload: Payload
    public let transaction: String
    public let previous: String?
    public let index: Int
}


