//
//  CarListView.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import SwiftUI

struct CarListView: View {
    let presenter = CarListPresenter()
    
    var body: some View {
        NavigationView {
            List {
                let carList = presenter.carList
                ForEach(carList) { carDetail in
                    Text(carDetail.model).font(.title)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Guidomia")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
