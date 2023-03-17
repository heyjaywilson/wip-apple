//
//  Project.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation
import Dependencies

public struct Project: Equatable, Codable {

    var id: UUID
    var title: String
    var description: String?
    var status: Status

    public init(id: UUID? = UUID(), title: String, description: String? = nil, status: Status? = nil) {
        @Dependency(\.uuid) var uuid
        if let id {
            self.id = id
        } else {
            self.id = uuid.callAsFunction()
        }
        self.title = title
        self.description = description
        self.status = status ?? Status.mock
    }

    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case status
    }
}
