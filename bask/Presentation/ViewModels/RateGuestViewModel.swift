//
//  RateGuestViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 18/09/2022.
//

import Foundation

class RateGuestViewModel: ObservableObject {
    
    private let useCase: RateGuestUsecase
    
    @Published var questionOne = Question(id: 1, star: 1)
    @Published var questionTwo = Question(id: 2, star: 1)
    @Published var questionThree = Question(id: 3, star: 1)
    @Published var questionFour = Question(id: 4, star: 1)
    @Published var questionFive = Question(id: 5, star: 1)
    
    @Published var comment: String = ""
    
    init(_ usecase: RateGuestUsecase){
        self.useCase = usecase
    }
    
    func saveRating(for guest: UnratedGuestViewModel?) {
        guard let guest = guest else {
            return
        }

        let requestBody = prepareRequestBody(guest: guest)
        useCase.saveRating(with: requestBody, completion: {result in
            switch result{
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            case .success(let message):
                print(message)
            }
        })
    }
    
    private func prepareRequestBody(guest: UnratedGuestViewModel) -> RateGuestRequestBody {
        let owner = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
        let body = RateGuestRequestBody(author: owner, ratedObject: guest.userId, bookingID: 306, rateGuestRequestBodyDescription: comment, rating: toGuestRatingModel())
        print("Body \(body)")
        return body
    }
    
    private func toGuestRatingModel() -> [RateGuestRating] {
        
        return [RateGuestRating(rubricID: questionOne.id, star: questionOne.star),
                RateGuestRating(rubricID: questionTwo.id, star: questionTwo.star),
                RateGuestRating(rubricID: questionThree.id, star: questionThree.star),
                RateGuestRating(rubricID: questionFour.id, star: questionFour.star),
                RateGuestRating(rubricID: questionFive.id, star: questionFive.star)]
    }
}
