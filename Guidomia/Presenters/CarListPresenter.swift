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

    init() {
        selectedMake = CarListPresenter.anySelection
        selectedModel = CarListPresenter.anySelection
        availableMakes = [CarListPresenter.anySelection]
        availableModels = [CarListPresenter.anySelection]

        do {
            let carList = try GetCarListInteractor().getListOfCarDetails() ?? []
            allItems = carList.map { carDetail in
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
        } catch {
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
    var id: String {
        detail.id
    }
    
    let detail: CarDetail
    var selected = false
}
