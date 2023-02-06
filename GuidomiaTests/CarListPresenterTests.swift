//
//  CarListPresenterTests.swift
//  GuidomiaTests
//
//  Created by Banie Setijoso on 2023-02-06.
//

import XCTest
@testable import Guidomia

final class CarListPresenterTests: XCTestCase {
    
    private var getApiMock: GetCarListApiMock!
    private var presenter: CarListPresenter!
    
    private let carDetails = [
        CarDetail(model: "model1", make: "make1", customerPrice: 123, marketPrice: 456, prosList: ["pro1a, pro1b"], consList: ["cons1a, cons1b"], rating: 2),
        CarDetail(model: "model2", make: "make2", customerPrice: 789, marketPrice: 012, prosList: ["pro2a, pro2b"], consList: ["cons2a, cons2b"], rating: 5)]
    
    override func setUpWithError() throws {
        getApiMock = GetCarListApiMock()
        getApiMock.carDetails = carDetails
        presenter = CarListPresenter(getCarListFromResource: getApiMock, getCarListFromCoreData: getApiMock)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit() throws {
        XCTAssertEqual(2, presenter.items.count)
        XCTAssertEqual(CarListPresenter.anySelection, presenter.selectedMake)
        XCTAssertEqual(CarListPresenter.anySelection, presenter.selectedModel)
        XCTAssertEqual(["All", "make1", "make2"], presenter.availableMakes)
        XCTAssertEqual(["All", "model1", "model2"], presenter.availableModels)
        XCTAssertTrue(presenter.items.first?.selected ?? false)
        XCTAssertFalse(presenter.items[1].selected)
        
        XCTAssertEqual("model1", presenter.items[0].detail.model)
        XCTAssertEqual("make1", presenter.items[0].detail.make)
        XCTAssertEqual(123, presenter.items[0].detail.customerPrice)
        XCTAssertEqual(456, presenter.items[0].detail.marketPrice)
        XCTAssertEqual(["pro1a, pro1b"], presenter.items[0].detail.prosList)
        XCTAssertEqual(["cons1a, cons1b"], presenter.items[0].detail.consList)
        XCTAssertEqual(2, presenter.items[0].detail.rating)
        
        XCTAssertEqual("model2", presenter.items[1].detail.model)
        XCTAssertEqual("make2", presenter.items[1].detail.make)
        XCTAssertEqual(789, presenter.items[1].detail.customerPrice)
        XCTAssertEqual(012, presenter.items[1].detail.marketPrice)
        XCTAssertEqual(["pro2a, pro2b"], presenter.items[1].detail.prosList)
        XCTAssertEqual(["cons2a, cons2b"], presenter.items[1].detail.consList)
        XCTAssertEqual(5, presenter.items[1].detail.rating)
    }
    
    func testFilterModel() throws {
        presenter.selectedModel = "model2"
        presenter.selectedMake = CarListPresenter.anySelection
        
        XCTAssertEqual(1, presenter.items.count)
        XCTAssertEqual("model2", presenter.items[0].detail.model)
        XCTAssertEqual("make2", presenter.items[0].detail.make)
        XCTAssertEqual(789, presenter.items[0].detail.customerPrice)
        XCTAssertEqual(012, presenter.items[0].detail.marketPrice)
        XCTAssertEqual(["pro2a, pro2b"], presenter.items[0].detail.prosList)
        XCTAssertEqual(["cons2a, cons2b"], presenter.items[0].detail.consList)
        XCTAssertEqual(5, presenter.items[0].detail.rating)
    }
    
    func testFilterMake() throws {
        presenter.selectedMake = "make1"
        presenter.selectedModel = CarListPresenter.anySelection
        
        XCTAssertEqual(1, presenter.items.count)
        XCTAssertEqual("model1", presenter.items[0].detail.model)
        XCTAssertEqual("make1", presenter.items[0].detail.make)
        XCTAssertEqual(123, presenter.items[0].detail.customerPrice)
        XCTAssertEqual(456, presenter.items[0].detail.marketPrice)
        XCTAssertEqual(["pro1a, pro1b"], presenter.items[0].detail.prosList)
        XCTAssertEqual(["cons1a, cons1b"], presenter.items[0].detail.consList)
        XCTAssertEqual(2, presenter.items[0].detail.rating)
    }
    
    func testFilterBoth() throws {
        presenter.selectedMake = "make1"
        presenter.selectedModel = "model1"
        
        XCTAssertEqual(1, presenter.items.count)
        
        presenter.selectedMake = "make2"
        presenter.selectedModel = "model2"
        
        XCTAssertEqual(1, presenter.items.count)
        
        presenter.selectedMake = "make1"
        presenter.selectedModel = "model2"
        
        XCTAssertEqual(0, presenter.items.count)
    }
}
