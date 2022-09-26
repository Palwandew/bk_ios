//
//  PaymentMethodsProtocolImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class PaymentMethodsProtocolImpl: PaymentMethodProtocol {
    
    
    
    
    
    let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NDE2MjQ1MywiZXhwIjoxNjY0NTk0NDUzfQ.fyPMLalXuhJIdQc8--1VzUgrpUlJfAzoNIJyomopV_4", "Content-Type":"application/json; charset=utf-8"]
    
    func addPaymentMethod(completion: @escaping (Result<URL, Error>) -> Void) {

        let endpoint = Endpoints(path: "paymentmethod/getpaymenturl")
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: AddPaymentMethodResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                
                guard let url = URL(string: response.data.response.redirectURL) else {
                    return completion(.failure(RequestError.unknown("Unknown error occured.")))
                }
                
                completion(.success(url))
            }
        }
    }
    
    func getAllPaymentMethods(completion: @escaping (Result<[PaymentCard], Error>) -> Void) {
        
        let endpoint = Endpoints(path: "paymentmethod")
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: PaymentMethodsResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.cards()))
            }
        }
    }
    
    func deletePaymentMethod(with ID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints(path: "paymentmethod/\(ID)")
        
        URLSession.shared.deleteRequest(endpoint: endpoint, headers: header) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response))
            }
        }
    }
    
}
