//
//  FaceImagesController.swift
//  App
//
//  Created by Arman Galstyan on 12/5/17.
//
import Foundation
import Vapor
import HTTP
import FluentProvider

class FaceImagesController {
    
    func saveFaceImage(_ req: Request) throws -> ResponseRepresentable {
        guard let imageDataBytes = req.data["faceImage"]?.bytes else {
           throw Abort.badRequest
        }
        
        let imageData = Data(bytes: imageDataBytes)
        var imagePath = ""
        try FileCachingManager.sharedInstance.saveImage(withData: imageData) { (savedImagePath) in
           imagePath = savedImagePath
        }
        return imagePath
    }
    
}
