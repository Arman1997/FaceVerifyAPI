//
//  TrainController.swift
//  FaceVerifyAPIPackageDescription
//
//  Created by Arman Galstyan on 12/17/17.
//

import Foundation
import AppKit
import FaceTrainer
import Vapor

final class TrainController {
    static let shared = TrainController()
    private let recognitionController = FVRecognitionTrainController()
    
    private init() {
        
    }
    
    let trainOperationQueue = OperationQueue()
    
    func appendFaces(withDatas datas: [Data],completion: (String) -> Void) throws {
        try datas.forEach { (data) in
            guard let image = NSImage(data: data) else {
                throw Abort.badRequest
            }
            
            let person = try recognitionController.appendFace(forImage: image)
            completion(person.faceID)
        }
    }
    
    func sartTrain() {
        trainOperationQueue.cancelAllOperations()
        trainOperationQueue.addOperation {
            self.recognitionController.startTrain()
        }
    }
    
    func recognizePerson(withImageData data: Data, completion: (String) -> Void) throws {
        let recognizesPerson =  recognitionController.verify(face: try FVRecognitionImage(data: data))
        completion(recognizesPerson.faceID)
    }
    
}
