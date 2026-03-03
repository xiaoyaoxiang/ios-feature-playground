//
//  StatView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/12.
//

import SwiftUI

struct StatView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title2)
                .bold()

            Text(title)
                .foregroundColor(.gray)
        }
    }
}
