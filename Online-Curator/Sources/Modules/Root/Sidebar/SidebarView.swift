//
//  SidebarView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import SwiftUI

struct SidebarView<ViewModel: SidebarViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.padding) {
            ForEach(RootRoute.allCases.map { $0 }, id: \.self) { route in
                row(iconName: route.iconName(), title: route.label()) {
                    viewModel.makeTransition(to: route)
                }
            }
            row(iconName: "arrow.right.square.fill", title: "Выход") {
                viewModel.close()
            }
            Spacer()
        }
        .padding(Constants.leftPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SidebarBackgroundColor"))
    }
}

extension SidebarView {
    private func row(
        iconName: String,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: Constants.iconSize))
                    .frame(width: 40)
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(Color.white)
        }
    }
}

extension RootRoute {
    func label() -> String {
        switch self {
        case .userSettings:     return "Настойки пользователя"
        case .takenToWork:      return "Взято в работу"
        case .callOrders:       return "Заказы звонка"
        case .myAlerts:         return "Мои оповещения"
        case .dataOnGraduates:  return "Данные о выпускниках"
        case .agreements:       return "Соглашения"
        case .technicalSupport: return "Тех. поддержка"
        }
    }

    func iconName() -> String {
        switch self {
        case .userSettings:     return "gear"
        case .takenToWork:      return "case.fill"
        case .callOrders:       return "phone.fill"
        case .myAlerts:         return "bell.fill"
        case .dataOnGraduates:  return "doc.text.fill"
        case .agreements:       return "face.smiling"
        case .technicalSupport: return "questionmark.diamond.fill"
        }
    }
}

private enum Constants {
    static let padding: CGFloat = 20
    static let leftPadding: CGFloat = 15
    static let iconSize: CGFloat = 30
}

struct SidebarView_Previews: PreviewProvider {
    class ViewModelStub: SidebarViewModelProtocol {
        var canAcceptRequests: Bool = false

        func makeTransition(to route: RootRoute) {}
        func close() {}
    }

    static var previews: some View {
        Group {
            SidebarView(viewModel:  ViewModelStub())
                .previewDevice("iPhone SE (1st generation)")
            SidebarView(viewModel:  ViewModelStub())
                .previewDevice("iPhone 12 mini")
        }
    }
}
