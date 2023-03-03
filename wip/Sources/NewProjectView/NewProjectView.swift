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
                Text("New Project")
                    .font(.largeTitle)
                    .bold()
                TextField("Project Name", text: viewStore.binding(\.$title))
                TextField("Project Description", text: viewStore.binding(\.$description))
                HStack {
                    Spacer()
                    Button {
                        viewStore.send(.cancelButtonTapped)
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                        viewStore.send(.addProjectButtonTapped)
                    } label: {
                        Text("Add Project")
                    }.disabled(true)
                }
            }
            .padding()
            .background(.thickMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NewProjectView(store: Store(initialState: NewProjectCore.State(), reducer: NewProjectCore()))
        }.background(Color.blue)
    }
}
