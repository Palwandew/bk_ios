//
//  Rating.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

struct Rating {
    let author: String
    let guest: String
    let booking: String
    let comment: String
    var rating: [Question] {
        return self.generateQuestions()
    }
    
    
    
    private func generateQuestions() -> [Question] {
        
        var questions = [Question]()
        for i in 1..<6 {
            questions.append(Question(id: i, star: 1))
        }
        return questions
    }
}

struct Question{
    let id: Int
    let star: Int
}
