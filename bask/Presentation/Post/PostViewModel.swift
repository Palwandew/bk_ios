//
//  PostViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

class PostViewModel: ObservableObject{
    
    @Published var posts: [Post] = []
    private let postUseCase: PostUseCase
    private let loginUseCase = LoginUseCase(loginRepository: LoginRepositoryImp())
    
    init(postUseCase: PostUseCase){
        self.postUseCase = postUseCase
    }
    
    func login(){
        self.loginUseCase.login() { (user) in
            DispatchQueue.main.async {
                print("User--> \(String(describing: user))")
            }
        }
    }
    
    func getPosts() {
        self.postUseCase.getPosts() { [weak self] (postArray) in
            DispatchQueue.main.async {
                self?.posts = postArray
            }
        }
    }
}
