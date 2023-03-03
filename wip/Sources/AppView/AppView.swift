//
//  AppView.swift
//  
//
//  Created by Jay on 2/24/23.
//

import SwiftUI
import AppCore
import NewProjectView
import ComposableArchitecture
import SFSafeSymbols

public struct AppView: View {
    let store: StoreOf<AppCore>

    public init(store: StoreOf<AppCore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationSplitView(columnVisibility: .constant(.all)) {
                ZStack(alignment: .bottom) {
                    List {
                        Text("Projects")
                        Text("Projects")
                        Text("Projects")
                        Text("Projects")
                        Text("Projects")
                        Text("Projects")
                        Text("Projects")
                        Text("Projects")
                    }
                    HStack {
                        Button {
                            viewStore.send(.addProjectButtonTapped)
                        } label: {
                            Label("Add Project", systemSymbol: .plus)
                        }.buttonStyle(.plain).padding(.leading, 10.0)
                            .padding(.bottom)
                        Spacer()
                    }
                }.sheet(isPresented: viewStore.binding(get: \.showAddProjectForm, send: .newProject(.cancelButtonTapped))) {

                        NewProjectView(
                            store: self.store.scope(
                                state: \.newProjectState,
                                action: AppCore.Action.newProject
                            )
                        )
                }
            } content: {
                Text("tasks")
            } detail: {
                Text("project")
            }
        }
        .debug()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: Store(
                initialState: AppCore.State(),
                reducer: AppCore())
        )
    }
}
