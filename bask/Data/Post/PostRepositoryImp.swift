//
//  PostDataRepository.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

public class PostRepositoryImp: PostDomainRepoProtocol {
    
    private let postRemoteDataSource: PostRemoteDataSourceProtocol
    
    init(postRemoteDataSource: PostRemoteDataSourceProtocol){
        self.postRemoteDataSource = postRemoteDataSource
    }
    
    // Implementing the PostDomainRepoProtocol method
    
    func getPosts(handler: @escaping ([Post]) -> ()) {
        postRemoteDataSource.getPosts { (postModels) in
            var postEntities = [Post]()
            for postModel in postModels {
                postEntities.append(postModel.dtoPostEntity())
            }
            
            handler(postEntities)
        }
    }
    
}
