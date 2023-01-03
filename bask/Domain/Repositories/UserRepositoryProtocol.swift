//
//  UserRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

/// The user repository class is a data storage class that stores and manages user information . It is designed to allow for easy retrieval and manipulation of user data and can be used to store and manage a variety of user information, including user names, email addresses, and other relevant details.
protocol UserRepositoryProtocol {
    
    func checkEmailAvailability(_ email: String, completion: @escaping (Result<EmailAvailabilityModel, RequestError>) -> Void)
    
    /// The signup method is a function that allows a user to create a new account..
    /// - Parameters:
    ///   - user: Current user.
    ///   - completion: Completion handler to return `ClientToken` struct as a successful response,
    ///         `RequestError` incase of any error.
    func signUp(user: User, completion: @escaping (Result<ClientToken, RequestError>) -> Void)
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void)
    
    func verifyUserPassword(_ currentPassword: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func updatePassword(_ newPassword: String, completion: @escaping (Result<String, Error>) -> Void)
}
