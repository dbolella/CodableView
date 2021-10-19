# CodableView

Library of Swiftui Views conforming to Codable, meaning we can produce JSON driven UI!

## Adding a CodableView Type
1. Create View that conforms to Codable in the CodableViews folder
2. Add new case for the view in the `CodableView` enum
3. Add case to the decode and encode functions
4. Create JSON file for testing the new CodableView
5. Add to MockJSON
