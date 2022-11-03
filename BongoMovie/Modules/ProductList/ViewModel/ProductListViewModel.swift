//
//  PhotoSearchViewModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation

class ProductListViewModel {
    enum Section {
        case main
    }
    var searchText: String = ""
    var productModels: [ProductModel] = []
    var shouldLoadMoreData = false
    var page = 1
    var apiCalling = false
    
    private static let limit = 30
    
    func getParams() -> [String: Any] {
        return ["rakuten_query_parameters": ["keyword": searchText], "yahoo_query_parameters": ["query": searchText, "results": "\(ProductListViewModel.limit)"], "from_scheduler": false]
    }
    
    func searchProduct(onResult: @escaping (_ message: String?, _ error: String?) -> Void) {
        NetworkServices.shared.postRequest(type: ProductListResponseModel.self, endPoint: APIConstants.productSearchEndPoint, params: getParams()) {[weak self] value, error in
            if value != nil { // success
                if value?.success == true {
                    let message = "default message"
                    self?.productModels = value?.products ?? []
                    self?.shouldLoadMoreData = (value?.products?.count ?? 0) >= ProductListViewModel.limit
                    self?.page = 2
                    onResult(message, nil)
                }
                else { // no data found
                    let errorMsg = value?.errorDetails?.first?.message ?? "default error"
                    print("errorMsg: \(errorMsg)")
                    onResult(nil, errorMsg)
                }
            }
            else { // error
                let errorMsg = error?.localizedDescription ?? "error"
                print("errorMsg: \(errorMsg)")
                onResult(nil, errorMsg)
            }
        }
    }
    
    func loadMoreProduct(onResult: @escaping (_ message: String?, _ error: String?) -> Void) {
        
        NetworkServices.shared.postRequest(type: ProductListResponseModel.self, endPoint: APIConstants.productSearchEndPoint, params: getParams()) {[weak self] value, error in
            if value != nil { // success
                if value?.success == true {
                    let message = "default message"
                    self?.productModels.append(contentsOf: value?.products ?? [])
                    self?.shouldLoadMoreData = (value?.products?.count ?? 0) >= ProductListViewModel.limit
                    self?.page = (self?.page ?? 1) + 1
                    onResult(message, nil)
                }
                else { // no data found
                    let errorMsg = value?.errorDetails?.first?.message ?? "default error"
                    print("message: \(errorMsg)")
                    onResult(nil, errorMsg)
                }
            }
            else { // error
                let errorMsg = error?.localizedDescription ?? "error"
                print("errorMsg: \(errorMsg)")
                onResult(nil, errorMsg)
            }
        }
    }
}
