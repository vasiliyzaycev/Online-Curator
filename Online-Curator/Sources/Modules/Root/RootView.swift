//
//  RootView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

struct RootView: View {
    @State var isSideBarVisible = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("Privet))")
                GeometryReader { geometry in
                    sideBar()
                        .frame(width: min(geometry.size.width * 0.7, 290))
                        .offset(x: isSideBarVisible ? 0 : -geometry.size.width)
                }
                .background(Color.black.opacity(isSideBarVisible ? 0.5 : 0))
                .edgesIgnoringSafeArea(.bottom)
                .animation(.default)
            }
            .navigationBarTitle("Онлайн-куратор", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: { isSideBarVisible.toggle() }) {
                    Image(systemName: isSideBarVisible
                        ? "arrow.left"
                        : "sidebar.leading")
                }
            )
            .navigationBarColor(UIColor(named: "NavBarBackgroundColor"))
        }
    }
}

extension RootView {
    func sideBar() -> some View {
        HStack {
            VStack {
                Text("SideBar")
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color("SideBarBackgroundColor"))
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView()
                .previewDevice("iPhone SE (1st generation)")
            RootView()
                .previewDevice("iPhone 12 mini")
        }
    }
}
