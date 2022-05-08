//
//  PostDI.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

class PostDI{
    
    func postDependencies() -> PostViewModel {
        
        // PostEndpoint
        let postEndPoint = PostEndpoint(path: "https://jsonplaceholder.typicode.com/posts", mehtod: RequestMethod.get)
        
        
        // Post Data Source
        let postRemoteDataSource = PostRemoteDataSourceImp(postEndpoint: postEndPoint)
        
        // Post Data Repo
        let postDataRepo = PostRepositoryImp(postRemoteDataSource: postRemoteDataSource)
        
        
        // Domain Layer
        
        // Post use case
        let postUseCase = PostUseCase(postRepository: postDataRepo)
        
        
        // Presentation
        let postVM = PostViewModel(postUseCase: postUseCase)
        
        return postVM
    }
    
}
