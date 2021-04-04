//
//  RootView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

struct RootView<Left: View, Right: View>: View {
    @State private var isSidebarVisible = false
    private let sidebarView: Left
    private let mainView: Right

    init(
        sidebarView: Left,
        mainView: Right
    ) {
        self.sidebarView = sidebarView
        self.mainView = mainView
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                mainView
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

extension RootView {
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView(sidebarView: Color.yellow, mainView: Color.gray)
                .previewDevice("iPhone SE (1st generation)")
            RootView(sidebarView: Color.yellow, mainView: Color.gray)
                .previewDevice("iPhone 12 mini")
        }
    }
}
