//
//  PhotoListModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation

struct ProductListResponseModel: Decodable {
    let errorDetails: [ErrorDetails]?
    let success: Bool?
    let products: [ProductModel]?
    
    enum CodingKeys: String, CodingKey {
        case errorDetails = "detail"
        case success
        case products = "result"
    }
}

struct ErrorDetails: Decodable {
    let message: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "msg"
        case type
    }
}

struct ProductModel: Decodable, Hashable {
    var uuid = UUID()
    let itemId: AnyCodableValue?
    let title: AnyCodableValue?
    let description: AnyCodableValue?
    let headline: AnyCodableValue?
    let availability: AnyCodableValue?
    let affiliateRate: AnyCodableValue?
    let price: AnyCodableValue?
    let shopId: AnyCodableValue?
    let shopName: AnyCodableValue?
    let reviewCount: AnyCodableValue?
    let reviewAverage: AnyCodableValue?
    var genreId: AnyCodableValue?
    let shopUrl: AnyCodableValue?
    let itemUrl: AnyCodableValue?
    let imageUrls: [String]?
    let tags: [Int]?
    let shippingOverseas: AnyCodableValue?
    let condition: AnyCodableValue?
    let genreName: AnyCodableValue?
    let shopReviewCount: AnyCodableValue?
    let shopReviewAverage: AnyCodableValue?
    let platform: AnyCodableValue?
    
    enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
        case title
        case description
        case headline
        case availability
        case affiliateRate = "affiliate_rate"
        case price
        case shopId = "shop_id"
        case shopName = "shop_name"
        case reviewCount = "review_count"
        case reviewAverage = "review_average"
        case genreId = "genre_id"
        case shopUrl = "shop_url"
        case itemUrl = "item_url"
        case imageUrls = "image_urls"
        case tags
        case shippingOverseas = "shipping_overseas"
        case condition
        case genreName = "genre_name"
        case shopReviewCount = "shop_review_count"
        case shopReviewAverage = "shop_review_average"
        case platform
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(uuid)
    }

    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
      return lhs.uuid == rhs.uuid
    }
}
