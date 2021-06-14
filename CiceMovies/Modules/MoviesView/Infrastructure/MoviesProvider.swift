//
//  MoviesProvider.swift
//  CiceMovies
//
//  Created by cice on 11/06/2021.
//

import Foundation
import Combine

protocol MoviesProviderProtocol {
    func fetchMovies(completionHandler: @escaping (Result<AppleMoviesServerModel, NetworkingError>) -> ())
}

class MoviesProviderImpl: MoviesProviderProtocol {
    
    let provider: RequestManagerProtocol = RequestManager()
    var cancellable: Set<AnyCancellable> = []
    
    func fetchMovies(completionHandler: @escaping (Result<AppleMoviesServerModel, NetworkingError>) -> ()) {
        
        let request = RequestDTO(params: nil,
                                 method: .get,
                                 endpoint: URLEndpoint.endpointMovies,
                                 urlContext: .backend)
        
        self.provider.requestGeneric(requestDto: request, entityClass: AppleMoviesServerModel.self)
            .sink { [weak self] (completion) in
                guard self != nil else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    completionHandler(.failure(error))
                }
        } receiveValue: { [weak self] responseMoviesModel in
            guard self != nil else { return }
            completionHandler(.success(responseMoviesModel))
        }.store(in: &cancellable)
        
    }
}
