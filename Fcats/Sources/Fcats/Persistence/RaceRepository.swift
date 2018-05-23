import MongoKitten

/**
 Persistence operations related to `Race`.
 */
extension Persistence {
    
    /**
     Adds a race to the database.
     Does nothing if a race for this ID already exists.
     */
    func add(_ race: Race) throws {
        guard try self.race(forID: race.id) == nil else {
            return
        }
        try races.insert(race.bson)
    }
    
    /**
     Returns the race with the given ID, or `nil` if this race doesn't exist.
     
     This method shows an example of MongoKitten's query expression syntax.
     The expression `"_id" == id` is equivalent to the query `["_id": id]`.
     For more complex expressions, you'll need to write the query as a dictionary,
     similar to how you'd write it in JavaScript.
     */
    func race(forID id: Int) throws -> Race? {
        guard let result = try races.findOne("_id" == id),
              let race = Race(bson: result) else {
            return nil
        }
        return race
    }
    
    /**
     Returns a list of races, sorted by ID.
     The list will start at ID `start` and contain at most `limit` results.
     
     This method shows an example of an aggregation pipeline.
     This pipeline filters the races based on their ID, sorts them and returns at most `limit` results.
     */
    func races(startingFrom start: Int, limitedTo limit: Int) throws -> [Race] {
        return try races.aggregate([
            .match("_id" >= start), // equivalent to `["_id": ["$gte": start]]`
            .sort(["_id": .ascending]),
            .limit(limit)
        ]).compactMap { Race(bson: $0) }
    }
}
