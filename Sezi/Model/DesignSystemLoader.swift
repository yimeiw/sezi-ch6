//
//  DesignSystemLoader.swift
//  Sezi
//
//  Created by Yimei Winata on 14/09/26.
//
import Foundation

enum DesignSystemLoader {
    static func load<T: Decodable>(_ type: T.Type, filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("File \(filename).json missing")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Decode error: \(error)")
            return nil
        }
    }
}
