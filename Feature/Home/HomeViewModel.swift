//
//  HomeViewModel.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//
import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var items: [SnapItem] = []
    @Published var showCamera = false

    func add(_ item: SnapItem) {
        items.insert(item, at: 0)
    }
}
