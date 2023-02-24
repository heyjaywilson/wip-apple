//
//  NewProjectView.swift
//  
//
//  Created by Jay on 2/24/23.
//

import NewProjectCore
import ComposableArchitecture
import SwiftUI

public struct NewProjectView: View {
    let store: StoreOf<NewProjectCore>
    public init(store: StoreOf<NewProjectCore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                TextField("Project Name", text: viewStore.binding(\.$title))
                TextField("Project Description", text: viewStore.binding(\.$description))
                Button {
                    viewStore.send(.addProjectButtonTapped)
                } label: {
                    Text("Add Project")
                }
            }
        }
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView(store: Store(initialState: NewProjectCore.State(), reducer: NewProjectCore()))
    }
}
