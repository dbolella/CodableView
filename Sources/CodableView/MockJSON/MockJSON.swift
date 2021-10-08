//
//  File.swift
//  
//
//  Created by Daniel Bolella on 10/8/21.
//

import Foundation

enum MockJSON: String {
    case row = "Row", table = "Table", navigation = "navigation"
    
    func getJSON() -> Data{
        guard let file = Bundle.main.url(forResource: self.rawValue, withExtension: "json") else { return Data() }
        return try! Data(contentsOf: file)
    }
}
