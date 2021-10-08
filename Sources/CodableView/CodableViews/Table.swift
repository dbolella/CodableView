//
//  Table.swift
//  
//
//  Created by Daniel Bolella on 10/8/21.
//

import SwiftUI

struct Row: View, Codable {
    var id: UUID! = UUID()
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(subtitle)
        }
    }
}

struct Table: View, Codable {
    var rows: [CodableView]
    
    var body: some View {
        List(rows) { view in
            view
        }
    }
}

struct Table_Previews: PreviewProvider {
    static var previews: some View {
        let decoder = JSONDecoder()
        let decodedView = try! decoder.decode(CodableView.self, from: json)
        
        // Row
        decodedView
        
        // Table
        Table(rows: [decodedView])
    }
}
