//
//  AppView.swift
//  
//
//  Created by Jay on 2/24/23.
//

import SwiftUI
import AppCore
import NewProjectView
import NewProjectCore
import WIPKit
import ComposableArchitecture
import SFSafeSymbols

@available(macOS 13.0, *)
public struct AppView: View {
    let store: StoreOf<AppCore>

    public init(store: StoreOf<AppCore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationSplitView(columnVisibility: .constant(.all)) {
                    List {
                        ForEach(viewStore.projects) { project in
                            Text(project.title)
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        HStack {
                            Button {
                                viewStore.send(.addProjectButtonTapped)
                            } label: {
                                Label("Add Project", systemSymbol: .plus)
                            }.buttonStyle(.plain).padding(.leading, 10.0)
                                .padding(.bottom)
                            Spacer()
                        }
                    }
                .sheet(isPresented: viewStore.binding(get: \.showAddProjectForm, send: .newProject(.cancelButtonTapped))) {
                    NewProjectView(
                        store: self.store.scope(
                            state: \.newProjectState,
                            action: AppCore.Action.newProject
                        )
                    )
                }
                .task {
                    viewStore.send(.onAppear)
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

@available(macOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: Store(
                initialState: AppCore.State(),
                reducer: AppCore())
        )
    }
}
