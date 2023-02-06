//
//  GetCarListFromResourceTests.swift
//  GuidomiaTests
//
//  Created by Banie Setijoso on 2023-02-03.
//

import XCTest
@testable import Guidomia

final class GetCarListFromResourceTests: XCTestCase {
    
    private var apiMock: LocalRequestApiMock!
    private var interactor: GetCarListFromResource!

    override func setUpWithError() throws {
        apiMock = LocalRequestApiMock()
        interactor = GetCarListFromResource(localRequestApi: apiMock)
    }

    override func tearDownWithError() throws {
        apiMock.dataResult = nil
    }

    func testDecoding() throws {
        let sampleResponse = """
        [
           {
              "consList":[
                 "You can heard the engine over children cry at the back",
                 "",
                 "You may lose this one if you divorce"
              ],
              "customerPrice":65000.0,
              "make":"BMW",
              "marketPrice":55900.0,
              "model":"3300i",
              "prosList":[
                 "Your average business man car",
                 "Can bring the family home safely",
                 "The city must have"
              ],
              "rating":5
           }
        ]
        """.data(using: .utf8)!
        
        apiMock.dataResult = .success(sampleResponse)
        
        let carList = try interactor.getListOfCarDetails()
        XCTAssertEqual(1, carList?.count)
        XCTAssertEqual(3, carList?.first?.consList.count)
        XCTAssertEqual("You can heard the engine over children cry at the back", carList?.first?.consList.first)
        XCTAssertEqual("", carList?.first?.consList[1])
        XCTAssertEqual("You may lose this one if you divorce", carList?.first?.consList[2])
        XCTAssertEqual(65000.0, carList?.first?.customerPrice)
        XCTAssertEqual("BMW", carList?.first?.make)
        XCTAssertEqual(55900.0, carList?.first?.marketPrice)
        XCTAssertEqual("3300i", carList?.first?.model)
        XCTAssertEqual(3, carList?.first?.prosList.count)
        XCTAssertEqual("Your average business man car", carList?.first?.prosList.first)
        XCTAssertEqual("Can bring the family home safely", carList?.first?.prosList[1])
        XCTAssertEqual("The city must have", carList?.first?.prosList[2])
        XCTAssertEqual(5, carList?.first?.rating)
    }
}

