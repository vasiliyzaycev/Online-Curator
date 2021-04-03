//
//  RootView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

struct RootView<Left: View, Right: View>: View {
    @State private var isSideBarVisible = false
    private let sideBarView: Left
    private let mainView: Right

    init(
        sideBarView: Left,
        mainView: Right
    ) {
        self.sideBarView = sideBarView
        self.mainView = mainView
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                mainView
                sideBar()
            }
            .navigationBarTitle("Онлайн-куратор", displayMode: .inline)
            .navigationBarItems(leading: barButton())
            .navigationBarColor(UIColor(named: "NavBarBackgroundColor"))
            .gesture(dragGesture())
        }
    }
}

extension RootView {
    private func sideBar() -> some View {
        GeometryReader { geometry in
            sideBarView
                .frame(width: min(geometry.size.width * 0.7, 290))
                .offset(x: isSideBarVisible ? 0 : -geometry.size.width)
        }
        .background(Color.black.opacity(isSideBarVisible ? 0.5 : 0))
        .edgesIgnoringSafeArea(.bottom)
    }

    private func dragGesture() -> some Gesture {
        DragGesture().onEnded {
            if $0.translation.width < -100 {
                withAnimation { isSideBarVisible = false }
            }
        }
    }

    private func barButton() -> some View {
        Button {
            withAnimation { isSideBarVisible.toggle() }
        } label: {
            Image(systemName: "line.horizontal.3")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView(sideBarView: Color.yellow, mainView: Color.gray)
                .previewDevice("iPhone SE (1st generation)")
            RootView(sideBarView: Color.yellow, mainView: Color.gray)
                .previewDevice("iPhone 12 mini")
        }
    }
}
