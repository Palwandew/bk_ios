//
//  LoginResponseModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

// MARK: - User
struct UserModel: Codable {
    let data: DataClass
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let token: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id, fullName, city, email: String
    let mobileNumber: String
    let provider: String?
    let createdAt, updatedAt, status: String
    let verifiedStatus: Bool
    let signUpWith: String
    let role: Role

    enum CodingKeys: String, CodingKey {
        case id, fullName, city, email, mobileNumber, provider
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status
        case verifiedStatus = "verified_status"
        case signUpWith = "sign_up_with"
        case role
    }
    
    func dotUserEntity() -> User{
        return User(id: id, fullName: fullName, city: city, phone: mobileNumber, email: email)
    }
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let role, roleName: String
    let permissions: [Permission]

    enum CodingKeys: String, CodingKey {
        case id, role
        case roleName = "role_name"
        case permissions
    }
}

// MARK: - Permission
struct Permission: Codable {
    let id: Int
    let path: String
    let roleID: Int

    enum CodingKeys: String, CodingKey {
        case id, path
        case roleID = "role_id"
    }
}
