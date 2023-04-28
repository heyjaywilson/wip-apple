//
//  APIClientPreview.swift
//  
//
//  Created by Jay on 3/24/23.
//

import Foundation
import WIPKit
import Dependencies

extension APIClient {
    public static var previewValue: APIClient {
        return Self(
            addNewProject: { _ in
                return Project(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000001"),
                    title: "New Project"
                )
            },
            fetchAllProjects: {
                return [
                    Project(
                        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002"),
                        title: "Test Project from Dependency"
                    ),
                    Project.mock
                ]
            }
        )
    }
}
