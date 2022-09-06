//
//  PhotosUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/08/2022.
//

import Foundation

class PhotosUsecase {
    
    private let photosRepository: PhotosDomainRepoProtocol

    
    init(repo concreteImpl: PhotosRepositoryImpl){
        photosRepository = concreteImpl
    }
    
    func uploadPhoto(of facilityID: String, from path: URL, progress: @escaping (Double) -> Void, completion: @escaping (Result<String, Error>) -> Void){
        
        //completion(.success("uploaded.."))
        photosRepository.uploadPhoto(of: facilityID, from: path, progress: progress, completion: completion)
    }
    
    func finishURLSession(){
        photosRepository.finishUploadingSession()
    }
    
}
