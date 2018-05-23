import HeliumLogger
import Kitura
import KituraStencil

/*
 A router lets you register functions/closures at endpoints.
 This example uses only one router, but you can create several and compose them.
 */
let router = Router()

/*
 Registers a handler for GET /hello that returns "Hello".
 As you can see, a route handler has three parameters:
 - The current request, from which you can read data.
 - The current response, which you can configure.
 - The next handler or middleware in the chain.
 Unless an error was thrown or you called `end()` on the response,
 your handler should end with `next()`.
 */
router.get("hello") {
    request, response, next in
    response.send("Hello")
    next()
}

private var message = Message(text: "Hello")

/*
 Registers a route handler for GET /message that returns the current message as JSON.
 Kitura relies on `Codable` to handle the JSON conversion.
 */
router.get("message") {
    request, response, next in
    response.send(json: message)
    next()
}

/*
 Registers a route handler for POST /message that sets the current message.
 The new message is sent in the request body as a JSON object.
 */
router.post("message") {
    request, response, next in
    guard let newMessage = try? request.read(as: Message.self) else {
        response.status(.badRequest)
        return next()
    }
    message = newMessage
    response.send(json: message)
    next()
}

/*
 Kitura can serve both static and dynamic web pages.
 This handler uses the Stencil template engine to render **Views/index.stencil**.
 The parameters used in the template are specified using a context dictionary.
 The next example will show higher-level rendering using `Codable` models.
 */
router.setDefault(templateEngine: StencilTemplateEngine())
router.get("/") {
    request, response, next in
    try response.render("index", context: ["message": message.text])
    next()
}

/*
 This registers a logger with Kitura which will log messages as requests are processed.
 If you want to see less messages, call `use(.warning)` instead to only log warnings and errors.
 */
HeliumLogger.use()

/*
 Once the router is set up, add a server and start it.
 Kitura will now wait for incoming requests and process them using the provided router.
 */
Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
