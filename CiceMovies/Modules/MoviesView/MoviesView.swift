//
//  MoviesView.swift
//  CiceMovies
//
//  Created by cice on 11/06/2021.
//

import SwiftUI

struct MoviesView: View {
    
    @ObservedObject var presenter = MoviesPresenterImpl()
    
    var body: some View { 
        List{
            ForEach(self.presenter.arrayMovies) { item in
                PosterCardArtworkView(model: item)
            }
        }
        .onAppear(perform: {
            self.presenter.fetchDataMovies()
        })
        .navigationTitle("Hola a todos")
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
