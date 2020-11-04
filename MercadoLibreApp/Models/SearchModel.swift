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
    
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case query = "query"
        case paging = "paging"
        case results = "results"
        case secondaryResults = "secondary_results"
        case relatedResults = "related_results"
        case sort = "sort"
        case availableSorts = "available_sorts"
        case filters = "filters"
        case availableFilters = "available_filters"
    }
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [AvailableFilterValue]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case values = "values"
    }
}

// MARK: - AvailableFilterValue
struct AvailableFilterValue: Codable {
    let id: String?
    let name: String?
    let results: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case results = "results"
    }
}

// MARK: - Sort
struct Sort: Codable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - Sort
struct Filter: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [FilterValue]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case values = "values"
    }
}

// MARK: - FilterValue
struct FilterValue: Codable {
    let id: String?
    let name: String?
    let pathFromRoot: [Sort]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pathFromRoot = "path_from_root"
    }
}

// MARK: - Paging
struct Paging: Codable {
    let total: Int?
    let primaryResults: Int?
    let offset: Int?
    let limit: Int?
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case primaryResults = "primary_results"
        case offset = "offset"
        case limit = "limit"
    }
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
    let location: Location?
    let attributes: [Attribute]?
    let originalPrice: Int?
    let categoryID: String?
    let officialStoreID: Int?
    let domainID: String?
    let catalogProductID: String?
    let tags: [String]?
    let orderBackend: Int?
    let differentialPricing: DifferentialPricing?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case siteID = "site_id"
        case title = "title"
        case seller = "seller"
        case price = "price"
        case prices = "prices"
        case salePrice = "sale_price"
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case buyingMode = "buying_mode"
        case listingTypeID = "listing_type_id"
        case stopTime = "stop_time"
        case condition = "condition"
        case permalink = "permalink"
        case thumbnail = "thumbnail"
        case acceptsMercadopago = "accepts_mercadopago"
        case installments = "installments"
        case address = "address"
        case shipping = "shipping"
        case sellerAddress = "seller_address"
        case location = "location"
        case attributes = "attributes"
        case originalPrice = "original_price"
        case categoryID = "category_id"
        case officialStoreID = "official_store_id"
        case domainID = "domain_id"
        case catalogProductID = "catalog_product_id"
        case tags = "tags"
        case orderBackend = "order_backend"
        case differentialPricing = "differential_pricing"
    }
}

// MARK: - Address
struct Address: Codable {
    let stateID: String?
    let stateName: String?
    let cityID: String?
    let cityName: String?

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }
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

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case valueName = "value_name"
        case values = "values"
        case attributeGroupID = "attribute_group_id"
        case source = "source"
        case valueID = "value_id"
    }
}

// MARK: - Struct
struct Struct: Codable {
    let number: Int?
    let unit: String?
    
    enum CodingKeys: String, CodingKey {
        case unit = "unit"
        case number = "number"
    }
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let source: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case source = "source"
    }
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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case permalink = "permalink"
        case registrationDate = "registration_date"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case tags = "tags"
    }
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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case comment = "comment"
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case country = "country"
        case state = "state"
        case city = "city"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

// MARK: - Location
struct Location: Codable {
    let addressLine: String?
    let zipCode: String?
    let neighborhood: Sort?
    let city: Sort?
    let state: Sort?
    let country: Sort?
    let latitude: Double?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case neighborhood = "neighborhood"
        case city = "city"
        case state = "state"
        case country = "country"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

// MARK: - Shipping
struct Shipping: Codable{
    let freeShipping: Bool?
    let mode: String?
    let tags: [String]?
    let logisticType: String?
    let storePickUp: Bool?
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case mode = "mode"
        case tags = "tags"
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}
