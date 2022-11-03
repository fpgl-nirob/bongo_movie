//
//  UserServices.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation
import Alamofire

enum ApiState: String {
    case ok
    case fail
}

final class NetworkServices {
    static let shared = NetworkServices()
    
    func getHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = ["Accept": "application/json"]
        let secreteToken = AppManager.shared.getAuthorizationToken()
        if secreteToken != nil {
            headers[APIConstants.bearerKey] = "Bearer " + secreteToken!
        }
        print("headers::: \(headers)")
        return headers
    }
    
    func getFullUrl(endPoint: String) -> String {
        let url = "\(APIConstants.baseUrl)\(endPoint)"
        return url
    }
    
    private func apiRequest<T: Decodable>(type: T.Type, method: HTTPMethod, url: String, params: [String: Any]?, completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let decoder = JSONDecoder()
        AF.sessionConfiguration.timeoutIntervalForRequest = 30
        AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: getHeaders())
            .validate(statusCode: 200..<206)
            .responseDecodable(of: type, decoder: decoder) { response in
                completionHandler(response.value, response.error)
            }
    }
    
    func getRequest<T: Decodable>(type: T.Type, endPoint: String, params: [String: Any]?, completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let url = getFullUrl(endPoint: endPoint)
        print("url:: \(url)")
        apiRequest(type: type, method: .get, url: url, params: params) { value, error in
            completionHandler(value, error)
        }
    }
    
    func postRequest<T: Decodable>(type: T.Type, endPoint: String, params: [String: Any]?, completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let url = getFullUrl(endPoint: endPoint)
        print("params::: \(params!) url:: \(url)")
        apiRequest(type: type, method: .post, url: url, params: params!) { value, error in
            completionHandler(value, error)
        }
    }
    
    func putRequest<T: Decodable>(type: T.Type, endPoint: String, params: [String: Any]?, completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let url = getFullUrl(endPoint: endPoint)
        apiRequest(type: type, method: .put, url: url, params: params) { value, error in
            completionHandler(value, error)
        }
    }
    
    func patchRequest<T: Decodable>(type: T.Type, endPoint: String, params: [String: Any]?, completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let url = getFullUrl(endPoint: endPoint)
        apiRequest(type: type, method: .patch, url: url, params: params) { value, error in
            completionHandler(value, error)
        }
    }
    
    func deleteRequest<T: Decodable>(type: T.Type, endPoint: String, params: [String: Any]?, completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void) {
        let url = getFullUrl(endPoint: endPoint)
        apiRequest(type: type, method: .delete, url: url, params: params) { value, error in
            completionHandler(value, error)
        }
        
    }
    
    func upload<T: Decodable>(type: T.Type, endPoint: String, image: Data, params: [String: Any], completionHandler: @escaping (_ value: T?, _ error: Error?) -> Void, uploadProgress: @escaping (_ progress: Double) -> Void) {
        guard let url = URL(string: getFullUrl(endPoint: endPoint)) else {
            return
        }
        let decoder = JSONDecoder()
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(image, withName: "icon", fileName: "icon.jpeg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: getHeaders())
            .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
                uploadProgress(progress.fractionCompleted)
            })
            .validate(statusCode: 200..<206)
            .responseDecodable(of: type, decoder: decoder) { response in
                completionHandler(response.value, response.error)
            }
    }
}
