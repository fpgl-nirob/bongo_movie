//
//  PhotoSearchViewModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation

class TopRatedMoviesViewModel {
    var movieModels: [TopRatedMoviesModel] = []
    var page = 1
    var totalPages = 0
    var apiCalling = false
    
    private static let limit = 30
    
    func getParams() -> [String: Any] {
        return ["api_key": APIConstants.apiKey, "page": self.page]
    }
    
    func getMovieList(onResult: @escaping (_ message: String?, _ error: String?) -> Void) {
        self.page = 1
        NetworkServices.shared.getRequest(type: TopRatedMoviesListModel.self, endPoint: APIConstants.topRatedEndPoint, params: getParams()) {[weak self] value, error in
            if value != nil { // success
                if value?.statusCode == nil {
                    let message = "default message"
                    self?.movieModels = value?.movies ?? []
                    self?.totalPages = (value?.movies?.count ?? 0)
                    self?.page = 2
                    onResult(message, nil)
                }
                else { // no data found
                    let errorMsg = value?.statusMessage ?? "default error"
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
    
    func loadMoreMovies(onResult: @escaping (_ message: String?, _ error: String?) -> Void) {
        
        NetworkServices.shared.getRequest(type: TopRatedMoviesListModel.self, endPoint: APIConstants.topRatedEndPoint, params: getParams()) {[weak self] value, error in
            if value != nil { // success
                if value?.statusCode == nil {
                    let message = "default message"
                    self?.movieModels.append(contentsOf: value?.movies ?? [])
                    self?.page = (self?.page ?? 1) + 1
                    onResult(message, nil)
                }
                else { // no data found
                    let errorMsg = value?.statusMessage ?? "default error"
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
