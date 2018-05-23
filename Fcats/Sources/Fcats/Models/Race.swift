import BSON

class Race: Codable {
    
    let id: Int
    let name: String
    var image: String
    var facts: [String]
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
        facts = []
    }
}

extension Race: Equatable {
    
    static func ==(lhs: Race, rhs: Race) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Race {
    
    /**
     Returns a BSON `Document` for the current instance.
     This is quite easy to do, as `Document` conforms to `ExpressibleByDictionaryLiteral`.
     All values in this document must conform to BSON's `Primitive` protocol.
     */
    var bson: Document {
        return [
            "_id": id,
            "name": name,
            "image": image,
            "facts": facts
        ]
    }
    
    /**
     Initializes a `Race` using a BSON `Document`.
     Returns `nil` when the document is invalid.
     In a real app, you'll want to throw an error instead.
     */
    convenience init?(bson: Document) {
        guard let id = Int(bson["_id"]),
              let name = String(bson["name"]),
              let image = String(bson["image"]),
              let facts = Array(bson["facts"])?.compactMap({ String($0) }) else {
            return nil
        }
        self.init(id: id, name: name, image: image)
        self.facts = facts
    }
}
