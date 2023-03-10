//
//  APIManager.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation
import Alamofire
import WIPKit

class APIManager {
    let baseURL: String

    init() {
        // TODO: Replace once you know the URLs
//        #if DEBUG
        self.baseURL = "http://127.0.0.1:8080/"
//        #else
//        self.baseURL = "production_URL"
//        #endif
    }

    func postProject(_ project: Project) async throws -> Project {
        let request = AF.request(baseURL+APIEndpoints.projects, method: .post, parameters: project, encoder: JSONParameterEncoder.prettyPrinted)

        let dataTask = request.serializingDecodable( Project.self)
        let response = await dataTask.result
        do {
            return try response.get()
        } catch {
            print(error)
            throw APIError()
        }
    }
}
