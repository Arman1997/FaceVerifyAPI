import Vapor
import Foundation

extension Droplet {
    func setupRoutes() throws {
        
        let faceController = FaceController()
        get("faces",handler: faceController.getAllFaces)
        post("faces", handler: faceController.saveNewFaces)
        
        post("faceImage") { request in
            guard let imageDataBytes = request.data["faceImage"]?.bytes else {
                throw Abort.badRequest
            }
            // detect face
            // write array in text file
            let imageData = Data(bytes: imageDataBytes)
            var imagePath = ""
            try FileCachingManager.sharedInstance.saveImage(withData: imageData) { (savedImagePath) in
                imagePath = savedImagePath
            }
            return imagePath
        }
    }
}
