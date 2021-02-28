//
//  ContentView.swift
//  Shared
//
//  Created by Vasiliy Zaytsev on 27.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    private let padding: CGFloat = 35
    private let radius: CGFloat = 10
    
    var body: some View {
        VStack(spacing: padding) {
            Spacer()
            Image("specialist_icon")
            loginView()
            passwordView()
            signInButton()
            Spacer()
            bottomButtons()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, padding)
        .background(Image("background_main").resizable())
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

private extension ContentView {
    func loginView() -> some View {
        inputView(icon: "person", field: TextField("Почта", text: $login))
    }
    
    func passwordView() -> some View {
        inputView(icon: "lock", field: SecureField("Пароль", text: $password))
    }
    
    func inputView<T: View>(icon: String, field: T) -> some View {
        HStack {
            Image(systemName: icon).foregroundColor(.secondary)
            field.foregroundColor(Color.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(radius)
    }
    
    func signInButton() -> some View {
        Button(action: {}) {
            Text("Войти")
                .fontWeight(.heavy)
                .padding()

        }
        .frame(width: 150)
        .background(Color.black)
        .foregroundColor(Color.white)
        .cornerRadius(radius)
    }
    
    func bottomButtons() -> some View {
        HStack {
            bottomButton(action: {}, label: "Регистрация")
            Spacer()
            bottomButton(action: {}, label: "Забыли пароль?")
        }
        .padding(.bottom, padding)
    }
    
    func bottomButton(
        action: @escaping () -> Void,
        label: String
    ) -> some View {
        Button(action: action) {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12 mini")
            ContentView()
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}
