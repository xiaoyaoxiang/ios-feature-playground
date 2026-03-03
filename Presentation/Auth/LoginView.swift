//
//  LoginView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/13.
//
import SwiftUI

struct LoginView: View {

    @State private var username = ""
    @State private var password = ""

    @State private var loading = false
    @State private var errorMessage: String?

    let service = AuthService()

    var body: some View {
        VStack(spacing: 20) {

            Text("登录")
                .font(.largeTitle)

            TextField("用户名", text: $username)
                .textFieldStyle(.roundedBorder)

            SecureField("密码", text: $password)
                .textFieldStyle(.roundedBorder)

            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button {
                login()
            } label: {
                if loading {
                    ProgressView()
                } else {
                    Text("登录")
                }
            }
        }
        .padding()
    }

    func login() {
        loading = true

        Task {
            do {
                let result = try await service.login(
                    username: username,
                    password: password
                )

                AuthManager.shared.saveToken(result)

            } catch {
                errorMessage = "登录失败"
            }
            loading = false
        }
    }
}
