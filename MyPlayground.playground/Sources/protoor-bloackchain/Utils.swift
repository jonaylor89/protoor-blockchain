//
//  Utils.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

// This extension will allow us to take a look at a string encoding
// of a data object
extension Data {
    func toString(encoding: String.Encoding = .utf8) -> String {
        return String(data: self, encoding: encoding) ?? ""
    }
}

// This extension will prevent us from having to recreate the
// JSONEncode and writing the encoding mechanism each time
extension Encodable {
    var encoded: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var string: String {
      return String(describing: encoded?.toString())
    }
    
    var json: Any? {
        guard let data = encoded else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
}
