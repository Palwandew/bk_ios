//
//  PhotosDownloadManager.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import Foundation

class PhotosDownloadManager{
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2Mjc0MTYyOSwiZXhwIjoxNjYzMTczNjI5fQ.WyVE8NBrhSwwpn7ZCHWgms9jMXcVtRQk8y3QAZ7V-uA" // access token of the user. Need to update
    static let shared = PhotosDownloadManager()
    
    func downloadImage(at url: URL?, completion: @escaping (Result<URL, Error>) -> Void){
        
        guard let url = url else {
            
            return
        }
        
        
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "x-access-token")
        
        let downloadTask = URLSession.shared.downloadTask(with: request) { url, response, error in
            
            
            if let error = error {
                return completion(.failure(error))
                
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                let test  = response as? HTTPURLResponse
                print("code --> \(String(describing: test?.statusCode))")
                return completion(.failure(RequestError.unexpectedStatusCode))
                
            }
            
            guard let url = url else { return }
            
            
            do {
                let documentsURL = try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                let savedURL = documentsURL.appendingPathComponent(url.lastPathComponent)
                try FileManager.default.moveItem(at: url, to: savedURL)
                
                completion(.success(savedURL))
            } catch {
                print ("file error: \(error)")
                completion(.failure(RequestError.unknown("file error: \(error)")))
            }
            
        }
        
        downloadTask.resume()
        
    }
    
}


