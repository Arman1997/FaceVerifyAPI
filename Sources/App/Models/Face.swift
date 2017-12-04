//
//  Face.swift
//  App
//
//  Created by Arman Galstyan on 12/4/17.
//

import FluentProvider
import Vapor
import HTTP

final class Face: Model {
    
    static let idType: IdentifierType = .uuid
    
    struct Keys {
        static let faceId = "faceId"
        static let personId = "personId"
    }
    
    let storage = Storage()
    private var faceId: String
    private var personId: String
    
    
    init(row: Row) throws {
        self.faceId = try row.get(Keys.faceId)
        self.personId = try row.get(Keys.personId)
    }
    
    init(faceId: String, personId: String) {
        self.faceId = faceId
        self.personId = personId
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.personId, self.personId)
        try row.set(Keys.faceId, self.faceId)
        return row
    }
}

extension Face: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { face in
            face.id()
            face.string(Face.Keys.personId)
            face.string(Face.Keys.faceId)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Face: JSONInitializable{
    convenience init(json: JSON) throws {
        self.init(faceId: try json.get(Keys.faceId) , personId: try json.get(Keys.personId))
    }
}

extension Face: ResponseRepresentable {}


extension Face: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Keys.faceId, self.faceId)
        try json.set(Keys.personId, self.personId)
        return json
    }
}
