import Kitura
import SwiftyRequest
import XCTest
@testable import Fcats

/**
 An example test case.
 
 Unfortunately, Kitura's routers aren't really unit testable.
 This means you'll need to use end-to-end testing instead.
 Fortunately, XCTest and SwiftyRequest make this fairly easy.
 
 You'll need to import the included database dump for this test to pass.
*/
class RESTRoutesTests: XCTestCase {

    func testGetAll() throws {
        let router = Router()
        try Routes(persistence: Persistence()).configureRESTRoutes(using: router.route("api"))
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.start()
        
        let responseReceived = expectation(description: "responseReceived")
        let request = RestRequest(url: "http://localhost:8080/api/races")
        request.queryItems = [
            URLQueryItem(name: "first", value: "0"),
            URLQueryItem(name: "size", value: "10")
        ]
        request.responseObject {
            (response: RestResponse<[Race]>) in
            switch response.result {
            case .success(let races):
                XCTAssert(races.count == 2)
                XCTAssert(races[0].name == "European Shorthair")
                XCTAssert(races[1].name == "Maine Coon")
            case .failure:
                XCTFail()
            }
            responseReceived.fulfill()
        }
        
        waitForExpectations(timeout: 5) {
            error in
            Kitura.stop()
            XCTAssertNil(error)
        }
    }
}
