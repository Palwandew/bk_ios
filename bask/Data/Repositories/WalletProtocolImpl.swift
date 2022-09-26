//
//  WalletProtocolImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class WalletProtocolImpl: WalletRepositoryProtocol {
    
    let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NDE2MjQ1MywiZXhwIjoxNjY0NTk0NDUzfQ.fyPMLalXuhJIdQc8--1VzUgrpUlJfAzoNIJyomopV_4", "Content-Type":"application/json; charset=utf-8"]
    
    func getWallet(completion: @escaping (Result<Wallet, Error>) -> Void) {
        
        let endpoint = Endpoints(path: "wallet")
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: GetWalletStatusResponse.self) { result in
            switch result {
                
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.dotWalletEntity()))
            }
        }
    }
    
    
    
}
