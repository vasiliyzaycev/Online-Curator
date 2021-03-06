//
//  LoginView.swift
//  Shared
//
//  Created by Vasiliy Zaytsev on 27.01.2021.
//

import SwiftUI


struct LoginView: View {
    @State private var state = CurrentState()
    private let router: Router<LoginRoute>
    
    init(router: Router<LoginRoute>) {
        self.router = router
    }
    
    var body: some View {
        router.navigationWrapper() {
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
}

private extension LoginView {
    struct CurrentState {
        var login: String = ""
        var password: String = ""
        var isLoginAllowed: Bool {
            isValidEmail(login) && !password.isEmpty
        }
    }
    
    func loginView() -> some View {
        let binding = Binding<String>(
            get: { self.state.login },
            set: { self.state.login = $0 })
        return inputView(
            iconName: "person",
            field: TextField("Почта", text: binding)
                .autocapitalization(.none))
    }
    
    func passwordView() -> some View {
        inputView(
            iconName: "lock",
            field: SecureField("Пароль", text: $state.password))
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
        Button(action: {}) {
            Text("Войти")
                .fontWeight(.heavy)
                .padding()

        }
        .frame(width: 150)
        .background(Color(red: 35/255, green: 86/255, blue: 71/255))
        .foregroundColor(Color.white)
        .cornerRadius(Constants.radius)
        .disabled(!state.isLoginAllowed)
        .opacity(state.isLoginAllowed ? 1.0 : 0.4)
    }
    
    func bottomButtons() -> some View {
        HStack {
            bottomButton(label: "Регистрация") {
                router.open(.registration)
            }
            Spacer()
            bottomButton(label: "Забыли пароль?") {
                router.open(.forgotPassword)
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

fileprivate func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\" +
        ".[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08" +
        "\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\" +
        "x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[" +
        "(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0" +
        "-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[" +
        "\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|" +
        "\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

private enum Constants {
    static let padding: CGFloat = 35
    static let radius: CGFloat = 10
}

struct LoginView_Previews: PreviewProvider {
    static let testRouter = Router { (route: LoginRoute) -> AnyView in
        switch route {
        case .registration:
            return AnyView(Text("Экран регистрации"))
        case .forgotPassword:
            return AnyView(Text("Экран восстановления пароля"))
        }
    }
    
    static var previews: some View {
        Group {
            LoginView(router: testRouter)
                .previewDevice("iPhone SE (1st generation)")
            LoginView(router: testRouter)
                .previewDevice("iPhone 12 mini")
        }
    }
}
