//
//  MoviesPresenter.swift
//  CiceMovies
//
//  Created by cice on 11/06/2021.
//

import Foundation

protocol MoviesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func dataFromInteractor(data: [ResultMovies])
}

class MoviesPresenterImpl: BasePresenter, ObservableObject {
    
    @Published var arrayMovies: [ResultMovies] = []
    
    var interactor: MoviesInteractorInputProtocol? { return super.baseInteractor as? MoviesInteractorInputProtocol }
    
    func fetchDataMovies() {
        self.interactor?.fetchDataMoviesInteractor()
    }
}


extension MoviesPresenterImpl: MoviesInteractorOutputProtocol {
    func dataFromInteractor(data: [ResultMovies]) {
        self.arrayMovies = data
    }
}
