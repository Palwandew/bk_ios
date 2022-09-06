//
//  PhotosRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/08/2022.
//

import Foundation


class PhotosRepositoryImpl: PhotosDomainRepoProtocol {
    
    
    private let uploadManager: UploadManager
    
    
    // Don't forget to change access-token
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2MjAyMDU5OCwiZXhwIjoxNjYyNDUyNTk4fQ.6LuD4G3ieJoFSxhLcOYFj28X47z3s0knDdYEPFLNpDM"
    
    let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
    
    init(uploadManager: UploadManager){
        self.uploadManager = uploadManager
    }
    
    private func getSignedUrl(queryItems: [URLQueryItem], completion: @escaping (Result<PhotoSignedURLDataClass, Error>) -> Void) {
        
        let endpoint = Endpoints.GET_SIGNED_URL(with: queryItems)
        
       
        
        print("Signed url: \(String(describing: endpoint.url?.absoluteString))")
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: PhotoSignedURLModel.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let signedURL):
                completion(.success(signedURL.data))
                
            }
        }
    }
    
    
    
    private func postImageLink(with body: ImageLinkRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
    
        let endpoint = Endpoints.CREATE_IMAGE_LINK
        print("Imge link: \(String(describing: endpoint.url?.absoluteString))")
        print("Image link body \(body)")
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: body) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let message):
                completion(.success(message))
            }
        }
    }
    
    
    
    
    func uploadPhoto(of facilityID: String, from path: URL, progress: @escaping (Double) -> Void, completion: @escaping (Result<String, Error>) -> Void) {
        
        let facilityIDQueryItem = URLQueryItem(name: "facilityId", value: facilityID)
        let fileExtensionQueryItem = URLQueryItem(name: "fileExtension", value: "jpg")
        let queryItems = [facilityIDQueryItem, fileExtensionQueryItem]
        
        getSignedUrl(queryItems: queryItems) { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let signedURL):
                print("Singed URL FRom server: \(signedURL)")
                guard let targetURL = URL(string: signedURL.uploadURL) else {
                    completion(.failure(RequestError.unknown("Error uploading photo")))
                    return
                }
                self?.uploadManager.uploadFile(from: path, to: targetURL, progressHandler: progress) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(_):
                        self?.postImageLink(with: ImageLinkRequestBody(facilityID: facilityID, photo: signedURL.filename, isPrimary: true), completion: completion)
                        
                    }
                }
            }
        }
    }
    
    func finishUploadingSession() {
        uploadManager.finishUploadingTasksAndInvalidate()
    }
    
}
