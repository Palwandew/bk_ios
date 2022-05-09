//
//  LoginDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

protocol LoginDomainRepoProtocol{
    
    func login(with email: String, password: String, completion: @escaping (User?) -> Void)
    
}
