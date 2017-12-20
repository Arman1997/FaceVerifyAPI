import Vapor
import Foundation

extension Droplet {
    func setupRoutes() throws {
        
        let faceController = FaceController()
        get("faces",handler: faceController.getAllFaces)
        post("faces", handler: faceController.saveNewFace)
        
        let recognitionController = FaceRecognitionController()

        post("recognize", handler: recognitionController.recognizeFace)
        
        get("persons") { request in
            return UUID().uuidString
        }
    }
}
