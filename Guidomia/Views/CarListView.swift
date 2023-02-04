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
            ZStack {
                Color("appPrimary")
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack{
                    Rectangle()
                        .frame(height: 0)
                        .background(Color("appPrimary"))
                    Image("topHeader")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 200
                        )
                    List {
                        let carList = presenter.carList
                        ForEach(carList) { carDetail in
                            HStack {
                                Image(carDetail.make + " - " + carDetail.model)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        maxWidth: 150,
                                        maxHeight: 50
                                    )
                                VStack(spacing: 2) {
                                    Text(carDetail.make + " - " + carDetail.model)
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(String(format: "Price: %@k", String(Int(carDetail.customerPrice / 1000))))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    HStack(spacing: 2) {
                                        let numOfStars: Int = carDetail.rating
                                        ForEach(1...numOfStars, id: \.self) { _ in
                                            Image(systemName: "star.fill")
                                        }
                                    }
                                    .padding(.top, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.yellow)
                                }
                                .padding(.leading, 10)
                            }
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .listStyle(.plain)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Guidomia")
                        .font(.largeTitle)
                        .foregroundColor(.white)
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
