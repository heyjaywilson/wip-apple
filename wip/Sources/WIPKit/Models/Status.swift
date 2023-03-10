//
//  Status.swift
//  
//
//  Created by Jay on 3/3/23.
//

import Foundation

public enum StatusEquivalent: String, Equatable {
    case backlog, todo, inprogress, completed
}

public struct Status: Codable, Equatable {
    
    var id: UUID

    enum CodingKeys: CodingKey {
        case id
    }

//    static let mock = Status(id: UUID(uuidString: "d3c861bb-ffde-4973-b24c-5a0b1c746a5a")!, title: "in progress", color: "yellow", description: "tasks that are in progress")
    static let mock = Status(
        id: UUID(uuidString: "d3c861bb-ffde-4973-b24c-5a0b1c746a5a")!
    )
}
