//
//  Bundle+Extention.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import Foundation

extension Bundle {
    
    func decodeStubJSON<D: Decodable>(from filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
