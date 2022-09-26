//
//  PaymentMethodsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class PaymentMethodsViewModel: ObservableObject {
    
    private let useCase: PaymentMethodUsecase
    
    @Published var state: ScreenState = .loading
    @Published var methods: [PaymentCardViewModel] = []
    @Published var addPaymentMethodURL: URL? = nil
    @Published var showWebView: Bool = false
    @Published var willPerformDeletion: Bool = false 
    @Published var toast: ToastViewModel = ToastViewModel()
    
    private var cardToDelete: PaymentCardViewModel? = nil
    
    init(_ useCase: PaymentMethodUsecase){
        self.useCase = useCase
        getPaymentMethods()
    }
    
    private func getPaymentMethods(){
        useCase.getPaymentMethods { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cards):
                    print("Cards \(cards)")
                    self?.methods = cards.map(PaymentCardViewModel.init)
                    self?.state = .success
                case .failure(_):
                    self?.state = .failed
                    print("error occured")
                }
            }
        }
    }
    
    func updatePaymentMethodsList() {
        getPaymentMethods()
    }
    
    func addPaymentMethod(){
        willPerformDeletion.toggle()
        useCase.addPaymentMethod { [weak self] result in
            DispatchQueue.main.async {
                self?.willPerformDeletion.toggle()
                switch result {
                case .success(let url):
                    self?.addPaymentMethodURL = url
                    self?.showWebView = true
                case .failure(_):
                    self?.toast.prepare(for: .success, with: "Error occured. Please try again")
                    self?.toast.show()
                    print("error")
                }
            }
        }
    }
    
    func deleteCard(_ card: PaymentCardViewModel){
        cardToDelete = card 
    }
    
    func deleteConfirmation(){
     
        guard let cardToDelete = cardToDelete else {
            return
        }
        
        let cardID = String(cardToDelete.id)
        willPerformDeletion.toggle()
        useCase.deleteCard(with: cardID) { [weak self] result in
            DispatchQueue.main.async {
                self?.willPerformDeletion.toggle()
                switch result {
                case .success(_):
                    self?.methods.removeAll{$0.id == cardToDelete.id}
                    self?.toast.prepare(for: .success, with: "Payment method has been deleted.")
                    self?.toast.show()
                case .failure(_):
                    self?.toast.prepare(for: .failure, with: "Error while deleting the payment method. Please try again.")
                    self?.toast.show()
                }
                self?.objectWillChange.send()
            }
        }
    }
}

struct PaymentCardViewModel: Identifiable {
    let id: Int
    private let card: PaymentCard
    
    init(card: PaymentCard){
        self.card = card
        self.id = card.id
    }
    
    var type: String {
        return self.card.type.rawValue
    }
    
    var number: String {
        return self.card.number
    }
}
