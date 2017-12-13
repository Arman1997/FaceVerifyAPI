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
        static let faceImagePath = "faceImageDataPath"
    }
    
    let storage = Storage()
    private var faceId: String
    private var personId: String
    private var imagePath: String
    
    
    init(row: Row) throws {
        self.faceId = try row.get(Keys.faceId)
        self.personId = try row.get(Keys.personId)
        self.imagePath = try row.get(Keys.faceImagePath)
    }
    
    init(faceId: String, personId: String,imagePath: String) {
        self.faceId = faceId
        self.personId = personId
        self.imagePath = imagePath
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.personId, self.personId)
        try row.set(Keys.faceId, self.faceId)
        try row.set(Keys.faceImagePath, self.imagePath)
        return row
    }
}

extension Face: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { face in
            face.id()
            face.string(Face.Keys.personId)
            face.string(Face.Keys.faceId)
            face.string(Face.Keys.faceImagePath)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Face: JSONInitializable{
    convenience init(json: JSON) throws {
        self.init(faceId: try json.get(Keys.faceId) , personId: try json.get(Keys.personId), imagePath: try json.get(Keys.faceImagePath))
    }
}

extension Face: ResponseRepresentable {}


extension Face: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Keys.faceId, self.faceId)
        try json.set(Keys.personId, self.personId)
        try json.set(Keys.faceImagePath, self.imagePath)
        return json
    }
}
