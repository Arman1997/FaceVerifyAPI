//
//  File.swift
//  Run
//
//  Created by Arman Galstyan on 12/4/17.
//

import Foundation

final class FileCachingManager {
    static let sharedInstance = FileCachingManager()
    private init() {}
    
    let fileManager = FileManager.default
    
    func saveImage(withData imageData: Data, completion: (String) -> Void) throws {
        let newUniqueFileName = UUID().uuidString
        let path = self.getDocumentsDirectory().appendingPathComponent(newUniqueFileName).appendingPathExtension(".jpg")
        try imageData.write(to: path)
        completion(newUniqueFileName)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}


