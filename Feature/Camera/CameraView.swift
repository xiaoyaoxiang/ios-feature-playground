//
//  CameraView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//
import SwiftUI

struct CameraView: UIViewControllerRepresentable {

    var onComplete: (SnapItem) -> Void

    func makeUIViewController(context: Context) -> CameraViewController {
        let vc = CameraViewController()
        vc.onCapture = onComplete
        return vc
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}
