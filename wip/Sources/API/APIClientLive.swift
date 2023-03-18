//
//  APIClientLive.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation
import Alamofire
import WIPKit

extension APIClient {
    public static var liveValue: Self {
        let baseURL = "http://127.0.0.1:8080/"

        return Self(
            addNewProject: { project in
                let request = AF.request(baseURL+APIEndpoints.projects, method: .post, parameters: project, encoder: JSONParameterEncoder.prettyPrinted)

                let dataTask = request.serializingDecodable(Project.self)
                let response = await dataTask.result
                do {
                    return try response.get()
                } catch {
                    print(error)
                    throw APIError()
                }
            },
            fetchAllProjects: {
                let request = AF.request(baseURL+APIEndpoints.projects, method: .get)
                let dataTask = request.serializingDecodable(Array<Project>.self)
                let response = await dataTask.result
                do {
                    return try response.get()
                } catch {
                    print(error)
                    throw APIError()
                }
            }
        )
    }
}
