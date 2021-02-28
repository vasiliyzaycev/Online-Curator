//
//  ContentView.swift
//  Shared
//
//  Created by Vasiliy Zaytsev on 27.01.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Онлайн-куратор")
                .fontWeight(.heavy)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background_main")
                .resizable()
                .scaledToFill()
                .clipped()
        )
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
