//
//  CarListPresenter.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

class CarListPresenter: ObservableObject {
    
    @Published var items: [ListItem]
    
    var availableMakes: [String] {
        items.map { item in
            item.detail.make
        }
    }
    
    var availableModels: [String] {
        items.map { item in
            item.detail.model
        }
    }
    
    init() {
        
        do {
            let carList = try GetCarListInteractor().getListOfCarDetails() ?? []
            items = carList.map { carDetail in
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
            if var firstItem = items.first {
                firstItem.selected = true
                items[0] = firstItem
            }
        } catch {
            items = []
        }
    }
    
    func select(_ item: ListItem) {
        for i in 0..<items.count {
            items[i].selected = items[i].id == item.id ? true : false
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
