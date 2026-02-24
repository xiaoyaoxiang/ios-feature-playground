//
//  CameraViewController.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//
import UIKit

final class CameraViewController: UIViewController {

    var onCapture: ((SnapItem) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // 下一步：接 AVCaptureSession
    }
}
