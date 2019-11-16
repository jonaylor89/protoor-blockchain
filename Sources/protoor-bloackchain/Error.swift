//
//  Error.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

struct Error: Response {
    let Response: String = "ERROR"
    let transaction: String
    let reason: String
}
