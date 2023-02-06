//
//  LocalRequestApiMock.swift
//  GuidomiaTests
//
//  Created by Banie Setijoso on 2023-02-06.
//

import Foundation
@testable import Guidomia

class LocalRequestApiMock: LocalRequestApi {
    var dataResult: Result<Data, Error>?
    
    func data(from filePath: URL) -> Result<Data, Error> {
        dataResult ?? .failure(NSError())
    }
}
