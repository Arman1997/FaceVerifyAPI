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
        return ""
    }
    
}



