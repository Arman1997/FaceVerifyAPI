//
//  FaceController.swift
//  App
//
//  Created by Arman Galstyan on 12/4/17.
//
import Foundation
import Vapor
import HTTP
import FluentProvider

class FaceController {
    
    func getAllFaces(_ req: Request) throws -> ResponseRepresentable {
        return try Face.all().makeJSON()
    }
    
    func saveNewFace(_ req: Request) throws -> ResponseRepresentable {
        guard let imageDataBytes = req.data["faceImage"]?.bytes,
              let personId = req.data["personId"]?.string else {
            throw Abort.badRequest
        }
        let newPersonId = personId

        let imageData = Data(bytes: imageDataBytes)
        
        var imagePath = String()
        try FileCachingManager.sharedInstance.saveImage(withData: imageData) { (path) in
            imagePath = path
        }
        
        var newFaceId = String()
        try TrainController.shared.appendFaces(withDatas: [imageData]) { (faceId) in
            newFaceId = faceId
            TrainController.shared.sartTrain()
        }

        let newFaceObjcet = Face(faceId: newFaceId, personId: personId, imagePath: imagePath)
        try newFaceObjcet.save()
        
        let newCreatedPerson = NewCreatedPersonFace(personId: newPersonId, faceId: newFaceId)
        return newCreatedPerson
    }
    
}


struct NewCreatedPersonFace: ResponseRepresentable,JSONRepresentable {
    struct Keys {
        static let personId = "personId"
        static let faceId = "faceIds"
    }
    var personId: String
    var faceId: String
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Keys.personId, self.personId)
        try json.set(Keys.faceId, self.faceId)
        return json
    }
}


