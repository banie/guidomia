//
//  LocalRequestInteractor.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

class LocalRequestInteractor: LocalRequestApi {
    func data(from filePath: URL) -> Result<Data, Error> {
        do {
            let data = try Data(contentsOf: filePath)
            return .success(data)
        } catch {
            print("not able to parse the filePath: \(filePath), error: \(error)")
            return .failure(error)
        }
    }
}
