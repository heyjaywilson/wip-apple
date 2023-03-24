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
import ProjectView

@available(macOS 13.0, *)
public struct AppView: View {
    let store: StoreOf<AppCore>

    public init(store: StoreOf<AppCore>) {
        self.store = store
    }

    var tapGesture = TapGesture()

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationSplitView(columnVisibility: .constant(.all)) {
                List(
                    viewStore.projects,
                    id: \.self,
                    selection: viewStore.binding(get: \.selectedProject, send: { .onProjectSelect($0) })
                ) { project in
                    NavigationLink(project.title) {
                        Text("Todo's for \(project.title)")
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
                .navigationSplitViewColumnWidth(200)
            } content: {
                Text("tasks")
            } detail: {
                if let project = viewStore.selectedProject {
                    ProjectView(project: project)
                }
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
                reducer: AppCore()
            )
        )
    }
}
