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
