//
//  ServiceAPICall.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation
import RxSwift

protocol ServiceAPICallProtocol {
    func request<T: Decodable>(requestURL: String, type: T.Type) -> Single<Result<T, NetworkError>>
}

final class ServiceAPICall: ServiceAPICallProtocol {

    // MARK: - Private Methods

    private let session: URLSessionProtocol

    // MARK: - Initializer

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    // MARK: - Internal Methods

    func request<T: Decodable>(requestURL: String, type: T.Type) -> Single<Result<T, NetworkError>> {
        return Single.create { single in
            guard let url = URL(string: requestURL) else {
                single(.success(.failure(NetworkError.urlError)))
                return Disposables.create()
            }

            let task = self.session.requestData(with: url) { data, response, error in
                if error != nil, let localizedError = error?.localizedDescription {
                    single(.success(.failure(NetworkError.genericError(error: localizedError))))
                }

                if let httpResponse = response as? HTTPURLResponse,
                   !(200..<400).contains(httpResponse.statusCode) {
                    single(.success(.failure(NetworkError.httpResponseError(statusCode: httpResponse.statusCode))))
                }

                do {
                    if let data {
                        let decodedObject = try JSONDecoder().decode(type.self, from: data)
                        single(.success(.success(decodedObject)))
                    }
                } catch {
                    single(.success(.failure(NetworkError.decodeError)))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
