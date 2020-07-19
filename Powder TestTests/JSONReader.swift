//
//  JSONReader.swift
//  Powder TestTests
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit
import XCTest

class JSONReader: NSObject {
    
    static func readJSONFile(fileName: String) -> Data {
        let bundle = Bundle(for: JSONReader.self)
        let path = bundle.path(forResource: fileName, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        return data
    }
    
    static func buildModelFromFile<Model: Codable>(fileName: String, type: Model.Type) -> Model? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let data = readJSONFile(fileName: fileName)
            let parsedObject = try decoder.decode(type, from: data)
            return parsedObject
        } catch let DecodingError.keyNotFound(codingKey, context) {
            XCTAssert(true, "Json file cannot be parsed: codingKey: \(codingKey) debugDescription: \(context.debugDescription)")
            return nil
        } catch let DecodingError.valueNotFound(type, context) {
            XCTAssert(true, "Json file cannot be parsed: type: \(type) debugDescription: \(context.debugDescription)")
            return nil
        } catch let error {
            XCTAssert(true, "Json file cannot be parsed: error: \(error)")
            return nil
        }
    }
}
