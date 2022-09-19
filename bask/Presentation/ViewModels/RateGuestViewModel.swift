//
//  RateGuestViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 18/09/2022.
//

import Foundation

class RateGuestViewModel: ObservableObject {
    
    private let useCase: RateGuestUsecase
    
    
    @Published private(set) var isEditEnabled: Bool = false
    @Published var questions = [
                            Question(rubricId: 1, stars: 1),
                            Question(rubricId: 2, stars: 1),
                            Question(rubricId: 3, stars: 1),
                            Question(rubricId: 4, stars: 1),
                            Question(rubricId: 5, stars: 1) ]
    
    
    @Published var questionOne = Question(rubricId: 1, stars: 1)
    @Published var questionTwo = Question(rubricId: 2, stars: 1)
    @Published var questionThree = Question(rubricId: 3, stars: 1)
    @Published var questionFour = Question(rubricId: 4, stars: 1)
    @Published var questionFive = Question(rubricId: 5, stars: 1)
    
    @Published var comment: String = ""
    
    //Toast
    @Published var to: Bool = false 
    @Published var toast: ToastViewModel = ToastViewModel()
    
    init(_ usecase: RateGuestUsecase){
        self.useCase = usecase
    }
    
    func question(_ no: Int) -> Int {
        return questions[no].stars
    }
    
    func saveRating(for guest: UnratedGuestViewModel?) {
        guard let guest = guest else {
            return
        }
        
        if guest.isRated {
            // update the existing rating with id in Back-end
            guard let id = guest.guest.ratinginfo.first?.id else {
                return
            }
            useCase.updatePreviousRatingData(at: id, with: comment, and: questions) { [weak self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print("Error \(error.localizedDescription)")
                        self?.toast.prepare(for: ToastStyle.failure, with: "Error occured")
                        self?.toast.show()
                        self?.to = true 
                        
                    case .success(let message):
                        print(message)
                        self?.to = true
                        self?.toast.prepare(for: ToastStyle.success, with: "Rating has been updated successfully.")
                        self?.toast.show()
                    }
                }
            }
            
        } else {
            // create new rating in Back-end
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
        
    }
    
    func enableEditMode() {
        self.isEditEnabled = false 
    }
    
    func prepareDataToShow(for model: UnratedGuestViewModel?){
        guard let guest = model else {
            return
        }
        
        isEditEnabled = guest.isRated
        
        if guest.isRated {
            guard let previousRatingInfo = guest.guest.ratinginfo.first else {
                return
            }
            let id = String(previousRatingInfo.id)
            getPreviousRatingData(for: id)
        }
    }
    
    private func getPreviousRatingData(for id: String){
        
        useCase.getSingleRating(with: id) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let questions):
                    print("Previous rating")
                    self?.questions = questions
                case .failure(let error):
                    print("error")
                }
            }
        }
    }
    
    func setQuestionsStar(_ stars: [RatingStar]?){
        if let stars = stars {
            questionOne = Question(rubricId: 1, stars: stars[0].star)
            questionTwo = Question(rubricId: 2, stars: stars[1].star)
            questionThree = Question(rubricId: 3, stars: stars[2].star)
            questionFour = Question(rubricId: 4, stars: stars[3].star)
            questionFive = Question(rubricId: 5, stars: stars[4].star)
        }
        
    }
    
    func setComment(_ comment: String?) {
        if let comment = comment {
            self.comment = comment
        }
    }
    
    private func prepareRequestBody(guest: UnratedGuestViewModel) -> RateGuestRequestBody {
        let owner = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
        let body = RateGuestRequestBody(author: owner, ratedObject: guest.userId, bookingID: 306, rateGuestRequestBodyDescription: comment, rating: toGuestRatingModel())
        print("Body \(body)")
        return body
    }
    
    private func toGuestRatingModel() -> [RateGuestRating] {
        
        return [RateGuestRating(rubricID: questionOne.rubricId, star: questionOne.stars),
                RateGuestRating(rubricID: questionTwo.rubricId, star: questionTwo.stars),
                RateGuestRating(rubricID: questionThree.rubricId, star: questionThree.stars),
                RateGuestRating(rubricID: questionFour.rubricId, star: questionFour.stars),
                RateGuestRating(rubricID: questionFive.rubricId, star: questionFive.stars)]
    }
}

class ToastViewModel: ObservableObject {
    
    @Published var willShow: Bool = false
    @Published var style: ToastStyle = .success
    @Published var message: String = ""
    
    func prepare(for style: ToastStyle, with message: String){
        self.style = style
        self.message = message
    }
    
    func show() {
        self.willShow = true
    }
    
}
