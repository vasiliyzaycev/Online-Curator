//
//  LoginView.swift
//  Shared
//
//  Created by Vasiliy Zaytsev on 27.01.2021.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    @Binding private var errorMessage: ErrorMessage?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self._errorMessage = Binding<ErrorMessage?>(
            get: {
                guard case .error(let message) = viewModel.state else {
                    return nil
                }
                return ErrorMessage(id: message)
            },
            set: { _ in
                viewModel.hideAlert()
            }
        )
    }

    var body: some View {
        ZStack() {
            content()
                .alert(item: $errorMessage) { errorMessage in
                    Alert(title: Text(errorMessage.id))
                }
            if case .processing = viewModel.state {
                ProgressHUD()
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarHidden(true)
    }
}

extension LoginView {
    private struct ErrorMessage: Identifiable {
        let id: String
    }

    private func content() -> some View {
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
    }

    private func loginView() -> some View {
        inputView(
            iconName: "person",
            field: TextField("Почта", text: $viewModel.login)
                .autocapitalization(.none))
    }
    
    private func passwordView() -> some View {
        inputView(
            iconName: "lock",
            field: SecureField("Пароль", text: $viewModel.password))
    }
    
    private func inputView<T: View>(iconName: String, field: T) -> some View {
        HStack {
            Image(systemName: iconName).foregroundColor(.secondary)
                .frame(width: 20)
            field.foregroundColor(Color.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.radius)
    }
    
    private func signInButton() -> some View {
        ActionButton(title: "Войти", width: 150) {
            viewModel.startLogin()
        }
        .disabled(viewModel.state != .allowed)
        .opacity(viewModel.state == .allowed ? 1.0 : 0.4)
    }
    
    private func bottomButtons() -> some View {
        HStack {
            bottomButton(label: "Регистрация") {
                viewModel.makeTransition(to: .registration)
            }
            Spacer()
            bottomButton(label: "Забыли пароль?") {
                viewModel.makeTransition(to: .forgotPassword)
            }
        }
        .padding(.bottom, Constants.padding)
    }
    
    private func bottomButton(
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
        var state: LoginViewModelState = .prohibited
        var login: String = ""
        var password: String = ""

        func startLogin() {}
        func hideAlert() {}
        func makeTransition(to route: LoginRoute) {}
        func close() {}
    }

    static var previews: some View {
        LoginView(viewModel: ViewModelStub())
            .previewDevice("iPhone SE (1st generation)")
        LoginView(viewModel: ViewModelStub())
            .previewDevice("iPhone 12 mini")
    }
}
