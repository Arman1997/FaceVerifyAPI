//
//  FaceController.swift
//  App
//
//  Created by Arman Galstyan on 12/4/17.
//

import Vapor
import HTTP
import FluentProvider

final class FaceController: ResourceRepresentable {
    
    func makeResource() -> Resource<Face> {
        return Resource(index: index,
                        show: show)
    }
    
    typealias Model = Face
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try Face.all().makeJSON()
    }
    
    func show(_ req: Request, _ face: Face) throws -> ResponseRepresentable {
        return face
    }
    
    func store(_ req: Request) throws -> ResponseRepresentable {
        return ""
    }
    
}


extension FaceController: EmptyInitializable {}
