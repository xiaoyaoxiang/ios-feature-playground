//
//  ProfileViewModel.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/12.
//

import Combine
import Foundation

@MainActor
class ProfileViewModel: ObservableObject {

    @Published var profile: Profile?
    @Published var isLoading = false

    private var fetchTask: Task<Void, Never>?  // 当前请求

    func fetchProfile() {

        // 取消旧请求（关键）
        fetchTask?.cancel()

        fetchTask = Task {
            await loadProfile()
        }
    }

    private func loadProfile() async {

        guard let url = URL(string: "http://192.168.2.110:8082/profile") else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            var request = URLRequest(url: url)
            request.addAuthHeader()

            let (data, response) = try await URLSession.shared.data(for: request)


            let result = try JSONDecoder().decode(ProfileResponse.self, from: data)

            // UI更新
            self.profile = result.data

        } catch {
            if (error as? URLError)?.code == .cancelled {
                return
            }
            print("请求失败:", error)
        }
    }
}

