//
//  AppCore.swift
//  
//
//  Created by Jay on 2/24/23.
//

import ComposableArchitecture
import Foundation
import NewProjectCore
import WIPKit
import API

import SwiftUI

public struct AppCore: ReducerProtocol {
    @Dependency(\.apiClient) var apiClient

    public init() {}

    public struct State: Equatable {
        public var showAddProjectForm: Bool
        public var newProjectState: NewProjectCore.State

        public init(
            showAddProjectForm: Bool = false,
            newProjectState: NewProjectCore.State = NewProjectCore.State()
        ) {
            self.showAddProjectForm = showAddProjectForm
            self.newProjectState = newProjectState
        }
    }

    public enum Action: Equatable {
        case onAppear
        case getProjectsResponse(TaskResult<Array<Project>>)
        case addProjectButtonTapped
        case newProject(NewProjectCore.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce(self.core)
        // MARK: Scopes
        Scope(
            state: \.newProjectState,
            action: /Action.newProject
        ) {
            NewProjectCore()
        }
    }

    private func core(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            case .onAppear:
                return .task {
                    await .getProjectsResponse(TaskResult { try await apiClient.fetchAllProjects()})
                }
            case let .getProjectsResponse(.success(projects)):
                print(projects)
                return .none
            case let .getProjectsResponse(.failure(error)):
                print(error)
                return .none
            case .addProjectButtonTapped:
                withAnimation {
                    state.showAddProjectForm = true
                }
                return .none
            case let .newProject(.delegate(action)):
                switch action {
                    case .cancelButtonTapped:
                        state.showAddProjectForm = false
                        state.newProjectState = NewProjectCore.State()
                        return .none
                    case .successfulResponse:
                        state.showAddProjectForm = false
                        state.newProjectState = NewProjectCore.State()
                        return .none
                }
            case .newProject:
                return .none
        }
    }
}

