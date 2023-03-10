//
//  APIClientLive.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation

extension APIClient {
    public static var liveValue: Self {
        let apiManager = APIManager()
        return Self(
            addNewProject: { project in
                return try await apiManager.postProject(project)
            }
        )
    }
}
