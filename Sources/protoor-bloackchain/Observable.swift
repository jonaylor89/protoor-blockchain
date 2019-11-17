//
//  Observable.swift
//  protoor-bloackchain
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

protocol Observable {
    static var observers: [String [String: Observer]] { get set }
    var identifier: String { get }
}

extension Observable {
    var observers: [String: Observer]? {
        if let owned = Self.observers[identifier] {
            return owned
        }
        Self.observers.updateValue([:], forKey: identifier)
        
        return Self.observers[identifier]
    }
}

extension Observable {
    func register(observer: Observer, forKey: String) {
        if var current = observers {
            current.updateValue(observer, forKey: key)
            Self.observers.updateValue(current, forKey: identifier)
        } else {
            Self.observers.updateValue([key: observer], forKey: identifier)
        }
    }
    
    func deregister(withKey key: String) {
        if var current = observers {
            current.removeValue(forKey: key)
            Self.observers.updateValue(current, forKey: identifier)
        }
    }
}

extension Observable {
    func notify(withData data: Any?) {
        observers?.values.forEach { $0.didUpdate(withData: data) }
    }
}
