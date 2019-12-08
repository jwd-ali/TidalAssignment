//
//  HTTPClient.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation

class HTTPClient {
    // MARK: Typealias
    typealias CompletionResult = (Result<Data?, DeezerError>) -> Void
    
    // MARK: - Shared Instance
    static let shared = HTTPClient(session: URLSession.shared)
    
    // MARK: - Private Properties
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    private var completionResult: CompletionResult?
    
    // MARK: - Initialiser
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Data Task Helper
    func dataTask(_ request: HTTPRequestProtocol, completion: @escaping CompletionResult) {
        completionResult = completion
        let urlStr = Constants.Service.baseURL as NSString
        let url = URL(string: urlStr.appendingPathComponent(request.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))!
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: Constants.Service.timeout)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            //return error if there is any error in making request
            if let error = error {
                Print.error(try? JSONSerialization.jsonObject(with: data ?? Data(), options: .mutableContainers))
                Print.error(response)
                self.completionResult(.failure(DeezerError(error.localizedDescription)))
                return
            }
            //check response
            if let response = response, response.isSuccess {
                if let data = data {
                    self.completionResult(.success(data))
                }
                
                if response.httpStatusCode == 204 {
                    self.completionResult(.success(nil))
                }
            } else {
                let commonErrorMessage = NSLocalizedString("Somthing went wrong!", comment: "")
                guard let data = data else {
                    Print.error(commonErrorMessage)
                    self.completionResult(.failure(DeezerError(commonErrorMessage)))
                    return
                }
                do {
                    let serverError = try JSONDecoder().decode(HTTPError.self, from: data)
                    Print.error(serverError.error ?? commonErrorMessage)
                    self.completionResult(.failure(DeezerError(serverError.error ?? commonErrorMessage)))
                } catch {
                    Print.error(commonErrorMessage, error: error)
                    self.completionResult(.failure(DeezerError(commonErrorMessage)))
                }
            }
        }
        
        //Resume task
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private Helper Function
    private func completionResult(_ result: Result<Data?, DeezerError>) {
        DispatchQueue.main.async {
            self.completionResult?(result)
        }
    }
}

