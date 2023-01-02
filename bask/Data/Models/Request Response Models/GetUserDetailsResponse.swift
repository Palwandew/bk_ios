//
//  GetUserProfileResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation


// MARK: - GetUserProfileResponse
struct GetUserProfileResponse: Codable {
    let data: UserProfileData
    let error: Bool
    let message: String
}

// MARK: - UserProfileData
struct UserProfileData: Codable {
    let user: UserProfile
}

// MARK: - UserProfile
struct UserProfile: Codable {
    let id, fullName: String
    let city: String?
    let email: String?
    let mobileNumber: String?
    let provider: String?
    let photo: String?
    let appUsage: String?
    let verifiedStatus: Bool
    let signUpWith, status, createdAt, updatedAt: String
    let wallet: UserWallet
    let role: UserRole
    let bookings: [Booking]?

    enum CodingKeys: String, CodingKey {
        case id, fullName, city, email, mobileNumber, provider, photo
        case appUsage = "app_usage"
        case verifiedStatus = "verified_status"
        case signUpWith = "sign_up_with"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case wallet, role, bookings
    }
    
    func dotUserEntity() -> User{
        return User(fullName: "asf", email: "asf", password: "asf", type: .guest)
    }
}

// MARK: - UserRole
struct UserRole: Codable {
    let id: Int
    let role, roleName: String
    let permissions: [UserPermission]

    enum CodingKeys: String, CodingKey {
        case id, role
        case roleName = "role_name"
        case permissions
    }
}

// MARK: - UserPermission
struct UserPermission: Codable {
    let id: Int
    let path: String
    let roleID: Int

    enum CodingKeys: String, CodingKey {
        case id, path
        case roleID = "role_id"
    }
}

// MARK: - Wallet
struct UserWallet: Codable {
    let id: Int
    let userID: String
    let balance, pending, totalPaid, totalEarned: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case balance, pending
        case totalPaid = "total_paid"
        case totalEarned = "total_earned"
    }
}
