//
//  FaceImage.swift
//  App
//
//  Created by Arman Galstyan on 12/4/17.
//
import FluentProvider
import Vapor
import HTTP

final class FaceImage: Model {
    let storage = Storage()
    struct Keys {
        static let faceImagePath = "faceImageDataPath"
        static let faceId = "faceId"
    }
    
    private var imageDataPathString: String
    private var faceId: String
    
    init(row: Row) throws {
        self.imageDataPathString = try row.get(Keys.faceImagePath)
        self.faceId = try row.get(Keys.faceId)
    }
    
    init(faceId: String, faceImagePath: String) {
        self.faceId = faceId
        self.imageDataPathString = faceImagePath
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.faceImagePath, self.imageDataPathString)
        try row.set(Keys.faceId, self.faceId)
        return row
    }

}

extension FaceImage: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { faceImage in
            faceImage.id()
            faceImage.string(FaceImage.Keys.faceId)
            faceImage.string(FaceImage.Keys.faceImagePath)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
