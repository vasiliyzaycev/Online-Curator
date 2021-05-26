//
//  RefreshableScrollView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import SwiftUI

struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    private let content: Content
    private let onRefresh: (UIRefreshControl) -> Void
    private let refreshControl: UIRefreshControl

    init(
        @ViewBuilder content: @escaping () -> Content,
        onRefresh: @escaping (UIRefreshControl) -> Void,
        title: String = "Обновление",
        color: UIColor = .red
    ) {
        self.content = content()
        self.onRefresh = onRefresh
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.tintColor = color
        self.refreshControl = refreshControl
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        refreshControl.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.onRefresh),
            for: .valueChanged)
        setupView(scrollView)
        scrollView.refreshControl = refreshControl
        return scrollView
    }

    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        setupView(scrollView)
    }

    func setupView(_ scrollView: UIScrollView) {
        let hostView = UIHostingController(
            rootView: content.frame(maxHeight: .infinity, alignment: .top))
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.subviews.last?.removeFromSuperview()
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints([
            hostView.view.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),
            hostView.view.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor),
            hostView.view.heightAnchor.constraint(
                greaterThanOrEqualTo: scrollView.heightAnchor, constant: 1)])
    }
}

extension RefreshableScrollView {
    class Coordinator: NSObject {
        var parent: RefreshableScrollView

        init(parent: RefreshableScrollView) {
            self.parent = parent
        }

        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl)
        }
    }
}
