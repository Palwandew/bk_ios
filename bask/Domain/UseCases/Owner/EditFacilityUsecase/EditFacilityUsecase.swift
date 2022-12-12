//
//  EditFacilityUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/10/2022.
//

import Foundation

class EditFacilityUsecase: OwnerFacilityUsecaseProtocol {
    
    
    private let repository: EditFacilityRepositoryProtocol
    
    init(_ repo: EditFacilityRepositoryProtocol){
        self.repository = repo
    }
    
    func getRoomsData(for facilityID: String, completion: @escaping (Result<Facility, Error>) -> Void){
        //repository.getRoomsData(for: facilityID, completion: completion)
    }
    
    func updateFacility(with facilityID: String?, for step: FacilityCreationStep, with data: Encodable, completion: @escaping (Result<String, Error>) -> Void) {
    
    }
}
