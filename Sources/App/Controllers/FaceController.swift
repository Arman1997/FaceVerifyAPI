//
//  FaceController.swift
//  App
//
//  Created by Arman Galstyan on 12/4/17.
//

import Vapor
import HTTP
import FluentProvider

class FaceController {
    
    func getAllFaces(_ req: Request) throws -> ResponseRepresentable {
        return try Face.all().makeJSON()
    }
    
    func saveNewFaces(_ req: Request) throws -> ResponseRepresentable {
        guard let imagePaths = req.json?.wrapped["imagePaths"]?.pathIndexableObject?.map({ $0.value.string ?? "" }) else {
            throw Abort.badRequest
        }
       
        let newPersonId = UUID().uuidString
        var faceIdsArray = [String]()
        try imagePaths.forEach({ (imagePath) in
            let newFaceId = UUID().uuidString
            let newFace = Face(faceId: newFaceId, personId: newPersonId, imagePath: imagePath)
            try newFace.save()
            faceIdsArray.append(newFaceId)
        })
        
        let newCreatedPerson = NewCreatedPerson(personId: newPersonId, faceIdsArray: faceIdsArray)
        return newCreatedPerson
    }
    
}


struct NewCreatedPerson: ResponseRepresentable,JSONRepresentable {
    struct Keys {
        static let personId = "personId"
        static let faceIds = "faceIds"
    }
    var personId: String
    var faceIdsArray: [String]
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Keys.personId, self.personId)
        try json.set(Keys.faceIds, self.faceIdsArray)
        return json
    }
}


