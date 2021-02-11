//
//  BundleExtension.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import Foundation

extension Bundle {
    func decodeFile<T: Decodable>(name: String, extenson: String = "json") -> T? {
        guard let fileURL = url(forResource: name, withExtension: extenson) else {
            assertionFailure("👻: Could not find file with name: \(name).\(extenson) in bundle")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let modelObject = try JSONDecoder().decode(T.self, from: data)
            return modelObject
        } catch let error {
            assertionFailure("👻: Failed decoding resource: \(name).\(extenson): \(error.localizedDescription)")
            return nil
        }
    }
}
