import SwiftUI

@available(macOS 10.15, *)
enum CodableView: View, Codable {
    case row(Row)
    case table(Table)
    case navigation(Navigation)
    case unknown
    
    private enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
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
    
    func encode(to encoder: Encoder) throws {
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
    var body: some View {
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

@available(macOS 10.15, *)
extension CodableView: Identifiable {
    var id: ObjectIdentifier {
        ObjectIdentifier(CodableView.self)
    }
}

struct CodableView_Previews: PreviewProvider {
    @available(macOS 10.15.0, *)
    static var previews: some View {
        let sampleJSON = MockJSON.row.getJSON()
        let decoder = JSONDecoder()
        let codableView = try! decoder.decode(CodableView.self, from: sampleJSON)
        
        codableView
    }
}
