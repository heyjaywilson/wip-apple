//
//  Todo.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation

public struct Todo: Codable, Equatable {

    var id: UUID
    var title: String
    var description: String?
    var order: Double
    var createdAt: Date?
    var updatedAt: Date?
    var completedOn: Date?
//    var visibility: Visibility
    var status: Status
    var project: Project

    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case order
        case createdAt
        case updatedAt
        case completedOn
        case status
        case project
    }
}
