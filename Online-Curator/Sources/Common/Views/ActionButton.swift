//
//  CommonViews.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 26.05.2021.
//

import SwiftUI

struct ActionButton: View {
    private let title: String
    private let width: CGFloat
    private let action: () -> Void

    init(
        title: String,
        width: CGFloat,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.width = width
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.heavy)
                .padding()
        }
        .frame(width: width)
        .background(Color("ButtonBackgroundColor"))
        .foregroundColor(Color.white)
        .cornerRadius(10)
    }
}
