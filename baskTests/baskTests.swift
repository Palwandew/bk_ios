//
//  baskTests.swift
//  baskTests
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import XCTest
@testable import bask

class baskTests: XCTestCase {

    
    var sut: AddNewUnitViewModel!
    var useCase: CreateFacilityUseCase!
    var repo: CreateFacilityDomainRepoProtocol!
    
    override func setUp() {
        super.setUp()
        repo = CreateFacilityReopositoryImpl()
        useCase = CreateFacilityUseCase(repository: repo)
        sut = AddNewUnitViewModel(useCase: useCase)
    }
    
    override func tearDown() {
        super.tearDown()
        useCase = nil
        repo = nil
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //let time = sut.getTime()
        //let showScreen = sut.willShowPriceSetupScreen
        sut.validateCheckInCheckOutTimings()
        let showScreen = sut.willShowPriceSetupScreen
        XCTAssertEqual(showScreen, true)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
