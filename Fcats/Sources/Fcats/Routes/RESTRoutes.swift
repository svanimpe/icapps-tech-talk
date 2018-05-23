import Kitura
import KituraContracts

/**
 Query parameters used for paged requests.
 */
struct Page: QueryParams {
    
    /// The first element of the page.
    let first: Int
    
    /// The maximum number of elements to return.
    let size: Int
}

extension Routes {
    
    
    /**
     Adds the REST routes to the given router.
     
     These routes are examples of codable routing.
     With codable routing, Kitura handles the request and response for you.
     Your handler simply receives and returns a Codable (or an error).
     All codable handlers are asynchronous so they return their result via a completion handler.
     */
    func configureRESTRoutes(using router: Router) {
        router.post("races", handler: add)
        router.get("races", handler: getOne)
        router.get("races", handler: getAll)
    }
    
    /**
     Adds a `Race`.
     
     This is a typical POST handler that receives a codable and returns
     either a codable (on success) or an error.
     */
    private func add(race: Race, completion: (Race? , RequestError?) -> Void) {
        do {
            guard try persistence.race(forID: race.id) == nil else {
                return completion(nil, .badRequest)
            }
            try persistence.add(race)
            return completion(race, nil)
        } catch {
            return completion(nil, .internalServerError)
        }
    }
    
    /**
     Returns the `Race` with the given ID, or an error.
     
     Because this handler includes an identifier parameter, Kitura automatically adds
     an :id route parameter. The complete route for this handler is /api/race/:id.
     */
    private func getOne(id: Int, completion: (Race?, RequestError?) -> Void) {
        do {
            guard let race = try persistence.race(forID: id) else {
                return completion(nil, .notFound)
            }
            return completion(race, nil)
        } catch {
            return completion(nil, .internalServerError)
        }
    }
    
    /**
     Returns a list of races.
     
     This handler includes a `QueryParams` parameter that represents the route's query parameters.
     Decoding these parameters is, as always, done via `Codable`.
     
     Because the properties of `Page` are non-optional, the query parameters are required.
     The complete route for this handler is /api/races/?first=x&size=y.
     */
    private func getAll(page: Page, completion: ([Race]?, RequestError?) -> Void) {
        do {
            let results = try persistence.races(startingFrom: page.first, limitedTo: page.size)
            return completion(results, nil)
        } catch {
            return completion(nil, .internalServerError)
        }
    }
}
