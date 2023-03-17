//
//  APIClientTest.swift
//  
//
//  Created by Jay on 3/17/23.
//

import Foundation
import WIPKit
import Dependencies

extension APIClient {
    static public var testValue: APIClient {
        return Self(
            addNewProject: { _ in
                return Project(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000000"),
                    title: "Test Project"
                )
            },
            fetchAllProjects: {
                return [
                    Project(
                        id: UUID(uuidString: "00000000-0000-0000-0000-000000000000"),
                        title: "Test Project"
                    )
                ]
            }
        )
    }
}
