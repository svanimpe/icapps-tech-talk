import Kitura
import KituraStencil

/**
 This class represents the routing layer.
 
 Since routes are mostly stateless functions, they don't need to be implemented as types.
 Instead, they are simply methods, grouped into extensions on this type.
 Using only a single type makes it easy to inject dependencies, such as the persistence layer,
 that are required by all routing functions.
 */
public class Routes {
    
    let persistence: Persistence
    
    public init(persistence: Persistence) {
        self.persistence = persistence
    }
    
    /**
     Adds the app's routes to the given router.
     */
    public func configure(using router: Router) {
        
        // Sets up the REST routes.
        // `router.route` creates a subrouter.
        // All routes configured on this subrouter will have the prefix **/api**.
        configureRESTRoutes(using: router.route("api"))
        
        // Registers the Stencil template engine.
        router.setDefault(templateEngine: StencilTemplateEngine())
        
        // Sets up a static file server.
        // This will serve all files in the **public** directory (which is the default) at the endpoint /public.
        router.all("public", middleware: StaticFileServer())
        
        // Sets up the web routes.
        configureWebRoutes(using: router)
    }
}
