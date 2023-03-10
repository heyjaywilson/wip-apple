//
//  AppCore.swift
//  
//
//  Created by Jay on 2/24/23.
//

import ComposableArchitecture
import Foundation
import NewProjectCore

import SwiftUI

public struct AppCore: ReducerProtocol {
    public init() {}

    public struct State: Equatable {
        public var name: String
        public var showAddProjectForm: Bool
        public var newProjectState: NewProjectCore.State

        public init(
            name: String = "",
            showAddProjectForm: Bool = false,
            newProjectState: NewProjectCore.State = NewProjectCore.State()
        ) {
            self.name = name
            self.showAddProjectForm = showAddProjectForm
            self.newProjectState = newProjectState
        }
    }

    public enum Action: Equatable {
        case onAppear
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
                return .none
            case .addProjectButtonTapped:
                withAnimation {
                    state.showAddProjectForm = true
                }
                return .none
            case let .newProject(.delegate(action)):
                switch action {
                    case .cancelButtonTapped:
                        withAnimation {
                            state.newProjectState = NewProjectCore.State()
                            state.showAddProjectForm = false
                        }
                        return .none
                    case .successfulResponse:
                        state.newProjectState = NewProjectCore.State()
                        state.showAddProjectForm = false
                        return .none
                }
            case .newProject:
                return .none
        }
    }
}

