//
//  NetworkService.swift
//  XCANews
//
//  Created by Roman Rybachenko on 05.06.2022.
//

import Foundation
import SwiftyJSON

protocol PNetworkService {
    func getNews(for category: Category) async throws -> [Article]
}

class NetworkService: PNetworkService {
    // MARK: - Properties
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder
    
    // MARK: - Init
    init() {
        jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
    }
    // MARK: - Public funcs
    
    func getNews(for category: Category) async throws -> [Article] {
        guard let urlRequest = APIMethod.getNews(category: category).urlRequest
        else { throw AppError.custom("problem with URLRequest creating") }
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw AppError.noResponse }
        
        let json = JSON(data)
        pl("getNews response json: \n\(json)")
        
        switch httpResponse.statusCode {
        case (200...299), (400...499):
            let newsResponse = try jsonDecoder.decode(GetArticlesResponse.self, from: data)
            if newsResponse.status == .ok {
                return newsResponse.articles ?? []
            } else {
                throw AppError.custom(newsResponse.message ?? "Unknown server error")
            }
        default:
            throw AppError.custom("Unknown network error")
        }
    }

    // MARK: - Private funcs
    
//    private func request<D: Decodable>(with method: APIMethod, completion: @escaping (Result<D, AppError>) -> Void) {
//        guard let urlRequest = method.urlRequest else {
//            completion(.failure(AppError.defaultError))
//            return
//        }
//
//        pl("request.url = \n\(urlRequest.url?.absoluteString ?? ".. is nil")")
//
//        URLSession
//            .shared
//            .dataTask(with: urlRequest,
//                      completionHandler: { [weak self] data, response, error in
//                        guard let self = self else { return }
//
//                        guard self.isResponseValid(response),
//                            error == nil,
//                            let responseData = data
//                            else {
//                                self.handleFailure(with: data,
//                                                    response: response,
//                                                    error: error,
//                                                    completion: completion)
//                                return
//                        }
//
//                        let json = JSON(responseData)
//                        pl("\nrequest \(method) response: \n\(json)\n")
//
//                        if let serverError = try? JSONDecoder().decode(ServerError.self, from: responseData) {
//                            self.executeInMainThread(with: .failure(TMError(serverError: serverError)),
//                                                     completion: completion)
//                        } else {
//                            do {
//                                let decodedResponse = try Utils.jsonDecoder.decode(D.self, from: responseData)
//                                self.executeInMainThread(with: .success(decodedResponse), completion: completion)
//                            } catch let err {
//                                var message: String?
//                                if let decodingError = err as? DecodingError {
//                                    pl("Decoding error: \n\(decodingError)")
//                                    message = decodingError.localizedDescription
//                                }
//                                self.executeInMainThread(with: .failure(.parseResponseModel(message)), completion: completion)
//                            }
//                        }
//
//            })
//            .resume()
//    }
//
//    private func executeInMainThread<D: Decodable>(with result: Result<D, AppError>, completion:  @escaping (Result<D, AppError>) -> Void) {
//        DispatchQueue.main.async {
//            completion(result)
//        }
//    }
//
//    private func isResponseValid(_ response: URLResponse?) -> Bool {
//        guard let httpResponse = response as? HTTPURLResponse,
//            200..<300 ~= httpResponse.statusCode
//            else { return false }
//        return true
//    }

//    private func handleFailure<D: Decodable>(with data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<D, AppError>) -> Void) {
//        let statusCode = (response as? HTTPURLResponse)?.statusCode
//
//        if let errorData = data  {
//            do {
//                let serverErr = try JSONDecoder().decode(ServerError.self, from: errorData)
//                let apiError = AppError(serverError: serverErr)
//                executeInMainThread(with: .failure(apiError), completion: completion)
//            } catch let decodeError {
//                if let stCode = statusCode {
//                    let apiError = AppError(error: error, statusCode: stCode)
//                    executeInMainThread(with: .failure(apiError), completion: completion)
//                } else {
//                    pl("decode response error: \n\(decodeError.localizedDescription)")
//                    executeInMainThread(with: .failure(AppError.defaultError), completion: completion)
//                }
//            }
//        } else if let error = error {
//            pl("received error = \n\(error)")
//            let apiError = AppError(error: error, statusCode: statusCode)
//            executeInMainThread(with: .failure(apiError), completion: completion)
//        } else {
//            let apiError = AppError(error: error, statusCode: statusCode)
//            executeInMainThread(with: .failure(apiError), completion: completion)
//        }
//    }
}
