//
//  PhotoSearchViewModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation

class MovieDetailsViewModel {
    var movieDetails: MovieDetailsModel?
    var movieId: Int = 0
    
    func getParams() -> [String: Any] {
        return ["api_key": APIConstants.apiKey]
    }
    
    func getMovieDetails(onResult: @escaping (_ message: String?, _ error: String?) -> Void) {
        NetworkServices.shared.getRequest(type: MovieDetailsModel.self, endPoint: APIConstants.movieDetailsEndPoint + "\(self.movieId)", params: getParams()) {[weak self] value, error in
            if value != nil { // success
                if value?.statusCode == nil {
                    let message = "default message"
                    self?.movieDetails = value
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
    
    func getReleaseText() -> String {
        let genres = movieDetails?.genres?.reduce("", { partialResult, genre in
            return (partialResult ) + (" \(genre.name ?? "")" + ",")
        })
        return "\(movieDetails?.releaseDate?.convertTo(informat: DateFormatConstants.yyyy_mm_dd, outformat: DateFormatConstants.yyyy_mm_dd_slash) ?? "") (\(movieDetails?.productionCountries?.first?.iso ?? "")) • \(movieDetails?.runtime?.hourFormat ?? "")\n\(genres?.dropLast() ?? "")"
    }
}
