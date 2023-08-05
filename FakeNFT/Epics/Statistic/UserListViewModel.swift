//
//  UserListViewModel.swift
//  FakeNFT
//
//  Created by Александр Зиновьев on 29.07.2023.
//

import Foundation
import Combine

protocol UserListViewModel {
    func transform(input: AnyPublisher<UsetListViewControllerInput, Never>) -> AnyPublisher<UserListViewModelOutput, Never>
}

enum UserListViewModelOutput {
    case loading
    case success([User])
    case failure(Error)
    case filterViewModel(AlertViewModel)
    case filteredData([User])
}

final class UserListViewModelImpl: UserListViewModel {
    // MARK: - Dependencies
    private let userStatisticService: UserService

    // Private Properties
    private let output: PassthroughSubject<UserListViewModelOutput, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    private var users: [User] = []
    private var currentFilter: Filters = .name

    init(userStatisticService: UserService) {
        self.userStatisticService = userStatisticService
    }

    func transform(input: AnyPublisher<UsetListViewControllerInput, Never>) -> AnyPublisher<UserListViewModelOutput, Never> {
        input.sink { [weak self] event in
            guard let self else { return }
            switch event {
            case .viewDidLoad:
                self.output.send(.loading)
                self.loadData()

            case .pullToRefresh:
                self.loadData()

            case .cellIsTap(let indexPath):
                self.cellTap(for: indexPath)

            case .filterButtonTapped:
                self.filterButtonTapped()
            }
        }
        .store(in: &cancellables)

        return output.eraseToAnyPublisher()
    }

    private func loadData() {
        userStatisticService.fetchUserStatistics { [weak self] result in
            switch result {
            case .success(let newUsers):
                guard let self else { return }

                self.users = newUsers
                self.output.send(.success(self.filterUsers()))

            case .failure(let failure):
                self?.output.send(.failure(failure))
            }
        }
    }

    private func cellTap(for indexPath: IndexPath) {
        // TODO: -
    }

    private func filterButtonTapped () {
        let filterViewModel = AlertViewModelImpl(
            title: NSLocalizedString("sorting", comment: ""),
            message: nil,
            actions: [
                ActionModel(
                    title: NSLocalizedString("sorting.byName", comment: ""),
                    style: .default) { [weak self] in
                        // Handle byName sorting
                        guard let self else { return }
                        currentFilter = .name
                        output.send(.filteredData(self.filterUsers()))
                },
                ActionModel(
                    title: NSLocalizedString("sorting.byRating", comment: ""),
                    style: .default) { [weak self] in
                        // Handle byRating sorting
                        guard let self else { return }
                        currentFilter = .rank
                        output.send(.filteredData(self.filterUsers()))
                },
                ActionModel(
                    title: NSLocalizedString("sorting.close", comment: ""),
                    style: .cancel,
                    handler: nil
                )
            ]
        )

        output.send(.filterViewModel(filterViewModel))
    }

    private func filterUsers() -> [User] {
        switch currentFilter {
        case .name:
            return users.sortedByName()
        case .rank:
            return users.sortByRank()
        }
    }
}

private extension UserListViewModelImpl {
    enum Filters {
        case name
        case rank
    }
}
