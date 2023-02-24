//
//  wokinpublicApp.swift
//  wokinpublic
//
//  Created by Jay on 1/12/23.
//

import SwiftUI
import AppView
import AppCore
import ComposableArchitecture

@main
struct wokinpublicApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppCore.State(),
                    reducer: AppCore()
                )
            )
        }
    }
}
