//
//  LocalRequestApi.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import Foundation

public protocol LocalRequestApi {
    func data(from filePath: URL) -> Result<Data, Error>
}

public enum ApiError: Error {
    case urlIsInvalid
}
