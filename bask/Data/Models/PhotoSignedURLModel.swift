//
//  PhotoSignedURLModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/08/2022.
//

import Foundation

// MARK: - PhotoSignedURLModel
struct PhotoSignedURLModel: Codable {
    let data: PhotoSignedURLDataClass
    let error: Bool
    let message: String
}

// MARK: - PhotoSignedURLDataClass
struct PhotoSignedURLDataClass: Codable {
    let uploadURL: String
    let filename: String
}
