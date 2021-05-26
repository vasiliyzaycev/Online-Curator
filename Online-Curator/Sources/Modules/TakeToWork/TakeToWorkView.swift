// 
//  TakeToWorkView.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import SwiftUI

struct TakeToWorkView<ViewModel: TakeToWorkViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        viewModel.update()
    }

    var body: some View {
        switch viewModel.state.asTuple {
        case (nil, .idle):              Color.white
        case (nil, .loading):           ProgressHUD()
        case (nil, .error(let error)):  errorView(error)
        case (let value?, _):           refreshableView(value)
        }
    }
}

extension TakeToWorkView {
    private func errorView(_ error: FetchError) -> some View {
        VStack(spacing: 25) {
            Image(systemName: "exclamationmark.icloud")
                .font(.system(size: 50))
            Text(error.description).fontWeight(.semibold)
            ActionButton(title: "Попробоавть еще", width: 200) {
                viewModel.update()
            }
        }
    }

    private func refreshableView(_ items: [TakeToWorkItem]) -> some View {
        RefreshableScrollView {
            contentView(items)
        } onRefresh: { control in
            viewModel.update {
                control.endRefreshing()
            }
        }
    }

    private func contentView(_ items: [TakeToWorkItem]) -> some View {
        Group {
            if items.isEmpty {
                Text("Список пуст").bold()
            } else {
                List {
                    ForEach(items, id: \.self) { item in
                        ItemView(item: item)
                    }
                }
            }
        }
    }
}

struct ItemView: View {
    let item: TakeToWorkItem

    var body: some View {
        VStack {
            Text(item.name).bold()
            Text(item.message)
            Text(item.phone)
            Text(item.email)
        }
        .frame(maxWidth: .infinity)
//        .background(Color.red)        //TODO
//        .foregroundColor(Color.red)
        .cornerRadius(Constants.radius)
//        .padding()
    }
}

private enum Constants {
    static let radius: CGFloat = 20
}

struct TakeToWorkView_Previews: PreviewProvider {
    class ViewModelStub: TakeToWorkViewModelProtocol, ObservableObject {
        @Published var state: TakeToWorState = .init(
            value: [mockItem()],
            state: .idle)
        func update() {
            update(complition: nil)
        }

        func update(complition: (() -> Void)?) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.state = TakeToWorState(
                    value: (self.state.value ?? []) + [Self.mockItem()],
                    state: .idle)
                complition?()
            }
        }

        func openDetail(_ item: TakeToWorkItem) {}

        static func mockItem() -> TakeToWorkItem {
            TakeToWorkItem(
                surname: "",
                name: "Иванов Кирил Сергеевич",
                middleName: "",
                city: "",
                phone: "+7(982)649 98 92",
                email: "ivanovkirillx@gmail.com",
                requestType: "",
                message: "Психолого педагогическая помощь в решении личных и профессиональных вопросов",
                sendingTime: "",
                sendingDate: "")
        }
    }

    static var previews: some View {
        Group {
            TakeToWorkView(viewModel: ViewModelStub())
                .previewDevice("iPhone SE (1st generation)")
            TakeToWorkView(viewModel: ViewModelStub())
                .previewDevice("iPhone 12 mini")
        }
    }
}
