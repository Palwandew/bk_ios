//
//  AppDI.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

protocol AppDIProtocol {
    func postDependencies() -> PostViewModel
    
}

class AppDI: AppDIProtocol {
    
    static let shared = AppDI()
    
    func postDependencies() -> PostViewModel {
        let postDI: PostDI = PostDI()
        let postViewModel = postDI.postDependencies()
        
        return postViewModel
    }
    
    func signupDependencies() -> SignupViewModel {
        
        let localDataSourceDI: LocalSourceDI = LocalSourceDI()
        let signUpVM = localDataSourceDI.localDependencies()
        return signUpVM
    }
}


