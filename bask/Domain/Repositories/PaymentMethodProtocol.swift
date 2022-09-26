//
//  PaymentMethodProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

protocol PaymentMethodProtocol{
    
    func addPaymentMethod(completion: @escaping (Result<URL, Error>) -> Void)
    
    func getAllPaymentMethods(completion: @escaping (Result<[PaymentCard], Error>) -> Void)
    
    func deletePaymentMethod(with ID: String, completion: @escaping(Result<String, Error>) -> Void)
}
