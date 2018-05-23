import Foundation

/**
 A view model for **fact.stencil**.
 
 A view model groups the properties needed for a particular view.
 These properties can be taken from multiple models.
 They can be transformed, localized, ... as needed for the view.
 
 This is ofcourse inspired by MVVM.
 */
struct FactViewModel: Codable {
    
    let id: Int
    let name: String
    let fact: String
    
    init(race: Race) {
        id = race.id
        name = race.name
        if !race.facts.isEmpty {
            let index = Int(arc4random_uniform(UInt32(race.facts.count)))
            fact = race.facts[index]
        } else {
            fact = "Little is known about these cats."
        }
    }
}
