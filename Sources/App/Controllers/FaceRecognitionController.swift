//
//  FaceRecognitionController.swift
//  App
//
//  Created by Arman Galstyan on 12/17/17.
//

import Foundation

import Vapor

class FaceRecognitionController {
    func recognizeFace(_ req: Request) throws -> ResponseRepresentable {
        guard let imageDataBytes = req.data["faceImage"]?.bytes else {
                throw Abort.badRequest
        }
        let imageData = Data(bytes: imageDataBytes)
        var personId = String()
        try TrainController.shared.recognizePerson(withImageData: imageData) { (faceId) in
            personId = faceId
        }
        
        return personId
    }
}

