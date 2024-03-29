//
//  baskTests.swift
//  baskTests
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import XCTest
@testable import bask

class baskTests: XCTestCase {
    var error: String? = nil
    var url: URL? = nil
    
//    let sut: Endpoints
//    var useCase: CreateFacilityUseCase!
//    var repo: CreateFacilityDomainRepoProtocol!
    
    override func setUp() {
        super.setUp()
//        repo = CreateFacilityReopositoryImpl()
//        useCase = CreateFacilityUseCase(repository: repo)
//        sut = Endpoints()
    }
    
    override func tearDown() {
        super.tearDown()
        //useCase = nil
        //repo = nil
//        sut = nil
    }
    
    
//    static let CREATE_FACILITY: Endpoints = Endpoints(path: "facility", queryItems: nil)
//    static let CREATE_IMAGE_LINK: Endpoints = Endpoints(path: "image", queryItems: nil)
//    static let ADD_FREE_AMENITIES: Endpoints = Endpoints(path: "facilityservice/amenitiesfree")
//    static let ADD_PAID_AMENITIES: Endpoints = Endpoints(path: "facilityservice/amenitiesextra")
//    static func GET_SIGNED_URL(with query: [URLQueryItem]) -> Endpoints {
//     return Endpoints(path: "files/getpresignedurl", queryItems: query)
//    }
//
//    static func UPDATE_FACILITY(_ facilityID: String) -> Endpoints {
//        return Endpoints(path: "facility/\(facilityID)", queryItems: nil)
//    }

    func testExample() throws {
        
        
        let repo = PaymentMethodsProtocolImpl()
        let useCase = PaymentMethodUsecase(repo: repo)
        
        useCase.addPaymentMethod { [weak self] testResult in
            switch testResult {
                
            case .failure(let error):
                self?.error = error.localizedDescription
                XCTAssertNil(error)
                
            case .success(let url):
                self?.url = url
                print("\(url.absoluteString)")
                XCTAssertNotNil(url, url.absoluteString)
            }
        }
        
        
       
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
