import Vapor

extension Droplet {
    func setupRoutes() throws {
        
        let faceController = FaceController()
        get("faces",handler: faceController.getAllFaces)
        post("faces", handler: faceController.saveNewFaces)
        
        let faceImagesController = FaceImagesController()
        post("faceImages", handler: faceImagesController.saveFaceImage)
    }
}
