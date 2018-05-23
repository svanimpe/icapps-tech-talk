import Kitura

extension Routes {

    /**
     Adds the web routes to the given router.
     */
    func configureWebRoutes(using router: Router) {
        router.get("/", handler: races)
        router.get("/races/:id", handler: fact)
    }
    
    /**
     Returns a list of races, rendered as **index.stencil**.
     
     Note how the rendering context is built. Instead of providing a dictionary,
     this handler provides an array of codables and attaches it to the key `races`.
     This is an example of codable rendering, a feature that will be available in Kitura 2.4.
     */
    private func races(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        try response.render("index", with: persistence.races(startingFrom: 1, limitedTo: 10), forKey: "races")
        next()
    }
    
    /**
     Returns a random fact about the selected race.
     
     This handler shows how to manually parse a route parameter.
     
     Like the previous handler, it also uses codable rendering.
     However, unlike the previous handler, it does not explicitly set a key.
     As a result, the rendering context will directly contain the codable's properties.
     
     Finally, this handler renders a view model (instead of a regular model type).
     */
    private func fact(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        guard let idString = request.parameters["id"],
              let id = Int(idString) else {
            response.statusCode = .badRequest
            return next()
        }
        guard let race = try persistence.race(forID: id) else {
            response.statusCode = .notFound
            return next()
        }
        try response.render("fact", with: FactViewModel(race: race))
        next()
    }
}
