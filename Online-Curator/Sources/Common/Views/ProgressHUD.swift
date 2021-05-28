//
//  ProgressHUD.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 24.05.2021.
//

import SwiftUI

struct ProgressHUD: View {
    private let opacity: Double
    private let padding: CGFloat
    private let cornerRadius: CGFloat

    init(
        opacity: Double = 0.2,
        padding: CGFloat = 18,
        cornerRadius: CGFloat = 10
    ) {
        self.opacity = opacity
        self.padding = padding
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        ZStack {
            Color.black.opacity(opacity)
            ProgressView()
                .padding(padding)
                .background(Color.white)
                .cornerRadius(cornerRadius)
        }
    }
}
