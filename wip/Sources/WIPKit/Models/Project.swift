//
//  Project.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation

public struct Project: Equatable, Codable {

    var id: UUID?
    var title: String
    var description: String?
    var status: Status

    public init(id: UUID? = UUID(), title: String, description: String? = nil, status: Status? = nil) {
        self.id = id
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
