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
            HStack(alignment: .lastTextBaseline) {
                Text(project.title)
                    .font(.title)
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.yellow) // fill comes from status
                        .frame(width: 10)
                    Text("In progress")
                }.font(.subheadline)
            }.padding(.horizontal)
            Divider()
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let description = project.description,
                   description.isEmpty == false {
                    Text(description)
                } else {
                    Text("Enter a project description")
                }
            }.padding(.horizontal)
            Spacer()
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: .mock)
            .previewDisplayName("All parameters")
        ProjectView(project: .mockDescriptionEmpty)
            .previewDisplayName("Empty Description")
        ProjectView(project: .mockNoDescription)
            .previewDisplayName("No Description")
    }
}
