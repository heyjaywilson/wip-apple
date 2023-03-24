//
//  Project.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation
import Dependencies

public struct Project: Equatable, Codable, Identifiable, Hashable {

    public var id: UUID
    public var title: String
    public var description: String?
    public var status: Status

    public init(id: UUID? = UUID(), title: String, description: String? = nil, status: Status? = nil) {
        @Dependency(\.uuid) var uuid
        self.id = id ?? uuid()
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

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Project {
    public static var mock: Self {
        return Project(
            title: "Test Project",
            description: "This is a description. It has **markdown** but it's not parsed yet.",
            status: Status.mock
        )
    }
}
