//
//  baskTests.swift
//  baskTests
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import XCTest
@testable import bask

class baskTests: XCTestCase {

    
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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //let time = sut.getTime()
        //let showScreen = sut.willShowPriceSetupScreen
//        let paidAmen = Endpoints.ADD_PAID_AMENITIES
//        let freeAmen = Endpoints.ADD_FREE_AMENITIES
//        let image = Endpoints.CREATE_IMAGE_LINK
//        let facility = Endpoints.CREATE_FACILITY
        let bookedItem = Endpoints.GET_BOOKED_ITEM(with: [URLQueryItem(name: "booking_id", value: "308"), URLQueryItem(name: "facility_id", value: "123")])
        
        XCTAssertEqual(bookedItem.url?.absoluteString, "https://api.baskapp.co/api/v1/facility/bookeditem?booking_id=308&facility_id=123")
        
        XCTAssertNotEqual(bookedItem.url?.absoluteString, "hi")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
