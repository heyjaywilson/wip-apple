//
//  ProjectView.swift
//  
//
//  Created by Jay on 3/24/23.
//

import SwiftUI
import WIPKit

public struct ProjectView: View {
    private var project: Project
    public init(project: Project) {
        self.project = project
    }
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(project.title)
                    .font(.title)
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.yellow) // fill comes from status
                        .frame(width: 10)
                    Text("In progress")
                }.font(.subheadline)
            }
            Divider()
            Text("Description")
                .font(.subheadline)
            if let description = project.description {
                Text(description)
            } else {
                Text("Enter a project description")
            }
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: .mock)
    }
}
