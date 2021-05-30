//
//  SidebarSkeletonView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

struct SidebarSkeletonView<Left: View, Right: View>: View {
    @State private var isSidebarVisible = false
    private let sidebarView: Left
    private let contentView: Right

    init(
        sidebarView: Left,
        contentView: Right
    ) {
        self.sidebarView = sidebarView
        self.contentView = contentView
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                contentView
                sidebar()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("Онлайн-куратор", displayMode: .inline)
            .navigationBarItems(leading: barButton())
            .navigationBarColor(UIColor(named: "NavBarBackgroundColor"))
            .gesture(dragGesture())
        }
    }
}

extension SidebarSkeletonView {
    private func sidebar() -> some View {
        GeometryReader { geometry in
            sidebarView
                .frame(width: min(geometry.size.width * 0.7, 290))
                .offset(x: isSidebarVisible ? 0 : -geometry.size.width)
        }
        .background(Color.black.opacity(isSidebarVisible ? 0.5 : 0))
    }

    private func dragGesture() -> some Gesture {
        DragGesture().onEnded {
            if $0.translation.width < -100 {
                withAnimation { isSidebarVisible = false }
            }
        }
    }

    private func barButton() -> some View {
        Button {
            withAnimation { isSidebarVisible.toggle() }
        } label: {
            Image(systemName: "line.horizontal.3")
        }
    }
}

struct SidebarSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SidebarSkeletonView(
                sidebarView: Color.yellow,
                contentView: Color.gray)
                    .previewDevice("iPhone SE (1st generation)")
            SidebarSkeletonView(
                sidebarView: Color.yellow,
                contentView: Color.gray)
                    .previewDevice("iPhone 12 mini")
        }
    }
}
