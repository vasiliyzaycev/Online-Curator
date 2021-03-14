//
//  LoginView.swift
//  Shared
//
//  Created by Vasiliy Zaytsev on 27.01.2021.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: Constants.padding) {
            Spacer()
            Image("specialist_icon")
            loginView()
            passwordView()
            signInButton()
            Spacer()
            bottomButtons()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, Constants.padding)
        .background(Image("background_main").resizable())
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarHidden(true)
    }
}

private extension LoginView {
    func loginView() -> some View {
        inputView(
            iconName: "person",
            field: TextField("Почта", text: $viewModel.login)
                .autocapitalization(.none))
    }
    
    func passwordView() -> some View {
        inputView(
            iconName: "lock",
            field: SecureField("Пароль", text: $viewModel.password))
    }
    
    func inputView<T: View>(iconName: String, field: T) -> some View {
        HStack {
            Image(systemName: iconName).foregroundColor(.secondary)
            field.foregroundColor(Color.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.radius)
    }
    
    func signInButton() -> some View {
        Button {
            viewModel.startLogin()
        } label: {
            Text("Войти")
                .fontWeight(.heavy)
                .padding()
        }
        .frame(width: 150)
        .background(Color(red: 35/255, green: 86/255, blue: 71/255))
        .foregroundColor(Color.white)
        .cornerRadius(Constants.radius)
        .disabled(!viewModel.isLoginButtonActive)
        .opacity(viewModel.isLoginButtonActive ? 1.0 : 0.4)
    }
    
    func bottomButtons() -> some View {
        HStack {
            bottomButton(label: "Регистрация") {
                viewModel.open(.registration)
            }
            Spacer()
            bottomButton(label: "Забыли пароль?") {
                viewModel.open(.forgotPassword)
            }
        }
        .padding(.bottom, Constants.padding)
    }
    
    func bottomButton(
        label: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
        }
    }
}

private enum Constants {
    static let padding: CGFloat = 35
    static let radius: CGFloat = 10
}

struct LoginView_Previews: PreviewProvider {
    class ViewModelStub: LoginViewModelProtocol {
        var login: String = ""
        var password: String = ""
        var isLoginButtonActive = false
        
        func startLogin() {}
        func open(_ route: LoginRoute) {}
        func close() {}
    }
    
    static var previews: some View {
        Group {
            LoginView(viewModel: ViewModelStub())
                .previewDevice("iPhone SE (1st generation)")
            LoginView(viewModel: ViewModelStub())
                .previewDevice("iPhone 12 mini")
        }
    }
}
