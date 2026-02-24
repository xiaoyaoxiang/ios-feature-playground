//
//  AuthService.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/13.
//
import Combine
import Foundation

class AuthService {

    func login(username: String, password: String) async throws -> AuthResponse {

        let url = URL(string: "http://192.168.2.110:8082/login")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = [
            "username": username,
            "password": password
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        // ⭐ 必须检查
        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("status:", http.statusCode)
        print("response:", String(data: data, encoding: .utf8) ?? "")

        guard http.statusCode == 200 else {
            throw NSError(domain: "Login failed", code: http.statusCode)
        }

        return try JSONDecoder().decode(AuthResponse.self, from: data)
    }
}

