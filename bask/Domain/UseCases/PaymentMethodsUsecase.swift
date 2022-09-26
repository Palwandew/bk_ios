//
//  PaymentMethodsUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class PaymentMethodUsecase {
    
    private let repository: PaymentMethodProtocol
    
    init(repo: PaymentMethodProtocol){
        self.repository = repo
    }
    
    func addPaymentMethod(completion: @escaping (Result<URL, Error>) -> Void){
        repository.addPaymentMethod(completion: completion)
    }
    
    func getPaymentMethods(completion: @escaping (Result<[PaymentCard], Error>) -> Void){
        repository.getAllPaymentMethods(completion: completion)
    }
    
    func deleteCard(with ID: String, completion: @escaping (Result<String, Error>) -> Void){
        repository.deletePaymentMethod(with: ID, completion: completion)
    }
}
