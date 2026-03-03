//
//  Endpoint.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation

struct Endpoint {

    let path: String
    let method: String
    let body: Data?

    var urlRequest: URLRequest {
        var request = URLRequest(
            url: URL(string: "http://192.168.2.129:8082\(path)")!
        )
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
