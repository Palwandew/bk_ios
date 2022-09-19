//
//  ComplainGuestViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 19/09/2022.
//

import Foundation

class ComplainGuestViewModel: ObservableObject {
    
    private let useCase: ComplainGuestUseCase
    
    @Published var comments: String = ""
    
    @Published var toast: ToastViewModel = ToastViewModel()
    
    init(_ usecase: ComplainGuestUseCase){
        self.useCase = usecase
    }
    
    func lodgeComplainAgainst(_ guest: UnratedGuestViewModel?){

        guard let guest = guest else {
            return
        }
        
        let bookingID = guest.guest.bookingID
        let guestID = guest.userId
        let comments = self.comments
        useCase.lodgeComplainAgainst(guestID, for: bookingID, with: comments) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print(message)
                    self?.toast.prepare(for: ToastStyle.success, with: "Complain lodged successfully.")
                    self?.toast.show()
                    
                case .failure(let error):
                    print("Error occured \(error)")
                    self?.toast.prepare(for: ToastStyle.failure, with: "Error occured while lodging.")
                    self?.toast.show()
                }
                self?.objectWillChange.send()
            }
        }
    }
}
