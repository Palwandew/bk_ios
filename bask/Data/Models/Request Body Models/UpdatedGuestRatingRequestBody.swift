//
//  UpdateGuestPreviousRatingRequestBody.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 19/09/2022.
//

import Foundation

struct UpdatedGuestRatingRequestBody: Codable {
    let id: Int
    let description: String
    let rating: [RatingRubric] // Declared in SingleGuestRatingResponse

    enum CodingKeys: String, CodingKey {
        case id = "rating_info_id"
        case description = "description"
        case rating
    }
    
    static func fromDOTEntity(_ id: Int, _ comment: String, _ questions: [Question]) -> UpdatedGuestRatingRequestBody {
        
        let ratings = questions.map{ RatingRubric(star: $0.stars, id: $0.idFromDB ?? 0, rubricID: $0.rubricId)}
        
        return UpdatedGuestRatingRequestBody(id: id, description: comment, rating: ratings)
    }
    
}

