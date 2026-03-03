//
//  APIClient.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation

enum AuthError: Error {
    case tokenExpired
    case missingToken
    case invalidCredentials
}

enum NetworkError: Error {
    case serverError(Int)   // 服务器错误码
    case unknownError       // 其他错误
    case timeout            // 请求超时
}

final class APIClient {

    static let shared = APIClient()

    private init() {}

    func request<T: Decodable>(
        endpoint: Endpoint,
        type: T.Type
    ) async throws -> T {

        var request = endpoint.urlRequest

        if let token = TokenManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }

        if http.statusCode == 401 {
            throw AuthError.tokenExpired
        }

        guard 200..<300 ~= http.statusCode else {
            throw NetworkError.serverError(http.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
