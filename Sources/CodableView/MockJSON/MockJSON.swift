//
//  File.swift
//  
//
//  Created by Daniel Bolella on 10/8/21.
//

import Foundation

/// An enum that represents types of `CodableViews` to retrieve mock JSON for that view.
public enum MockJSON: String {
    case row = "Row", table = "Table", navigation = "navigation"
    
    func getJSON() -> Data{
        guard let file = Bundle.main.url(forResource: self.rawValue, withExtension: "json") else { return Data() }
        return try! Data(contentsOf: file)
    }
}
