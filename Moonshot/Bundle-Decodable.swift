//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Joshua Rosado Olivencia on 12/3/24.
//

import Foundation



extension Bundle {

    func decode<T: Codable>(_ file: String) -> T {

        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }

        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
     
        do {

            return try decoder.decode(T.self, from: data)

        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key \(key.stringValue) - \(context.debugDescription)")

        }catch DecodingError.typeMismatch(let type, let context ){
            fatalError("Failed to decode \(file) from bundle due to type mismatch \(type) - \(context.debugDescription)")

        } catch DecodingError.valueNotFound(let type, let context ){
            fatalError("Failed to decode \(file) from bundle due to missing value \(type) - \(context.debugDescription)")

        }catch DecodingError.dataCorrupted(_){
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
            

        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    
    }
}


