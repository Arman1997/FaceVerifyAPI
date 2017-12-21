//
//  FaceRecognitionController.swift
//  App
//
//  Created by Arman Galstyan on 12/17/17.
//

import Foundation

import Vapor
import HTTP

class FaceRecognitionController {
    func recognizeFace(_ req: Request) throws -> ResponseRepresentable {
        guard let imageDataBytes = req.data["faceImage"]?.bytes else {
                throw Abort.badRequest
        }
        let imageData = Data(bytes: imageDataBytes)
        var personId = String()
        var recognizedFaceId = String()
        
        try TrainController.shared.recognizePerson(withImageData: imageData) { (faceId) in
            recognizedFaceId = faceId
        }
        
        let matcedFaces = try Face.all().filter({ $0.faceId == recognizedFaceId })
        guard matcedFaces.count == 0 else {
            throw Abort(Status.multipleChoices)
        }
        
        guard let matchedFace = matcedFaces.first else{
            return ""
        }
        
        personId = matchedFace.personId
        return personId
    }
}

