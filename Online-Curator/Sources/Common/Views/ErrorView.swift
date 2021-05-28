//
//  ErrorView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 26.05.2021.
//

import SwiftUI

struct ErrorView: View {
    private let message: String
    private let action: () -> Void

    init(
        message: String,
        action: @escaping () -> Void
    ) {
        self.message = message
        self.action = action
    }

    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "exclamationmark.icloud")
                .font(.system(size: 50))
            Text(message)
                .fontWeight(.semibold)
            ActionButton(title: "Попробоавть еще", width: 200, action: action)
        }
    }
}
