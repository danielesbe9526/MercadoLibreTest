//
//  MercadoLibreAppUITests.swift
//  MercadoLibreAppUITests
//
//  Created by Daniel Beltran😎 on 28/10/20.
//

import XCTest

class MercadoLibreAppUITests: XCTestCase {
    
    func testSearchItem() {
        
        let app = XCUIApplication()
        app.launch()
        let search = app.searchFields["Search"]
        search.tap()
        search.typeText("Silla")
        
        let tablesQuery = app.tables
        let cell = tablesQuery.cells.firstMatch
        
        XCTAssertTrue(cell.exists)
        
        cell.tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        
        XCTAssertTrue(elementsQuery.staticTexts["Cantidad:"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Informacion del vendedor"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["Caracteristicas"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["Ubicacion"].exists)
    }
    
    func testItemDetail() {
        let app = XCUIApplication()
        app.launch()
        let search = app.searchFields["Search"]
        search.tap()
        search.typeText("Carro")
        
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        
        XCTAssertTrue(elementsQuery.staticTexts["Cantidad:"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Informacion del vendedor"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["Caracteristicas"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["Ubicacion"].exists)
    }
    
    func testCategorySections() {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        
        let verticalScrollBar6PagesCollectionView = collectionViewsQuery.containing(.other, identifier:"Vertical scroll bar, 6 pages").element
        verticalScrollBar6PagesCollectionView.swipeUp()
        
        XCTAssertTrue(verticalScrollBar6PagesCollectionView.exists)
    }
    
    func testEmptySearch() {
        let app = XCUIApplication()
        app.launch()
        let search = app.searchFields["Search"]
        search.tap()
        search.typeText("A")

        let tittle =  app.staticTexts["No  encontramos publicaciones "]
        let subtittle = app.staticTexts["Revisa que la palabra este bien escrita  Tambien puedes probar con menos terminos o mas generales."]
        
        XCTAssertTrue(tittle.exists)
        XCTAssertTrue(subtittle.exists)
    }
    
    func testHideTableOnCancelButton(){
        
        let app = XCUIApplication()
        app.launch()
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("qwerty")
        
        let tablesQuery = app.tables
                
        app.staticTexts["Cancel"].tap()
           
        XCTAssertTrue(!tablesQuery.cells.firstMatch.exists)
        
        searchSearchField.tap()
        
        XCTAssertTrue(!tablesQuery.cells.firstMatch.exists)
    }
}
