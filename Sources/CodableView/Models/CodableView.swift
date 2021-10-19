import SwiftUI

/// An enum that represents a number of SwiftUI views that can be represented in JSON.
///
/// Though SwiftUI is a powerful, declarative UI framework, it also means that our view hierarchies
/// can become quite complex. Though we can make a view easily conform to `Codable`, it does
/// not provide the actual context and knowledge of the type of view, itself. Hence, `CodableView`,
/// which assumes that the type is declared within the JSON structure, itself, providing the context
/// by which we can then parse out our views.
///
/// Here is an example of JSON we can expect:
///
/// ```json
/// {
/// "type": "row",
/// "title": "Hello...",
/// "subtitle": "...from JSON"
/// }
/// ```
public enum CodableView: View, Codable {
    case row(Row)
    case table(Table)
    case navigation(Navigation)
    case unknown
    
    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

       switch type {
        case "row":
            let decodedView = try Row(from: decoder)
            self = .row(decodedView)
       case "table":
           let decodedView = try Table(from: decoder)
           self = .table(decodedView)
       case "navigation":
           let decodedView = try Navigation(from: decoder)
           self = .navigation(decodedView)
        default:
            self = .unknown
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .row(let rowView):
          try container.encode("row", forKey: .type)
          try rowView.encode(to: encoder)
        case .table(let tableView):
          try container.encode("table", forKey: .type)
          try tableView.encode(to: encoder)
        case .navigation(let navigationView):
          try container.encode("navigation", forKey: .type)
          try navigationView.encode(to: encoder)
        case .unknown:
            return
        }
    }
    
    @ViewBuilder
    public var body: some View {
        switch self {
        case .row(let rowView):
            AnyView(rowView)
        case .table(let tableView):
            AnyView(tableView)
        case .navigation(let navigationView):
            AnyView(navigationView)
        case .unknown:
            EmptyView()
        }
    }
    
    func printOut() {
        let encoder = JSONEncoder()
        if let json = try? encoder.encode(self) {
            print(json.description)
            return
        }
        print("Error encoding")
    }
}

extension CodableView: Identifiable {
    public var id: ObjectIdentifier {
        ObjectIdentifier(CodableView.self)
    }
}

struct CodableView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleJSON = MockJSON.row.getJSON()
        let decoder = JSONDecoder()
        let codableView = try! decoder.decode(CodableView.self, from: sampleJSON)
        
        codableView
    }
}
