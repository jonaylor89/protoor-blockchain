//
//  Client.swift
//  
//
//  Created by John Naylor on 11/16/19.
//

import Foundation

protocol Client {
    var server: Server { get }
    var queue: DispatchQueue { get }
}

extension Client {
    func fetch(url string: String,
               method: String = "GET",
               body: Any? = nil,
               latency: UInt32 = 0,
               resolve: Resolution? = nil) {
        guard let url = URL(string: string) else { return }
        
        queue.asyncAfter(deadline: DispatchTime.now + DispatchTimeInterval.seconds(Int(latency))) {
            let request = URLRequest(url: url)
            request.httpMethod = method
            
            if let body = body, let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
                request.httpBody = data
            }
            
            return request
        }()
        
        self.server.execute(request: request, resolve: resolve)
    }
}
