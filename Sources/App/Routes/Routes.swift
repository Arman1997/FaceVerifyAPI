import Vapor

extension Droplet {
    func setupRoutes() throws {
        try resource("faces", FaceController.self)
    
    }
}
