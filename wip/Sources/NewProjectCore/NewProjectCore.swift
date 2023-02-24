//
//  File.swift
//  
//
//  Created by Jay on 2/24/23.
//

import ComposableArchitecture
import Foundation

public struct NewProjectCore: ReducerProtocol {
    public init() {}

    public struct State: Equatable {
        @BindingState public var title = ""
        @BindingState public var description = ""

        public var name: String

        public init(name: String = "") {
            self.name = name
        }
    }

    public enum Action: BindableAction {
        case onAppear
        case binding(BindingAction<State>)
        case addProjectButtonTapped
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
                print("add project to db")
                return .none
        }
    }
}

