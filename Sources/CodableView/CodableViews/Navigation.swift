//
//  Navigation.swift
//  
//
//  Created by Daniel Bolella on 10/8/21.
//

import SwiftUI

/// A view representing navigation.
public struct Navigation: View, Codable {
    var navigationTitle: String = ""
    var views: [CodableView]
    
    public var body: some View {
        NavigationView {
            List(views) { view in
                view
            }
        }
        .navigationTitle(navigationTitle)
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        let decoder = JSONDecoder()
        let decodedView = try! decoder.decode(CodableView.self, from: MockJSON.navigation.getJSON())
        
        Navigation(navigationTitle: "Hello World!", views: [decodedView])
    }
}
