//
//  CarListView.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import SwiftUI

struct CarListView: View {
    @ObservedObject var presenter = CarListPresenter()
    
    @State private var selectedMake = CarListPresenter.anySelection
    @State private var selectedModel = CarListPresenter.anySelection
    
    var body: some View {
                VStack {
                    Text("Guidomia")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    List {
                        ZStack {
                            Image("topHeader")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            VStack(spacing: 10) {
                                Text("Tacoma 2021")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Text("Get yours now")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 20))
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .listRowInsets(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                        
                        VStack {
                            Text("Filters")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                            
                            Picker("Any make", selection: $selectedMake) {
                                ForEach(presenter.availableMakes, id: \.self) { make in
                                    Text(make)
                                        .font(.headline)
                                        .tag(make)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .tint(.white)
                            .foregroundColor(.white)
                            .onChange(of: selectedMake) { make in
                                presenter.selectedMake = make
                            }
                            
                            Picker("Any model", selection: $selectedModel) {
                                ForEach(presenter.availableModels, id: \.self) { model in
                                    Text(model)
                                        .font(.headline)
                                        .tag(model)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            .tint(.white)
                            .foregroundColor(.white)
                            .onChange(of: selectedModel) { model in
                                presenter.selectedModel = model
                            }
                        }
                        .background(Color("darkGray"))
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        ForEach(presenter.items) { item in
                            VStack {
                                HStack {
                                    Image(item.detail.make + " - " + item.detail.model)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: 150, maxHeight: 50)
                                    VStack(spacing: 2) {
                                        Text(item.detail.make + " - " + item.detail.model)
                                            .font(.title2)
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(String(format: "Price: %@k", String(Int(item.detail.customerPrice / 1000))))
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        HStack(spacing: 2) {
                                            let numOfStars: Int = item.detail.rating
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

                                if item.selected {
                                    VStack {
                                        let pros: [String] = item.detail.prosList
                                        let cons: [String] = item.detail.consList
                                        if pros.isEmpty == false {
                                            Text("Pros:")
                                                .font(.title2)
                                                .foregroundColor(.secondary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            ForEach(pros, id: \.self) { pro in
                                                HStack {
                                                    Image(systemName: "circle.fill")
                                                        .resizable()
                                                        .frame(maxWidth: 6, maxHeight: 6)
                                                        .foregroundColor(Color("appPrimary"))
                                                    Text(pro)
                                                        .font(.body)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                }
                                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                                            }
                                        }
                                        if cons.isEmpty == false {
                                            Text("Cons:")
                                                .font(.title2)
                                                .foregroundColor(.secondary)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            ForEach(cons, id: \.self) { con in
                                                HStack {
                                                    Image(systemName: "circle.fill")
                                                        .resizable()
                                                        .frame(minWidth: 4, maxWidth: 4, minHeight: 4, maxHeight: 4)
                                                        .foregroundColor(Color("appPrimary"))
                                                    Text(con)
                                                        .font(.body)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                }
                                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                                            }
                                        }
                                    }
                                }
                            }
                            .onTapGesture {
                                presenter.select(item)
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .listStyle(.plain)
                }
                .background(Color("appPrimary"))
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
