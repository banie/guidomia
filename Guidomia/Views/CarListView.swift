//
//  CarListView.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import SwiftUI

struct CarListView: View {
    @ObservedObject var presenter = CarListPresenter()
    
    var body: some View {
                VStack {
                    Text("Guidomia")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    List {
                        Image("topHeader")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .listRowInsets(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                        
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
