//
//  SearchModel.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 29/10/

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let siteID: String?
    let query: String?
    let paging: Paging?
    let results: [Result]?
    let secondaryResults: [String]?
    let relatedResults: [String]?
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [AvailableFilter]?
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [AvailableFilterValue]?
}

// MARK: - AvailableFilterValue
struct AvailableFilterValue: Codable {
    let id: String?
    let name: String?
    let results: Int?
}

// MARK: - Sort
struct Sort: Codable {
    let id: String?
    let name: String?
}

// MARK: - Sort
struct Filter: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [FilterValue]?
}

// MARK: - FilterValue
struct FilterValue: Codable {
    let id: String?
    let name: String?
    let pathFromRoot: [Sort]?
}

// MARK: - Paging
struct Paging: Codable {
    let total: Int?
    let primaryResults: Int?
    let offset: Int?
    let limit: Int?
}

// MARK: - Result
struct Result: Codable {
    let id: String?
    let siteID: String?
    let title: String?
    let seller: Seller?
    let price: Int?
    let prices: Prices?
    let salePrice: String?
    let currencyID: String?
    let availableQuantity: Int?
    let soldQuantity: Int?
    let buyingMode: String?
    let listingTypeID: String?
    let stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnail: String?
    let acceptsMercadopago: Bool?
    let installments: Installments?
    let address: Address?
    let shipping: Shipping?
    let sellerAddress: SellerAddress?
    let attributes: [Attribute]?
    let originalPrice: Int?
    let categoryID: String?
    let officialStoreID: Int?
    let domainID: String?
    let catalogProductID: String?
    let tags: [String]?
    let orderBackend: Int?
    let differentialPricing: DifferentialPricing?
}

// MARK: - Address
struct Address: Codable {
    let stateID: String?
    let stateName: String?
    let cityID: String?
    let cityName: String?
}

// MARK: - Attribute
struct Attribute: Codable {
    let id: String?
    let name: String?
    let valueName: String?
    let values: [AttributeValue]?
    let attributeGroupID: String?
    let source: Int?
    let valueID: String?
    let valueStruct: Struct?
    let attributeGroupName: String?
}

// MARK: - Struct
struct Struct: Codable {
    let number: Int?
    let unit: String?
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let valueStruct: Struct?
    let source: Int?
}

// MARK: - DifferentialPricing

struct DifferentialPricing: Codable {
    let id: Int?
}

// MARK: - Installments
struct Installments: Codable {
    let quantity: Int?
    let amount: Double?
    let rate: Int?
    let currencyID: String?
}

// MARK: - Prices
struct Prices: Codable {
}

// MARK: - Seller
struct Seller: Codable {
    let id: Int?
    let permalink: String?
    let registrationDate: String?
    let carDealer: Bool?
    let realEstateAgency: Bool?
    let tags: [String]?
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    let id: String?
    let comment: String?
    let addressLine: String?
    let zipCode: String?
    let country: Sort?
    let state: Sort?
    let city: Sort?
    let latitude: String?
    let longitude: String?
}

// MARK: - Shipping
struct Shipping: Codable{
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?
}
