//
//  MercadoLibreAppTests.swift
//  MercadoLibreAppTests
//
//  Created by Daniel Beltran😎 on 28/10/20.
//

import XCTest
@testable import MercadoLibreApp

class MercadoLibreAppTests: XCTestCase {

    let client = Client()
    let network = Network.shared
    let router = Router.getCategories
    let mockedRouter = MockedRouter.badUrl
    let mockedNetwork = MockedNetwork.shared

    func test_get_url_request() {
        guard let url = URL(string: "https://api.mercadolibre.com/sites/MCO/categories") else {
            XCTFail()
            return
        }
        
        XCTAssert(try router.request().url == url)
    }
    
    func test_fetch_categories() {
        let expectation = self.expectation(description: "succes expectation")
        var categories: Data?
        
        Network.shared.request(router: Router.getCategories) { (response) in
            switch response {
            case .succes(let objectResponse):
                categories = objectResponse
            case  .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(categories)
    }
    
    func test_fetch_ItemsByCategory() {
        let categoryId = "MCO1403"
        let expectation = self.expectation(description: "succes expectation")
        var Items: Data?
        
        Network.shared.request(router: Router.getItemsByCategory(category: categoryId)) { (response) in
            switch response {
            case .succes(let objectResponse):
                Items = objectResponse
            case  .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(Items)
    }
    
    func test_fetch_search() {
        let query = "Carro"
        let expectation = self.expectation(description: "succes expectation")
        var Items: Data?
        
        Network.shared.request(router: Router.filter(query: query)) { (response) in
            switch response {
            case .succes(let objectResponse):
                Items = objectResponse
            case  .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(Items)
    }
    
    func test_mocked_router() {
        do {
            let _ = try mockedRouter.request()
        } catch let error {
            XCTAssert(error as! ErrorType == ErrorType.paseUrlFail)
        }
    }
    
    func test_network(){
        MockedNetwork.shared.request(router: mockedRouter) { (response) in
            switch response {
            case .succes:
                XCTFail()
            case  .failure(let error):
                XCTAssert(error == ErrorType.notFound)
            }
        }
    }
}
