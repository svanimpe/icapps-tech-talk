import MongoKitten

/**
 This class represents the persistence layer.
 It holds a database connection and provides access to the database's collections.
 
 The actual persistence operations are provided by repositories.
 These repositories aren't implemented as types because they don't require any state.
 They consist entirely of functions, which is why they're implemented as extensions on this class.
 */
public class Persistence {
    
    let races: MongoKitten.Collection
    
    /**
     Initializes the persistence layer and connects to the database.
     */
    public init() throws {
        let settings = try ClientSettings("mongodb://localhost:27017/")
        let server = try Server(settings)
        let database = server["fcats"]
        races = database["races"]
    }
}
