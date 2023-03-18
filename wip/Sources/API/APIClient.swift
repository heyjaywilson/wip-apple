//
//  APIClient.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation
import Dependencies
import WIPKit
import Alamofire

extension DependencyValues {
    public var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

public struct APIClient: DependencyKey {
    public var addNewProject: (Project) async throws -> Project
    public var fetchAllProjects: () async throws -> [Project]
}
