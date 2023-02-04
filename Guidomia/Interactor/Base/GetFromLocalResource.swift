//
//  GetFromLocalResource.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

class GetFromLocalResource {
    let fileName: String
    let localRequestApi: LocalRequestApi
    let decoder: JSONDecoder
    
    init(fileName: String, localRequestApi: LocalRequestApi) {
        self.fileName = fileName
        self.localRequestApi = localRequestApi
        decoder = JSONDecoder()
    }
    
    func get<T>() throws -> T? where T: Decodable {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        let url = URL(fileURLWithPath: path)
        let result = localRequestApi.data(from: url)
        
        switch result {
        case .success(let data):
            return try decoder.decode(T.self, from: data)
        case .failure(_):
            return nil
        }
    }
}
