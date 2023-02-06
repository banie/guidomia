//
//  CarListPresenter.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

class CarListPresenter: ObservableObject {
    
    @Published var items: [ListItem]
    
    static var anySelection = "All"
    var selectedMake: String {
        didSet {
            updateBasedOnFilter()
        }
    }
    var selectedModel: String {
        didSet {
            updateBasedOnFilter()
        }
    }
    private(set) var availableMakes: [String]
    private(set) var availableModels: [String]
    private let allItems: [ListItem]
    
    private let getCarListFromResource: GetCarListApi
    private let getCarListFromCoreData: GetCarListApi
    private let saveCarListToCoreData: SaveCarListApi

    init(getCarListFromResource: GetCarListApi = GetCarListFromResource(),
         getCarListFromCoreData: GetCarListApi = GetCarListFromCoreData(objectContext: PersistenceController.shared.viewContext),
         saveCarListToCoreData: SaveCarListApi = SaveCarListToCoreData(objectContext: PersistenceController.shared.backgroundContext)) {
        
        self.getCarListFromResource = getCarListFromResource
        self.getCarListFromCoreData = getCarListFromCoreData
        self.saveCarListToCoreData = saveCarListToCoreData
        
        selectedMake = CarListPresenter.anySelection
        selectedModel = CarListPresenter.anySelection
        availableMakes = [CarListPresenter.anySelection]
        availableModels = [CarListPresenter.anySelection]

        do {
            let carList = try CarListPresenter.getCarList(getCarListFromResource, getCarListFromCoreData, saveCarListToCoreData)
            allItems = CarListPresenter.process(carList)
        } catch {
            print("not able to fetch car list, error: \(error)")
            allItems = []
        }
        
        items = allItems
        if var firstItem = items.first {
            firstItem.selected = true
            items[0] = firstItem
        }

        availableMakes.append(contentsOf: items.map { item in
            item.detail.make
        })

        availableModels.append(contentsOf: items.map { item in
            item.detail.model
        })
    }
    
    private static func getCarList(_ getCarListFromResource: GetCarListApi,
                            _ getCarListFromCoreData: GetCarListApi,
                            _ saveCarListToCoreData: SaveCarListApi) throws -> [CarDetail] {
        let carList: [CarDetail]
        let carListFromCoreData = try getCarListFromCoreData.getListOfCarDetails() ?? []
        
        if carListFromCoreData.isEmpty {
            carList = try getCarListFromResource.getListOfCarDetails() ?? []
            try saveCarListToCoreData.save(carList)
        } else {
            carList = carListFromCoreData
        }
        
        return carList
    }
    
    private static func process(_ carList: [CarDetail]) -> [ListItem] {
        return carList.map { carDetail in
            let cleanedPros = carDetail.prosList.map { pro in
                pro.trimmingCharacters(in: .whitespacesAndNewlines)
            }.filter { pro in
                pro.isEmpty == false
            }
            let cleanedCons = carDetail.consList.map { con in
                con.trimmingCharacters(in: .whitespacesAndNewlines)
            }.filter { con in
                con.isEmpty == false
            }
            
            let cleanCarDetail = CarDetail(model: carDetail.model, make: carDetail.make, customerPrice: carDetail.customerPrice, marketPrice: carDetail.marketPrice, prosList: cleanedPros, consList: cleanedCons, rating: carDetail.rating)
            
            return ListItem(detail: cleanCarDetail)
        }
    }
    
    func select(_ item: ListItem) {
        for i in 0..<items.count {
            items[i].selected = items[i].id == item.id ? true : false
        }
    }
    
    func updateBasedOnFilter() {
        if selectedMake == CarListPresenter.anySelection && selectedModel == CarListPresenter.anySelection {
            items = allItems
        } else if selectedModel == CarListPresenter.anySelection {
            items = allItems.filter{ item in
                item.detail.make == selectedMake
            }
        } else if selectedMake == CarListPresenter.anySelection {
            items = allItems.filter{ item in
                item.detail.model == selectedModel
            }
        } else {
            items = allItems.filter{ item in
                item.detail.model == selectedModel && item.detail.make == selectedMake
            }
        }
    }
}

struct ListItem: Identifiable {
    var id: UUID {
        detail.id
    }
    
    let detail: CarDetail
    var selected = false
}
