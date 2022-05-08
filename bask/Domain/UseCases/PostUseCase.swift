//
//  PostUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

public class PostUseCase{
    
    private let postRepository: PostDomainRepoProtocol
    
    init(postRepository: PostDomainRepoProtocol){
        self.postRepository = postRepository
    }
    
    func getPosts(handler: @escaping ([Post]) -> ())  {
        postRepository.getPosts { (PostDomainModelArray) in
            handler(PostDomainModelArray)
        }
    }
}
