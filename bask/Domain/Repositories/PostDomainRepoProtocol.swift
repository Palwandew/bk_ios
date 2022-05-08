//
//  PostRepository.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

protocol PostDomainRepoProtocol{
    func getPosts(handler: @escaping ([Post]) -> ())
}
