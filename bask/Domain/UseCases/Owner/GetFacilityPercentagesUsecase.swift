//
//  GetFacilityPercentagesUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation


class GetFacilityPercentagesUsecase{
    
    private let repository: FacilityDomainReopProtocol
    
    init(repo: FacilityDomainReopProtocol){
        self.repository = repo
    }
    
    func getOwnerFacilitiesPercentage(completion: @escaping (Result<[FacilityPercentage], Error>) -> Void){
        repository.getBaskCutForRenting(completion: completion)
    }
}
