//
//  NewProjectCore.swift
//  
//
//  Created by Jay on 2/24/23.
//

import ComposableArchitecture
import Foundation
import Dependencies
import API
import WIPKit

public struct NewProjectCore: ReducerProtocol {
    @Dependency(\.apiClient) var apiClient
    public init() {}

    public struct State: Equatable {
        @BindingState public var title: String
        @BindingState public var description: String

        public var isAddButtonDisabled: Bool {
            return title.count <= 0
        }

        public init(title: String = "", description: String = "") {
            self.title = title
            self.description = description
        }
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case addProjectButtonTapped
        case cancelButtonTapped
        case createProjectResponse(TaskResult<Project>)
        case delegate(Delegate)

        public enum Delegate {
            case successfulResponse
            case cancelButtonTapped
        }
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce(self.core)
    }

    private func core(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            case .onAppear:
                return .none
            case .binding(_):
                return .none
            case .addProjectButtonTapped:
                let description: String? = state.description.count > 0 ? state.description : nil
                let project = Project(title: state.title, description: description)
                return .task {
                    await .createProjectResponse(TaskResult { try await apiClient.addNewProject(project) })
                }
            case .delegate:
                return .none
            case .cancelButtonTapped:
                return .send(.delegate(.cancelButtonTapped))
            case .createProjectResponse(.success(let project)):
                print(project)
                return .send(.delegate(.successfulResponse))
            case .createProjectResponse(.failure(let error)):
                print("❌ \(error)")
                return .none
        }
    }
}

