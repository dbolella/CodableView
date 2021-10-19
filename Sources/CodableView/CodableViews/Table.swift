//
//  Table.swift
//  
//
//  Created by Daniel Bolella on 10/8/21.
//

import SwiftUI

/// A view representing a row.
///
/// This view represents a row that can be used in a ``Table``. It conforms to `Codable` and
/// is part of the ``CodableView`` enum.
///
/// - Parameters:
///     - title: Main text.
///     - subtitle: Underlying text.
public struct Row: View, Codable {
    var id: UUID! = UUID()
    var title: String
    var subtitle: String
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(subtitle)
        }
    }
}

/// A view representing a table.
///
/// This view represents a table. It conforms to `Codable` and is part of the ``CodableView`` enum.
///
/// - Parameters:
///     - rows: This takes an array of ``CodableView``, though we assume them to be of type ``Row``.
public struct Table: View, Codable {
    var rows: [CodableView]
    
    public var body: some View {
        List(rows) { view in
            view
        }
    }
}

struct Table_Previews: PreviewProvider {
    static var previews: some View {
        let decoder = JSONDecoder()
        let decodedView = try! decoder.decode(CodableView.self, from: MockJSON.row.getJSON())
        
        // Row
        decodedView
        
        // Table
        Table(rows: [decodedView])
    }
}
