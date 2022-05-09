//
//  PostDataRemoteSource.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

protocol PostRemoteDataSourceProtocol{
    func getPosts(handler: @escaping ([PostModel]) -> ())
}


class PostRemoteDataSourceImp: PostRemoteDataSourceProtocol {
    
    final let postEndpoint: PostEndpoint
    
    init(postEndpoint: PostEndpoint){
        self.postEndpoint = postEndpoint
    }
    
    
    func getPosts(handler: @escaping ([PostModel]) -> ()) {
        
        guard let url = URL(string: postEndpoint.path) else {
            return handler([])
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data,urlResponse, error) in
            
            guard let data = data else {
                return handler([])
            }
            
            do{
                let response = try JSONDecoder().decode([PostModel].self, from: data)
                return handler(response)
                
            } catch {
                handler([])
            }
        }
        task.resume()
    }
    
}
