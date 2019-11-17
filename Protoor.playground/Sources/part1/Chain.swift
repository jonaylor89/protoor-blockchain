//
//  Chain.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

struct Chain {
    let response: String = "SUCCESS"
    fileprivate let chain: [Block]
    
    init(chain: [Block] = []) {
        self.chain = chain
    }
}

extension Chain: CustomStringConvertible {
    var description: String {
        return string
    }
}

extension Chain: Equatable {}

func  == (lhs: Chain, rhs: Chain) -> Bool {
    return lhs.chain.count == rhs.chain.count && lhs.chain.reduce(true, {
        return $0 &&
            rhs.chain[$1.index].hash == $1.hash &&
            rhs.chain[$1.index].payload == $1.payload
    })
}

extension Chain {
  var isValid: Bool {
    return chain.reduce(true) {
      $0 && (
         ($1.index + 1 == chain.count) || chain[$1.index + 1].previous == $1.hash
        )
    }
  }
}

extension Chain {
    func find(account: String) -> Block? {
        for i in stride(from: chain.count - 1, through: 0, by: -1) {
            let block = chain[i]
            if (block.payload.account == account) && Transaction.isValueTransaction(input: block.transaction) {
                
                return block
              }
        }
            
        return nil
    }
}

extension Chain: Response {
    func create(payload: Payload, transaction: String) -> Response {
        guard isValid else {
            return Error(transaction: transaction.description, reason: "status - INVALID")
        }
        var chain = self.chain
        
        chain.append(
            Block(
                payload: payload,
                transaction: transaction,
                previous: chain.last?.hash,
                index: chain.count
            )
        )
        
        return Chain(chain: chain)
    }
    
    func transact(transaction: Transaction) -> Response {
      switch transaction {
      case .creation(account: let account, value: let value):
        if let _ = find(account: account) {
          return Error(transaction: transaction.description,
                       reason: "account '\(account)' already exists")
        }
            return create(
                    payload: Payload(value: chain.count > 0 ? 0 : value,
                    account: account),
                    transaction: Transaction.creationDescription
            )
      case .exchange(from: let from, to: let to, value: let value):
        if (value <= 0) {
          return Error(transaction: transaction.description,
                       reason: "value must be greater than 0")
        }
        if (to == from) {
          return Error(transaction: transaction.description,
                   reason: "account identifiers must not be the same")
        }
        guard let fromAccount = find(account: from) else {
          return Error(transaction: transaction.description,
                  reason: "the from account '\(from)' does not exist")
        }
        if (fromAccount.payload.value < value) {
          return Error(
                    transaction: transaction.description,
                    reason: "the from account does not contain enough credits"
                )
        }
        let toAccount = find(account: to)
        
        return (toAccount != nil ? self : transact(transaction: Transaction.creation(account: to, value: 0)))
           .create(payload: Payload(value: -value, account: from), transaction: Transaction.subtractionDescription)
           .create(payload: Payload(value: value, account: to), transaction: Transaction.additionDescription)
           .create(payload: Payload(value: (toAccount?.payload.value ?? 0) + value, account: to), transaction: Transaction.valueDescription)
           .create(payload: Payload(value: fromAccount.payload.value - value, account: from), transaction: Transaction.valueDescription)
        
      default: return self
      }
    }
}
