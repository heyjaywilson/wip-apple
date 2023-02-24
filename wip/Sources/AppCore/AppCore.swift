//
//  AppCore.swift
//  
//
//  Created by Jay on 2/24/23.
//

import ComposableArchitecture
import Foundation

public struct AppCore: ReducerProtocol {
    public init() {}

    public struct State: Equatable {
        public var name: String

        public init(name: String = "") {
            self.name = name
        }
    }

    public enum Action: Equatable {
        case onAppear
        case addProjectButtonTapped
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            case .onAppear:
                return .none
            case .addProjectButtonTapped:
                print("Add project")
                return .none
        }
    }
}

